import subprocess
import shutil
from pathlib import Path
import runpy
from concurrent.futures import ThreadPoolExecutor, as_completed
import os
import argparse
import re

from corners.corners import CORNERS, generate_combined_corners


# ===============================
# Paths
# ===============================
PROJECT_ROOT = Path(__file__).resolve().parent
TB_DIR = PROJECT_ROOT / "tb"
NETLIST_ROOT = PROJECT_ROOT / "netlist"
RUNS_ROOT = PROJECT_ROOT / "runs"
POST_DIR = PROJECT_ROOT / "post"
SCRIPT_DIR = Path(__file__).resolve().parent
SPICEINIT = PROJECT_ROOT / ".spiceinit_"

# Symbol to toggle SCH / PEX
SYMBOL_PATH = PROJECT_ROOT / ".." /"Schematics_and_Symbols" / "OTA_Telescopic_TOP_wp.sym"


# ===============================
# Helpers
# ===============================
def set_symbol_type(sym_path, new_type):

    text = sym_path.read_text()

    text = text.replace(
        "K {type=subcircuit",
        f"K {{type={new_type}"
    ).replace(
        "K {type=primitive",
        f"K {{type={new_type}"
    )

    sym_path.write_text(text)



def generate_netlist_from_xschem(sch_path, corner, mode):
    nl_dir = NETLIST_ROOT / mode / corner
    nl_dir.mkdir(parents=True, exist_ok=True)

    netlist_name = "tb.spice"
    netlist_path = nl_dir / netlist_name

    xschemargs = [
        "xschem",
        "-n",
        "-s",
        "-r",
        "-x",
        "-q",
        "--rcfile", "./xschemrc",
        "-o", str(nl_dir),
        "-N", netlist_name,
        str(sch_path),
    ]

    subprocess.run(
        xschemargs,
        cwd=PROJECT_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=True,
    )

    return netlist_path


def patch_netlist(netlist, cfg, mode):

    lines = netlist.read_text().splitlines()
    patched = []

    for line in lines:

        # reemplazos de parámetros
        line = line.replace("$PROCESS", cfg["process"])
        line = line.replace("$VDD", str(cfg["vdd"]))
        line = line.replace("$TEMP", str(cfg["temp"]))

        # eliminar include de PEX en modo SCH
        if mode == "sch":
            if line.strip().lower().startswith(".inc") and "pex" in line.lower():
                continue

        patched.append(line)

    netlist.write_text("\n".join(patched) + "\n")


def run_ngspice(netlist, run_dir):

    run_dir.mkdir(parents=True, exist_ok=True)

    local_netlist = run_dir / netlist.name
    shutil.copy(netlist, local_netlist)

    if SPICEINIT.exists():
        shutil.copy(SPICEINIT, run_dir / ".spiceinit")

    log = run_dir / "ngspice.log"

    subprocess.run(
        ["ngspice", "-b", "-r", str(run_dir / "sim.raw"), str(local_netlist.name)],
        cwd=run_dir,
        stdout=log.open("w"),
        stderr=subprocess.STDOUT,
        check=True,
    )


def run_corner_task(sch_path, sch_name, mode, corner, cfg):

    print(f"▶ Starting {mode} corner {corner} for TB {sch_name}")

    netlist = generate_netlist_from_xschem(sch_path, corner, mode)

    patch_netlist(netlist, cfg, mode)

    run_dir = RUNS_ROOT / sch_name / mode / corner

    run_ngspice(netlist, run_dir)

    return f"{sch_name} - {mode} - {corner} done"


def run_postprocess(sch_name, post_mode):

    post_script = POST_DIR / f"{sch_name}.py"

    if not post_script.exists():
        print(f"▶ No postprocess for {sch_name}, skipping")
        return

    print(f"▶ Running postprocess: {post_script.name}")

    os.environ["POST_MODE"] = post_mode
    runpy.run_path(str(post_script), run_name="__main__")


def run_tb_summary(sch_name):

    summary_script = POST_DIR / "summary_tb.py"

    if not summary_script.exists():
        print("▶ No TB summary script found, skipping")
        return

    print(f"▶ Running TB summary for {sch_name}")

    old_argv = os.sys.argv
    os.sys.argv = [str(summary_script), sch_name]

    try:
        runpy.run_path(str(summary_script), run_name="__main__")
    finally:
        os.sys.argv = old_argv


def safe_run_postprocess(sch_name, post_mode):

    try:
        run_postprocess(sch_name, post_mode)
    except Exception as e:
        print(f"❌ Postprocess failed for {sch_name}: {e}")


def safe_run_tb_summary(sch_name):

    try:
        run_tb_summary(sch_name)
    except Exception as e:
        print(f"❌ TB summary failed for {sch_name}: {e}")


# ===============================
# Main
# ===============================
def main():

    parser = argparse.ArgumentParser(
        description="Run ngspice corners and/or postprocess"
    )

    parser.add_argument(
        "--combined",
        action="store_true",
        help="Run combined process/VDD/temp corners"
    )

    parser.add_argument(
        "--post-only",
        action="store_true",
        help="Run ONLY postprocessing (no simulations)"
    )

    parser.add_argument(
        "--no-show",
        action="store_true",
        help="Disable plt.show() in postprocess scripts"
    )

    parser.add_argument(
        "--sequential",
        action="store_true",
        help="Run simulations sequentially"
    )

    parser.add_argument(
        "--only-sch",
        action="store_true",
        help="Run only schematic simulations (skip PEX)"
    )

    args = parser.parse_args()

# ---------------------------
# Simulation mode selection
# ---------------------------
    if args.only_sch:
        modes = ["sch"]
        print("▶ Running ONLY SCH simulations")
    else:
        modes = ["sch", "pex"]

    # ---------------------------
    # Corner selection
    # ---------------------------
    if args.combined:
        corners = generate_combined_corners()
        post_mode = "combined"
        print(f"▶ Using COMBINED corners ({len(corners)} total)")
    else:
        corners = CORNERS
        post_mode = "classic"
        print(f"▶ Using CLASSIC corners ({len(corners)} total)")

    os.environ["NO_SHOW"] = "1" if args.no_show else "0"

    if args.post_only:

        print("▶ POST-ONLY mode enabled")

        for tb_run_root in sorted(RUNS_ROOT.iterdir()):

            if not tb_run_root.is_dir():
                continue

            sch_name = tb_run_root.name

            safe_run_postprocess(sch_name, post_mode)
            safe_run_tb_summary(sch_name)

        return

    NETLIST_ROOT.mkdir(exist_ok=True)
    RUNS_ROOT.mkdir(exist_ok=True)

    # Save original symbol
    original_sym = SYMBOL_PATH.read_text()

    try:

        for sch_path in TB_DIR.glob("*.sch"):

            sch_name = sch_path.stem

            print(f"\n▶ Processing schematic: {sch_name}")

            tb_run_root = RUNS_ROOT / sch_name

            if tb_run_root.exists():
                print(f"🧹 Cleaning previous runs for {sch_name}")
                shutil.rmtree(tb_run_root)

            tb_run_root.mkdir()

            for mode in modes:

                print(f"\n▶ Running mode: {mode}")

                if mode == "sch":
                    set_symbol_type(SYMBOL_PATH, "subcircuit")
                else:
                    set_symbol_type(SYMBOL_PATH, "primitive")

                if args.sequential:

                    print("▶ Running corners SEQUENTIALLY")

                    for corner, cfg in corners.items():

                        try:

                            msg = run_corner_task(
                                sch_path,
                                sch_name,
                                mode,
                                corner,
                                cfg
                            )

                            print(f"✔ {msg}")

                        except Exception as e:
                            print(f"❌ Error in {mode} corner {corner}: {e}")

                else:

                    max_threads = min(4, os.cpu_count())

                    print(f"▶ Running corners in PARALLEL with {max_threads} threads")

                    with ThreadPoolExecutor(max_workers=max_threads) as executor:

                        futures = {
                            executor.submit(
                                run_corner_task,
                                sch_path,
                                sch_name,
                                mode,
                                corner,
                                cfg
                            ): corner
                            for corner, cfg in corners.items()
                        }

                        for future in as_completed(futures):

                            corner = futures[future]

                            try:
                                print(f"✔ {future.result()}")
                            except Exception as e:
                                print(f"❌ Error in {mode} corner {corner}: {e}")

            safe_run_postprocess(sch_name, post_mode)
            safe_run_tb_summary(sch_name)

    finally:

        # Restore original symbol
        SYMBOL_PATH.write_text(original_sym)


if __name__ == "__main__":
    main()

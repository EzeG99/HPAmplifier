from pathlib import Path
import sys

# ===============================
# Paths
# ===============================
PROJECT_ROOT = Path(__file__).resolve().parents[1]
RUNS_ROOT = PROJECT_ROOT / "runs"
OUTPUT_DIR = PROJECT_ROOT / "post" / "tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


# ===============================
# Helpers
# ===============================
def parse_results_file(results_file: Path):
    """
    Parse results.txt format:
    <param> <value>
    """

    data = {}

    with open(results_file, "r") as f:
        for line in f:

            line = line.strip()

            if not line or line.startswith("#"):
                continue

            key, value = line.split()
            data[key] = value

    return data


def generate_mode_summary(tb_name: str, mode: str):

    mode_dir = RUNS_ROOT / tb_name / mode

    if not mode_dir.exists():
        print(f"⚠ No {mode} runs for {tb_name}")
        return

    corners_data = {}
    all_params = set()

    for corner_dir in sorted(mode_dir.iterdir()):

        if not corner_dir.is_dir():
            continue

        results_file = corner_dir / "results.txt"

        if not results_file.exists():
            print(f"⚠ {tb_name}/{mode}/{corner_dir.name}: no results.txt")
            continue

        data = parse_results_file(results_file)

        corners_data[corner_dir.name] = data
        all_params.update(data.keys())

    if not corners_data:
        print(f"⚠ No valid results for TB {tb_name} ({mode})")
        return

    corners = sorted(corners_data.keys())
    params = sorted(all_params)

    # ===============================
    # Print table
    # ===============================

    title = f"{tb_name} summary ({mode})"

    print()
    print(title)
    print("=" * len(title))

    header = f"{'Param':<12}"

    for c in corners:
        header += f"{c:>15}"

    print(header)
    print("-" * len(header))

    rows = []

    for p in params:

        line = f"{p:<12}"

        for c in corners:
            val = corners_data[c].get(p, "-")
            line += f"{val:>15}"

        rows.append(line)
        print(line)

    # ===============================
    # Save table
    # ===============================

    out_file = OUTPUT_DIR / f"{tb_name}_{mode}_summary.txt"

    with open(out_file, "w") as f:

        f.write(title + "\n")
        f.write("=" * len(title) + "\n")
        f.write(header + "\n")
        f.write("-" * len(header) + "\n")

        for line in rows:
            f.write(line + "\n")

    print(f"\n✔ Summary saved to {out_file}\n")


def generate_tb_summary(tb_name: str):

    for mode in ["sch", "pex"]:
        generate_mode_summary(tb_name, mode)


# ===============================
# Entry point
# ===============================
if __name__ == "__main__":

    if len(sys.argv) != 2:
        print("❌ Usage: python summary_tb.py <tb_name>")
        sys.exit(1)

    generate_tb_summary(sys.argv[1])

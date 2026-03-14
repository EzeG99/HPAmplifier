import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path
import sys
import os

# =========================================================
# Setup paths (runpy-safe)
# =========================================================
PROJECT_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PROJECT_ROOT))

from post.utils.labels import label_classic, label_combined

# =========================================================
# Mode: classic | combined
# =========================================================
POST_MODE = os.getenv("POST_MODE", "classic")
print(f"▶ Post mode: {POST_MODE}")

if POST_MODE == "combined":
    format_label = label_combined
    legend_ncol = 2
else:
    format_label = label_classic
    legend_ncol = 1

# =========================================================
# Paths
# =========================================================
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_StartUp10n_io")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)

sim_types = ["sch", "pex"]
linestyle = {"sch": "-", "pex": "--"}

# =====================================================
# Figura única con 3 subplots
# =====================================================
fig, axs = plt.subplots(
    3, 1,
    figsize=(7,7),
    sharex=True
)

# =====================================================
# Detect corners (from sch directory)
# =====================================================
corner_base = BASE_PATH / "sch"

for corner_dir in sorted(corner_base.iterdir()):

    if not corner_dir.is_dir():
        continue

    corner = corner_dir.name

    for sim in sim_types:

        sim_corner_dir = BASE_PATH / sim / corner

        if not sim_corner_dir.exists():
            continue

        print(f"▶ Processing {sim}/{corner}")

        label = format_label(corner) + f" ({sim})"

        try:
            vdd = pd.read_csv(
                sim_corner_dir / "VDD_10ns_DC_io.txt",
                sep=r"\s+",
                header=None,
                skiprows=1,
                names=["time", "VDD"]
            )

            idd = pd.read_csv(
                sim_corner_dir / "IDD_10ns_DC_io.txt",
                sep=r"\s+",
                header=None,
                skiprows=1,
                names=["time", "IDD"]
            )

            vcm = pd.read_csv(
                sim_corner_dir / "VCM_10ns_DC_io.txt",
                sep=r"\s+",
                header=None,
                skiprows=1,
                names=["time", "VCM"]
            )

        except FileNotFoundError as e:
            print(f"⚠ Missing file in {sim}/{corner}: {e}")
            continue

        # =================================================
        # Units
        # =================================================
        time_ns = vdd["time"] * 1e9
        idd_mA = idd["IDD"] * 1e3

        # =================================================
        # Plot
        # =================================================
        axs[0].plot(
            time_ns, vdd["VDD"],
            linestyle=linestyle[sim],
            label=label
        )

        axs[1].plot(
            time_ns, idd_mA,
            linestyle=linestyle[sim],
            label=label
        )

        axs[2].plot(
            time_ns, vcm["VCM"],
            linestyle=linestyle[sim],
            label=label
        )

# =====================================================
# Axis formatting
# =====================================================
axs[0].set_ylabel(r"$V_{DD}$ [V]")
axs[0].set_title("StartUp TR_VDD = 10ns")
axs[0].grid(True)

axs[1].set_ylabel(r"$I_{DD}$ [mA]")
axs[1].grid(True)

axs[2].set_ylabel(r"$V_{CM}$ [V]")
axs[2].set_xlabel("Time [ns]")
axs[2].grid(True)
axs[2].set_xlim(0, 500)

# =====================================================
# Legend
# =====================================================
axs[0].legend(loc="best", ncol=legend_ncol)

plt.tight_layout()

# =====================================================
# Save
# =====================================================
out_name = "StartUp10ns_all.jpg"
plt.savefig(PLOT_DIR / out_name, bbox_inches="tight")

if os.getenv("NO_SHOW", "0") != "1":
    plt.show()

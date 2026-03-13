import sys
import os
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator

# =========================================================
# Asegurar imports desde project root (runpy-safe)
# =========================================================
PROJECT_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PROJECT_ROOT))

from post.utils.labels import label_classic, label_combined

# =========================================================
# Detectar modo de ejecución
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
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_CMFB_io")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)

SIM_TYPES = ["sch", "pex"]

# =========================================================
# --------- GAIN PLOT -------------------------------------
# =========================================================
plt.figure(figsize=(7, 5))

fmins, fmaxs = [], []

for sim_type in SIM_TYPES:

    sim_path = BASE_PATH / sim_type
    if not sim_path.exists():
        print(f"⚠ Missing {sim_type} directory")
        continue

    linestyle = "-" if sim_type == "sch" else "--"

    for corner_dir in sorted(sim_path.iterdir()):

        if not corner_dir.is_dir():
            continue

        av_file = corner_dir / "CMFB_Av.txt"
        if not av_file.exists():
            print(f"⚠ Skipping {corner_dir.name} ({sim_type}): no CMFB_Av.txt")
            continue

        df = pd.read_csv(
            av_file,
            sep=r"\s+",
            header=None,
            names=["Frequency", "Av_dB"]
        )

        label = f"{format_label(corner_dir.name)} ({sim_type})"

        plt.semilogx(
            df["Frequency"],
            df["Av_dB"],
            linewidth=1.2,
            linestyle=linestyle,
            label=label
        )

        fmins.append(df["Frequency"].min())
        fmaxs.append(df["Frequency"].max())

plt.axhline(0, linestyle="--", linewidth=1)

ax = plt.gca()
ax.yaxis.set_major_locator(MultipleLocator(5))
plt.ylim(-40, 80)

if fmins and fmaxs:

    fmin = min(fmins)
    fmax = max(fmaxs)

    decades = 10 ** np.arange(
        np.floor(np.log10(fmin)),
        np.ceil(np.log10(fmax)) + 1
    )

    plt.xticks(decades)
    plt.xlim(fmin, fmax)

plt.xlabel("Frequency [Hz]")
plt.ylabel("Gain [dB]")
plt.title("CMFB Open Loop Gain")

plt.legend(fontsize=8, ncol=legend_ncol)
plt.grid(True, which="both")
plt.tight_layout()

plt.savefig(PLOT_DIR / "CMFB_Av.jpg", bbox_inches="tight")

if os.getenv("NO_SHOW", "0") != "1":
    plt.show()


# =========================================================
# --------- PHASE PLOT ------------------------------------
# =========================================================
plt.figure(figsize=(7, 5))

fmins, fmaxs = [], []

for sim_type in SIM_TYPES:

    sim_path = BASE_PATH / sim_type
    if not sim_path.exists():
        continue

    linestyle = "-" if sim_type == "sch" else "--"

    for corner_dir in sorted(sim_path.iterdir()):

        if not corner_dir.is_dir():
            continue

        phase_file = corner_dir / "CMFB_Phase.txt"
        if not phase_file.exists():
            print(f"⚠ Skipping {corner_dir.name} ({sim_type}): no CMFB_Phase.txt")
            continue

        df = pd.read_csv(
            phase_file,
            sep=r"\s+",
            header=None,
            names=["Frequency", "Phase"]
        )

        df["Phase"] = np.rad2deg(
            np.unwrap(np.deg2rad(df["Phase"]))
        )

        label = f"{format_label(corner_dir.name)} ({sim_type})"

        plt.semilogx(
            df["Frequency"],
            df["Phase"],
            linewidth=1.2,
            linestyle=linestyle,
            label=label
        )

        fmins.append(df["Frequency"].min())
        fmaxs.append(df["Frequency"].max())

plt.axhline(-180, linestyle="--", linewidth=1)

ax = plt.gca()
ax.yaxis.set_major_locator(MultipleLocator(20))

if fmins and fmaxs:

    fmin = min(fmins)
    fmax = max(fmaxs)

    decades = 10 ** np.arange(
        np.floor(np.log10(fmin)),
        np.ceil(np.log10(fmax)) + 1
    )

    plt.xticks(decades)
    plt.xlim(fmin, fmax)

plt.xlabel("Frequency [Hz]")
plt.ylabel("Phase [°]")
plt.title("CMFB Open Loop Phase")

plt.legend(fontsize=8, ncol=legend_ncol)
plt.grid(True, which="both")
plt.tight_layout()

plt.savefig(PLOT_DIR / "CMFB_Phase.jpg", bbox_inches="tight")

if os.getenv("NO_SHOW", "0") != "1":
    plt.show()

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
from pathlib import Path
import sys
import os

# ===============================
# Setup imports (runpy-safe)
# ===============================
PROJECT_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(PROJECT_ROOT))

from post.utils.labels import label_classic, label_combined

# ===============================
# Mode: classic | combined
# ===============================
POST_MODE = os.getenv("POST_MODE", "classic")
print(f"▶ Post mode: {POST_MODE}")

if POST_MODE == "combined":
    format_label = label_combined
    legend_ncol = 2
else:
    format_label = label_classic
    legend_ncol = 1

# ===============================
# Paths
# ===============================
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_OL_io")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)

# ===============================
# GAIN PLOT
# ===============================
plt.figure(figsize=(7, 5))

fmins, fmaxs = [], []

for corner_dir in sorted(BASE_PATH.iterdir()):
    if not corner_dir.is_dir():
        continue

    av_file = corner_dir / "AvOL.txt"
    if not av_file.exists():
        print(f"⚠ Skipping {corner_dir.name}: no AvOL.txt")
        continue

    df = pd.read_csv(
        av_file,
        sep=r"\s+",
        header=None,
        names=["Frequency", "Av_dB"]
    )

    plt.semilogx(
        df["Frequency"],
        df["Av_dB"],
        linewidth=1.3,
        label=format_label(corner_dir.name),
    )

    fmins.append(df["Frequency"].min())
    fmaxs.append(df["Frequency"].max())

# Línea 0 dB
plt.axhline(0, linestyle="--", linewidth=1)

# Límites Y
plt.ylim(-10, 65)
ax = plt.gca()
ax.yaxis.set_major_locator(MultipleLocator(5))

# Eje X por décadas (auto)
if fmins and fmaxs:
    fmin = min(fmins)
    fmax = max(fmaxs)
    fmax = 10e9 #Override

    decades = 10 ** np.arange(
        np.floor(np.log10(fmin)),
        np.ceil(np.log10(fmax)) + 1
    )

    plt.xticks(decades)
    plt.xlim(fmin, fmax)

plt.xlabel("Frequency [Hz]")
plt.ylabel("Gain [dB]")
plt.title("Open Loop Gain")

plt.legend(fontsize=8, ncol=legend_ncol)
plt.grid(True, which="both")
plt.tight_layout()

plt.savefig(PLOT_DIR / "AvOL.jpg", bbox_inches="tight")
if os.getenv("NO_SHOW", "0") != "1":
    plt.show()


# ===============================
# PHASE PLOT
# ===============================
plt.figure(figsize=(7, 5))

fmins, fmaxs = [], []

for corner_dir in sorted(BASE_PATH.iterdir()):
    if not corner_dir.is_dir():
        continue

    phase_file = corner_dir / "PhaseOL.txt"
    if not phase_file.exists():
        print(f"⚠ Skipping {corner_dir.name}: no PhaseOL.txt")
        continue

    df = pd.read_csv(
        phase_file,
        sep=r"\s+",
        header=None,
        names=["Frequency", "Phase"]
    )

    # Unwrap fase (en grados)
    df["Phase"] = np.rad2deg(
        np.unwrap(np.deg2rad(df["Phase"]))
    )

    plt.semilogx(
        df["Frequency"],
        df["Phase"],
        linewidth=1.3,
        label=format_label(corner_dir.name),
    )

    fmins.append(df["Frequency"].min())
    fmaxs.append(df["Frequency"].max())

# Línea -180°
plt.axhline(-180, linestyle="--", linewidth=1)

plt.ylim(-300, 50)

ax = plt.gca()
ax.yaxis.set_major_locator(MultipleLocator(50))

if fmins and fmaxs:
    fmin = min(fmins)
    fmax = max(fmaxs)
    fmax = 10e9  # override

    decades = 10 ** np.arange(
        np.floor(np.log10(fmin)),
        np.ceil(np.log10(fmax)) + 1
    )

    plt.xticks(decades)
    plt.xlim(fmin, fmax)

plt.xlabel("Frequency [Hz]")
plt.ylabel("Phase [°]")
plt.title("Open Loop Phase")

plt.legend(fontsize=8, ncol=legend_ncol)
plt.grid(True, which="both")
plt.tight_layout()

plt.savefig(PLOT_DIR / "PhaseOL.jpg", bbox_inches="tight")
if os.getenv("NO_SHOW", "0") != "1":
    plt.show()

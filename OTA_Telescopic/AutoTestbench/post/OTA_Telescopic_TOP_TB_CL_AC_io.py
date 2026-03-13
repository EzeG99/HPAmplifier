import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator
from pathlib import Path
import sys
import os

# ===============================
# Setup paths (runpy-safe)
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
    legend_ncol = 1   # 👈 clave para classic

# ===============================
# Paths
# ===============================
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_CL_AC_io")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)

# ===============================
# Plot Gain
# ===============================
plt.figure(figsize=(7, 5))

fmins, fmaxs = [], []

for corner_dir in sorted(BASE_PATH.iterdir()):
    if not corner_dir.is_dir():
        continue

    av_file = corner_dir / "AvCL.txt"
    if not av_file.exists():
        print(f"⚠ Skipping {corner_dir.name}: no AvCL.txt")
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
        linewidth=1.5,
        label=format_label(corner_dir.name)
    )

    fmins.append(df["Frequency"].min())
    fmaxs.append(df["Frequency"].max())

# Línea 0 dB
plt.axhline(0, linestyle="--", linewidth=1)

# Eje Y
plt.ylim(-3, 10)
ax = plt.gca()
ax.yaxis.set_major_locator(MultipleLocator(1))

# Eje X por décadas
fmin = min(fmins)
fmax = max(fmaxs)

decades = 10 ** np.arange(
    np.floor(np.log10(fmin)),
    np.ceil(np.log10(fmax)) + 1
)

plt.xticks(decades)
plt.xlim(fmin, fmax)

# Labels
plt.xlabel("Frequency [Hz]")
plt.ylabel("Gain [dB]")
plt.title("Closed Loop Gain")

plt.legend(fontsize=8, ncol=legend_ncol)
plt.grid(True, which="both")
plt.tight_layout()

plt.savefig(PLOT_DIR / "AvCL.jpg", bbox_inches="tight")
if os.getenv("NO_SHOW", "0") != "1":
    plt.show()


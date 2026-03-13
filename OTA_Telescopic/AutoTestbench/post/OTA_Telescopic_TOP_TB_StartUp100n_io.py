
import pandas as pd
import matplotlib.pyplot as plt
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
else:
    format_label = label_classic

# ===============================
# Paths
# ===============================
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_StartUp100ns")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)

# ===============================
# Loop over corners
# ===============================
for corner_dir in sorted(BASE_PATH.iterdir()):
    if not corner_dir.is_dir():
        continue

    print(f"▶ Processing corner: {corner_dir.name}")
    label = format_label(corner_dir.name)

    # -------- Leer archivos --------
    try:
        vdd = pd.read_csv(
            corner_dir / "VDD_100ns_DC.txt",
            sep=r"\s+",
            header=None,
            skiprows=1,
            names=["time", "VDD"]
        )

        idd = pd.read_csv(
            corner_dir / "IDD_100ns_DC.txt",
            sep=r"\s+",
            header=None,
            skiprows=1,
            names=["time", "IDD"]
        )

        vcm = pd.read_csv(
            corner_dir / "VCM_100ns_DC.txt",
            sep=r"\s+",
            header=None,
            skiprows=1,
            names=["time", "VCM"]
        )
    except FileNotFoundError as e:
        print(f"⚠ Missing file in {corner_dir.name}: {e}")
        continue

    # -------- Unidades --------
    time_ns = vdd["time"] * 1e9
    idd_mA = idd["IDD"] * 1e3

    # ===============================
    # Figura con 3 subplots
    # ===============================
    fig, axs = plt.subplots(
        3, 1,
        figsize=(7, 7),
        sharex=True
    )

    # =========================
    # Plot 1: VDD
    # =========================
    axs[0].plot(time_ns, vdd["VDD"])
    axs[0].set_ylabel(r"$V_{DD}$ [V]")
    axs[0].set_title(
        f"StartUp {label} $TR_{{VDD}}=100nS$"
    )
    axs[0].grid(True)

    # =========================
    # Plot 2: Idd
    # =========================
    axs[1].plot(time_ns, idd_mA)
    axs[1].set_ylabel(r"$I_{DD}$ [mA]")
    axs[1].grid(True)

    # =========================
    # Plot 3: VCM
    # =========================
    axs[2].plot(time_ns, vcm["VCM"])
    axs[2].set_ylabel(r"$V_{CM}$ [V]")
    axs[2].set_xlabel("Time [ns]")
    axs[2].grid(True)

    # -------- Límites de tiempo (igual que tu ejemplo) --------
    axs[2].set_xlim(0, 500)

    plt.tight_layout()

    # ===============================
    # Save
    # ===============================
    out_name = f"StartUp100ns_{corner_dir.name}.jpg"
    plt.savefig(PLOT_DIR / out_name, bbox_inches="tight")
    if os.getenv("NO_SHOW", "0") != "1":
        plt.show()


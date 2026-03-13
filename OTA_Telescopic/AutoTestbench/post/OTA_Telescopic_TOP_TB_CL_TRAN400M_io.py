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
# Paths
# ===============================
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_CL_TRAN400M_io")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)


for corner_dir in sorted(BASE_PATH.iterdir()):
    if not corner_dir.is_dir():
        continue

    vin_file = corner_dir / "Vin_400_io.txt"
    vout_file = corner_dir / "Vout_400_io.txt"
    if not vin_file.exists():
        print(f"⚠ Skipping {corner_dir.name}: no Vin.txt")
        continue


# Leer datos
    vin = pd.read_csv(
    vin_file,
    sep=r"\s+",
    header=None,
    skiprows=1,
    names=["Time", "Vin"]
    )

    vout = pd.read_csv(
    vout_file,
    sep=r"\s+",
    header=None,
    skiprows=1,
    names=["Time", "Vout"]
    )

# Convertir tiempo a ns
    vin["Time"]  *= 1e9
    vout["Time"] *= 1e9

    plt.figure(figsize=(7,5))

    plt.plot(vin["Time"],  vin["Vin"],  color="red",  linewidth=1.5, label="Vin")
    plt.plot(vout["Time"], vout["Vout"], color="blue", linewidth=1.5, label="Vout")

    plt.xlabel("Time [ns]")
    plt.ylabel("Voltage [V]")
    plt.title("Transient Response Vin vs Vout (SS)")

# Zoom temporal
    plt.xlim(120, 140)

    plt.legend()
    plt.grid(True)
    plt.tight_layout()

    corner_name = corner_dir.name
    out = PLOT_DIR/ f"{corner_dir.name}_TRAN100.png"
    plt.savefig(out, bbox_inches="tight")
    if os.getenv("NO_SHOW", "0") != "1":
        plt.show()




import numpy as np
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
# Detect execution mode
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
BASE_PATH = Path("./runs/OTA_Telescopic_TOP_TB_CL_TRAN100M_io")
PLOT_DIR = Path("./post/plots")
PLOT_DIR.mkdir(parents=True, exist_ok=True)

# =========================================================
# Simulation types (sch / pex)
# =========================================================
sim_types = ["sch", "pex"]

for sim in sim_types:

    sim_path = BASE_PATH / sim
    if not sim_path.exists():
        continue

    for corner_dir in sorted(sim_path.iterdir()):

        if not corner_dir.is_dir():
            continue

        vin_file = corner_dir / "Vin_100_io.txt"
        vout_file = corner_dir / "Vout_100_io.txt"

        if not vin_file.exists() or not vout_file.exists():
            print(f"⚠ Skipping {sim}/{corner_dir.name}: missing files")
            continue

        # =================================================
        # Read data
        # =================================================
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

        # Convert time to ns
        vin["Time"] *= 1e9
        vout["Time"] *= 1e9

        # =================================================
        # Plot
        # =================================================
        plt.figure(figsize=(7,5))

        plt.plot(
            vin["Time"],
            vin["Vin"],
            linewidth=1.5,
            label="Vin"
        )

        plt.plot(
            vout["Time"],
            vout["Vout"],
            linewidth=1.5,
            label="Vout"
        )

        label = format_label(f"{corner_dir.name}_{sim}")

        plt.xlabel("Time [ns]")
        plt.ylabel("Voltage [V]")
        plt.title(f"Transient Response Vin vs Vout ({sim.upper()} - {format_label(corner_dir.name)})")

        # Zoom temporal
        plt.xlim(120, 140)

        plt.grid(True)
        plt.legend(ncol=legend_ncol)
        plt.tight_layout()

        out_file = PLOT_DIR / f"{corner_dir.name}_{sim}_TRAN100.png"
        plt.savefig(out_file, bbox_inches="tight")

        if os.getenv("NO_SHOW", "0") != "1":
            plt.show()

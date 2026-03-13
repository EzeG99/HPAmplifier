# corners.py
from itertools import product

# =========================
# Corners CLÁSICOS (default)
# =========================
CORNERS = {
    "TT": {
        "process": "tt",
        "vdd": 1.8,
        "temp": 65,
    },
    "FF": {
        "process": "ff",
        "vdd": 1.98,
        "temp": 0,
    },
    "SS": {
        "process": "ss",
        "vdd": 1.62,
        "temp": 125,
    },
}

# ==================================
# Corners COMBINADOS (sweep opcional)
# ==================================
def generate_combined_corners():
    """
    Generate a Cartesian sweep of (process, VDD, Temp)
    using realistic values per process.
    """

    PROCESS_SWEEPS = {
        "tt": {
            "vdd":  [1.8],
            "temp": [65],
        },
       #"ff": {
       #    "vdd":  [1.98],
       #    "temp": [0],
       #},
       #"ss": {
       #    "vdd":  [1.62],
       #    "temp": [125],
       #},
    }

    corners = {}

    for process, sweep in PROCESS_SWEEPS.items():
        for vdd, temp in product(sweep["vdd"], sweep["temp"]):
            name = f"{process.upper()}_VDD{vdd:.2f}_T{temp}"
            corners[name] = {
                "process": process,
                "vdd": vdd,
                "temp": temp,
            }

    return corners


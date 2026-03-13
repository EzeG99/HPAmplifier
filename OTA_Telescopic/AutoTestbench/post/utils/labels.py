"""
Label utilities for post-processing plots
"""

def label_classic(name: str) -> str:
    """
    Classic mode:
      FF_VDD1.62_T125 -> FF
      TT              -> TT
    """
    if not name:
        return ""

    return name.split("_")[0]


def label_combined(name: str) -> str:
    """
    Combined mode:
      FF_VDD1.62_T125 -> MOS FF 1.62V 125°C
    """
    if not name:
        return ""

    parts = name.split("_")

    process = parts[0]
    vdd = None
    temp = None

    for p in parts:
        if p.startswith("VDD"):
            vdd = p.replace("VDD", "")
        elif p.startswith("T"):
            temp = p.replace("T", "")

    label = f"MOS {process}"

    if vdd is not None:
        label += f" {vdd}V"

    if temp is not None:
        label += f" {temp}°C"

    return label

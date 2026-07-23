# Enclosure — ESP32-C6 Super Mini + mini PSU

[![Português](https://img.shields.io/badge/Language-Português-inactive)](README.md)[![English](https://img.shields.io/badge/_English-blue)](README.en.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Compact case for the Matter switch (ESP32-C6 Super Mini + Hilink mini PSU).

![3D-printed case — base and lid](case-matter-switch.png)

> Parametric model **V16.3** — boards side by side, snap-fit rails, Ø8 hole centered in the gap, and USB-C opening for ESP32 deploy/debug via JTAG.

## About this project

**ESP32-C6 Super Mini Enclosure** is a **personal open-source project**, created as a **community contribution** for Matter/ESP32 developers.

- Works in a lab environment and can be **reused, studied, and adapted** freely.
- **Not a commercial product** — no official support, warranty, or electrical safety certification.
- Compatible with the [Magic Button (esp32-sw-matter-ota)](https://github.com/cjcoletti/esp32-sw-matter-ota) firmware, but usable with similar builds.

**Status:** model **V16.3** tested in 3D printing (PLA/PETG) with ESP32-C6 Super Mini and Hilink mini PSU.

## Structure

```text
esp32c6-supermini-enclosure/
├── README.md
├── README.en.md
├── CONTRIBUTING.md
├── CONTRIBUTING.en.md
├── SECURITY.md
├── LICENSE
├── case.scad
├── base.stl
├── tampa.stl
└── case-matter-switch.png
```

## Files

| File | Purpose |
|------|---------|
| `base.stl` | Case base (print) |
| `tampa.stl` | Lid (print) |
| `case.scad` | Parametric source (OpenSCAD) |
| `case-matter-switch.png` | Photo of printed case (base + lid) |

## External dimensions

| Axis | mm |
|------|-----|
| Width (X, PSU \|\| ESP) | **45.0** |
| Depth (Y, long axes of boards) | **38.3** |
| Assembled height | **24.5** (base 22.5 + lid 2.0) |

**2 mm** walls; rounded outer corners (**r = 3 mm**).

## Components

| Module | Dimensions (mm) | Orientation |
|--------|-----------------|-------------|
| PSU | 20 × 34 × (15 + 5) (width × depth × height (PSU + pins)) | Flat |
| ESP32-C6 | 18 × 25 × 20 (width × depth × height) | Upright |

Fit clearance in CAD: **0.3 mm** (`folga_encaixe`).

## Internal layout

Top view (lid removed):

```
  Y=38 (rear)
  +--------+----+--------+
  |        |boss|        |
  |  PSU   | 2mm|  ESP   |
  | rail   |gap | rail   |
  |  18 mm |    |  21 mm |
  |        |boss|        |
  +--------+-Ø8-+--USB-C-+
  Y=0 (front)
```

- **PSU (left):** side rails with **15 mm** internal clearance; snap-fit guide to the bottom (guide height **4 mm**).
- **ESP (right):** rails with **18 mm** internal clearance; full board depth (**25.3 mm** with clearance).
- **Center gap:** **2 mm** between rails (pins / headers).
- **Rails:** **1.5 mm** tabs on each side; the board slides between them until seated on the bottom.

## Front face openings (Y = 0)

| Opening | Specification |
|---------|---------------|
| USB-C | Stadium profile **10.0 × 4.5 mm** (horizontal), aligned with ESP |
| Wires | **Ø 8 mm**, centered in the gap (X = gap center), just below the front boss |

## Fasteners

Lid with 2 **M2 × 6 mm** screws, centered on width (gap axis):

- Bosses on **front** and **rear** walls (height **7.5 mm**).
- Blind pilot **Ø 2.0 mm**, depth **6 mm** in the base.
- Through hole **Ø 2.4 mm** in the lid, with counterbore (**Ø 4.2 mm**).

## Suggested print settings

- PLA or PETG, **0.2 mm** layer, **2–3 perimeters**, 15–20% infill
- No supports: base with bottom on the bed; flat lid on the bed
- Test rail fit and USB-C clearance before closing the case

## Edit online

To preview or adjust the model without installing OpenSCAD, open `case.scad` in [PrintPal CAD Agent](https://printpal.io/cad-agent).

## Regenerate STLs

Open `case.scad` in OpenSCAD:

1. `visualizar_tampa = false` → render and export **base**
2. `visualizar_tampa = true` → render and export **lid**

**File → Export → Export as STL** (`base.stl` / `tampa.stl`).

## Contributions

This project is maintained personally. **Suggestions and ideas are welcome** via [Issues](https://github.com/cjcoletti/esp32c6-supermini-enclosure/issues/new/choose)
(or Discussions). Please **do not send Pull Requests** — I prefer to implement changes
myself, at my own pace. You are free to fork under the MIT license.

See [CONTRIBUTING.en.md](CONTRIBUTING.en.md) for details.

## Security

See [SECURITY.md](SECURITY.md) to report vulnerabilities privately.

## License

Licensed under the [MIT License](LICENSE).

## Legal notice

This software is provided **"as is"**, without warranty of any kind. The author is not liable for damages arising from its use. Matter® is a trademark of the Connectivity Standards Alliance; this project is not affiliated with the CSA or Espressif.

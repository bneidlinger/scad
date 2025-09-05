# Art-Deco "Beacon" Sconce (Wall & Ceiling) — 3D Printable

A clean way to hide an **ugly ceramic E26 socket** while celebrating the bulb as a **beacon**. Think *tiny skyscraper spire* on the wall, or a stepped **crown ring** for the ceiling.

## What’s included
- `base_plate` — covers the junction box, provides slotted holes for 8‑32 screws and an aperture for the socket.
- `wall_spire` — stepped, fluted shroud; bulb exits the top.
- `ceiling_crown` — low-profile ring to dress up a ceiling socket.
- `beacon_ring` — optional trim ring to clean up the bulb/base junction.

> **Safety**: Use **LED bulbs only**. Do **not** enclose the bulb. Keep vents unobstructed. This is a decorative accessory — no UL listing. Mount to a code-compliant box with proper hardware.

## Print (Bambu A1)
- **Material**: ASA (best for heat) or PETG.
- **Nozzle**: 0.6 mm | **Layer** 0.28 mm | **Walls** 4 | **Infill** 25% gyroid
- **Supports**: None. Orient `wall_spire` on its *back* (opening up).
- **Finish**: Black/graphite looks very “deco”; dry brush metallic acrylic for highlights.

## Assembly (Wall Spire)
1. **Kill power** at the breaker. Remove any old plate.
2. **Base Plate**: Attach to junction box using **8‑32** screws through the slotted holes. The center aperture fits most E26 ceramic sockets.
3. **Socket**: Mount your ceramic lampholder to the box or through the plate aperture.
4. **Shroud**: Slide `wall_spire` over the socket. Secure to the plate via the two side tabs (self-tapping screws) or **3M VHB** tape.
5. **Bulb**: Install LED bulb and optional `beacon_ring` trim.

## Assembly (Ceiling Crown)
1. Mount `ceiling_crown` to the box using the same slotted pattern.  
2. Ensure bulb has **ample air** around it. This is a trim, not an enclosure.

## Tuning
- If your socket is larger/smaller, edit `socket_clear_d` (default **52 mm**).
- Screw spacing: `box_slot_center` default **89 mm** (~3.5").
- Want taller/shallower? Change `spire_out_h` / `spire_out_d` and `spire_steps`.
- More/less “Deco”: `flutes`, `spire_step_recess`, and `vent_*` parameters.

## Field sanity checks
- 30-minute on test with LED bulb; outer shroud should be warm, not hot.
- If mounted near a door, add a drop of Vibra-Tite/Loctite to screws.

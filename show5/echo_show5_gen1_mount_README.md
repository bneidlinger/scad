# Echo Show 5 (Gen 1) Under‑Cabinet Mount (OpenSCAD)

**Parts:** `sled`, `mount_plate`, `cable_clip` (optional). Friction hinge with micro‑detent teeth.  
**Fasteners:** 1× M3x16–20 bolt + M3 nut or heat‑set insert, 2× #8 wood screws, optional 3M VHB strips.

## Print Settings (Bambu A1)
- Material: **PETG** (indoor) or **ASA** (warmer areas). TPU dots inside sled for grip are optional.
- Nozzle: **0.6 mm** | Layer: **0.28 mm**
- Walls: **4** | Infill: **25%** gyroid | Top/Bottom: **4**
- Supports: **None** (all parts are support‑free)
- Orientation: plate and sled **flat** on their backs; cable clip flat.

## Assembly
1. Mount the **plate** under the cabinet with 2× #8 screws (use the countersunk holes).  
2. Insert **M3** hardware in the hinge: either heat‑set inserts in the sled ears or use a through‑bolt and nut.  
3. Sandwich the plate ear between the sled ears and insert the M3 bolt. Tighten for desired friction.  
4. Slide the Echo Show 5 (Gen 1) into the **sled**; the low front lip prevents slip.  
5. Route power through the **cable clip** for strain relief.

## Tuning
- If the fit is tight/loose, open the `.scad` and adjust `clear` (default **1.0 mm**).
- To change tilt resistance, tighten the M3 bolt or set `detent_teeth=0` for smooth friction only.
- Button clearance is handled by `standoff` (default **10 mm**). Increase if your cabinet lip is chunky.

## Safety
- Do not block vents. Run a 30-minute video call; warm is normal, *hot* means add more relief slots.
- This is a **low-voltage accessory**; no mains enclosures or UL claims.

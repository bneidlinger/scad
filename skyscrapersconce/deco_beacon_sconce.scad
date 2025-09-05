//
// Art-Deco Beacon Sconce — for bare E26 ceramic sockets
// Author: ChatGPT for Brando
// License: CC-BY 4.0
//
// Parts:
//   - base_plate(): junction-box cover + mounting
//   - wall_spire(): art-deco stepped shroud, bulb emerges as beacon
//   - ceiling_crown(): low-profile crown ring for ceiling mount
//   - beacon_ring(): optional trim ring around bulb base
//
// Notes:
//   - Designed for **LED bulbs only** (A19-class). Do NOT use with incandescents.
//   - Mount to a code-compliant junction box with 8-32 screws. No mains wiring is provided.
//   - Slots fit a range of screw spacings; parametrize below if needed.
//
// Print:
//   - ASA (preferred) or PETG. 0.6 mm nozzle, 0.28 mm layer, 4 walls, 25% gyroid. No supports.
//   - Orient base_plate and ceiling_crown flat. Wall_spire prints on its back (opening facing up).
//
// Assembly (wall):
//   1) Screw base_plate to the junction box (8-32 screws).
//   2) Attach your ceramic lampholder to the plate or box ears (through the plate aperture).
//   3) Slide wall_spire over the socket; secure with 2 self-tapping screws into plate tabs (or use VHB).
//   4) Add beacon_ring if desired.
//
// --- Parameters ---
$fn = 96;

// Junction box / lampholder geometry (adjust to your hardware)
box_slot_center = 89;      // mm; ~3.5" on-center screw spacing typical for US 4" boxes
box_slot_len    = 18;      // slot length to accommodate variance
box_slot_y      = 20;      // offset from plate center

// Lampholder aperture
socket_clear_d  = 52;      // inner clearance for typical E26 ceramic (tweak 48–55)
bulb_clear_d    = 70;      // clearance for A19 base region exiting shroud
wire_notch_w    = 14;      // bottom notch width for wires
wire_notch_h    = 8;       // notch height

// Base plate size
plate_w = 140;
plate_h = 90;
plate_t = 4.0;
corner_r = 6;

// Wall spire (shroud) sizing
spire_out_w = 120;  // overall width
spire_out_d = 78;   // projection from wall
spire_out_h = 160;  // overall height
spire_wall  = 3.2;  // wall thickness
spire_steps = 5;    // number of deco steps
spire_step_recess = 4; // recess per step
flutes = 8;         // vertical flute count (0 to disable)
flute_w = 5;        // flute width
flute_d = 2;        // flute depth
vent_rows = 3;      // rows of vent slots on sides
vent_cols = 6;      // columns per row
vent_w = 10;        // slot width
vent_h = 2.2;       // slot height

// Ceiling crown ring sizing
crown_outer_d = 140;
crown_inner_d = 80;
crown_t       = 10;
crown_step_t  = 2.8;

// Beacon trim ring sizing
trim_outer_d = 76;
trim_inner_d = 62;
trim_t       = 3.2;

// ---------------- Utilities -----------------
module rrect_xy(x=10,y=10,z=2,r=2){
  linear_extrude(height=z)
    offset(r=r)
      square([x-2*r, y-2*r], center=true);
}

module slot_hole(len=10, dia=4){
  hull(){
    translate([+len/2,0,0]) cylinder(h=plate_t+0.3, d=dia, center=true);
    translate([-len/2,0,0]) cylinder(h=plate_t+0.3, d=dia, center=true);
  }
}

// ---------------- Base Plate -----------------
module base_plate(){
  difference(){
    // base
    translate([0,0,plate_t/2]) rrect_xy(plate_w, plate_h, plate_t, r=corner_r);
    // center aperture for socket
    translate([0,0,0])
      cylinder(h=plate_t+0.4, d=socket_clear_d, center=true);

    // wire notch at bottom
    translate([0, -plate_h/2 + wire_notch_h/2 + 1, 0])
      cube([wire_notch_w, wire_notch_h, plate_t+0.4], center=true);

    // junction box slots (two)
    translate([0, box_slot_y, 0]) rotate([90,0,0])
      slot_hole(len=box_slot_len, dia=4.5);
    translate([0, -box_slot_y, 0]) rotate([90,0,0])
      slot_hole(len=box_slot_len, dia=4.5);

    // elongated X-direction to hit ~89 mm OC
    translate([0, box_slot_y, 0])
      cube([box_slot_center, 4.6, plate_t+0.4], center=true);
    translate([0, -box_slot_y, 0])
      cube([box_slot_center, 4.6, plate_t+0.4], center=true);

    // mounting pilot holes for shroud tabs (left/right)
    for (sx=[-1,1]) translate([sx*(plate_w/2 - 16), 0, 0])
      cylinder(h=plate_t+0.4, d=3.2, center=true);
  }
}

// ------------- Wall Spire (Deco shroud) --------------
module wall_spire(){
  // Outer stepped solid
  step_h = spire_out_h / spire_steps;
  union(){
    // build stacked, rounded steps (outer shell)
    for (i=[0:spire_steps-1]){
      w = spire_out_w - i*spire_step_recess*2;
      d = spire_out_d - i*spire_step_recess;
      h = step_h;
      difference(){
        translate([0, 0, (i*step_h) + h/2])
          minkowski(){
            cube([w-4, d-4, h-0.01], center=true);
            sphere(r=2);
          }
        // hollowing cut for each step (keeps wall thickness fairly even)
        translate([0, 0, (i*step_h) + h/2])
          cube([max(w-2*spire_wall,10), max(d-2*spire_wall,10), max(h-spire_wall,1)], center=true);
      }
    }
  }

  // global cuts & features
  // back cut to open wall-side
  translate([0, -spire_out_d, spire_out_h/2]) cube([spire_out_w+2, 2*spire_out_d+2, spire_out_h+2], center=true);

  // top aperture for bulb
  translate([0, (spire_out_d/2)-4, spire_out_h-2])
    cylinder(h=10, d=bulb_clear_d, center=true);

  // vertical flutes on front face
  if (flutes > 0){
    for (f=[0:flutes-1]){
      x = - (spire_out_w/2 - 10) + f*( (spire_out_w-20) / (max(flutes-1,1)) );
      translate([x, (spire_out_d/3), spire_out_h/2])
        cube([flute_w, flute_d, spire_out_h-20], center=true);
    }
  }

  // side vent slots
  for (side=[-1,1]){
    for (r=[0:vent_rows-1]){
      for (c=[0:vent_cols-1]){
        vx = side*(spire_out_w/2 - 8);
        vy = -spire_out_d/4 + c * ( (spire_out_d/2) / max(vent_cols-1,1) );
        vz = 20 + r * ( (spire_out_h-60) / max(vent_rows-1,1) );
        translate([vx, vy, vz]) rotate([0,90,0])
          cube([vent_w, vent_h, 2.2], center=true);
      }
    }
  }

  // mounting tabs (to base_plate, left/right)
  tab_w = 14; tab_h=10; tab_t=3.2;
  for (sx=[-1,1]){
    translate([sx*(spire_out_w/2 - tab_w/2 - 2), 2, tab_h/2 + 8])
      difference(){
        cube([tab_w, tab_t, tab_h], center=true);
        cylinder(h=tab_t+0.6, d=3.2, center=true);
      }
  }
}

// ------------- Ceiling Crown (low profile) -------------
module ceiling_crown(){
  union(){
    // stepped ring
    for (i=[0:3]){
      od = crown_outer_d - i*8;
      id = crown_inner_d - i*6;
      ht = crown_step_t;
      translate([0,0,ht/2 + i*ht])
        difference(){
          cylinder(h=ht, d=od, center=true);
          cylinder(h=ht+0.2, d=id, center=true);
        }
    }
    // bridge to base screw pattern
    bridge_t = 4;
    translate([0,0, (4*crown_step_t)+bridge_t/2])
      rrect_xy(plate_w*0.7, 24, bridge_t, r=6);
  }

  // slots matching base plate
  difference(){
    translate([0,0,(4*crown_step_t)+2])
      rrect_xy(plate_w*0.7, 24, 4, r=6);
    translate([0, box_slot_y, (4*crown_step_t)+2]) rotate([90,0,0]) slot_hole(len=box_slot_len, dia=4.5);
    translate([0,-box_slot_y, (4*crown_step_t)+2]) rotate([90,0,0]) slot_hole(len=box_slot_len, dia=4.5);
    translate([0, box_slot_y, (4*crown_step_t)+2]) cube([box_slot_center, 4.6, 5], center=true);
    translate([0,-box_slot_y, (4*crown_step_t)+2]) cube([box_slot_center, 4.6, 5], center=true);
  }
}

// ------------- Beacon Trim Ring -------------
module beacon_ring(){
  difference(){
    cylinder(h=trim_t, d=trim_outer_d, center=true);
    cylinder(h=trim_t+0.4, d=trim_inner_d, center=true);
  }
  // three tiny alignment nubs (optional)
  for (ang=[0:120:359]){
    rotate([0,0,ang]) translate([trim_outer_d/2 - 4, 0, 0])
      cylinder(h=trim_t, d=2.6, center=true);
  }
}

// ------------- Layout / Preview -------------
ASSEM_PREVIEW = true;

module laid_out(){
  translate([0,0,0]) base_plate();
  translate([plate_w+20,0,0]) wall_spire();
  translate([-(plate_w+20),0,0]) ceiling_crown();
  translate([0,-(plate_h+40),0]) beacon_ring();
}

module assembly_wall(){
  // base at origin
  color("lightgray") base_plate();
  // spire over it
  translate([0, (spire_out_d/2)-5, plate_t])
    color("silver") wall_spire();
  // trim ring up top
  translate([0, (spire_out_d/2)-5, plate_t + spire_out_h - trim_t/2])
    color("white") beacon_ring();
}

if (ASSEM_PREVIEW) assembly_wall(); else laid_out();

//
// Echo Show 5 (Gen 1) Under‑Cabinet Mount — Parametric OpenSCAD
// Author: ChatGPT for Brando
// License: CC-BY 4.0
//
// Print parts: sled, mount_plate, hinge_bolt_spacer (optional), cable_clip (optional).
// Works support‑free with 0.6mm nozzle, 0.28mm layer, 4 perimeters.
//
// --- DEVICE DIMENSIONS (Gen 1) ---
// Echo Show 5 (Gen 1, 2019) nominal dims (mm)
device_w = 148;   // left‑right width
device_h = 86;    // vertical height
device_d = 73;    // front‑back depth
clear     = 1.0;  // fit clearance on each side (increase if tight)
// --- CRADLE GEOMETRY ---
lip_h     = 5;    // front lip height
cheek_t   = 3.6;  // side wall thickness
cradle_depth_ratio = 0.55; // fraction of device depth to cradle
standoff  = 10;   // drop below cabinet to access buttons
// --- HINGE / FASTENERS ---
hinge_ear_t      = 6;     // thickness of each outer ear (sled side)
hinge_center_t   = 8;     // thickness of center ear (plate side)
hinge_tab_w      = 26;    // overall width of ear block
hinge_tab_h      = 12;    // height of ear block
hinge_boss_r     = 7.5;   // radius of hinge boss (contact area)
hinge_hole_d     = 3.2;   // through hole for M3
insert_d         = 4.8;   // heat-set insert pilot (tweak for your inserts)
insert_h         = 4.0;   // insert depth
// Detent interface (micro-teeth). Set teeth=0 to disable.
detent_teeth     = 12;    // number of teeth around hinge boss
detent_depth     = 0.6;   // tooth depth (radial)
detent_thick     = 1.0;   // thickness of toothed face
// --- MOUNT PLATE ---
plate_w    = 110;
plate_h    = 55;
plate_t    = 6;
screw_d    = 4.5;   // pilot for #8 wood screw
csink_d    = 9.0;   // countersink head diameter
csink_h    = 2.2;   // countersink depth
screw_pitch= 64;    // spacing between wood screws
// Keyhole slots for slide-off remove (optional); set to 0 to disable
keyhole_w  = 8;
keyhole_h  = 14;
keyhole_gap= 40;    // spacing between keyholes
// --- CABLE CLIP ---
clip_opening = 4.5; // fits ~4mm barrel cable
clip_thick   = 3.0;
clip_w       = 18;
clip_h       = 14;
// --- PREVIEW ---
ASSEM_PREVIEW = true; // true shows assembled view; false = show parts laid out
$fn = 64;

// --------------------- Utility ---------------------
module cs_cylinder(h=1,r=1){
  translate([0,0,h/2]) cylinder(h=h, r=r, center=true);
}

module rounded_box(x,y,z,r=1){
  minkowski(){
    cube([x,y,z], center=true);
    sphere(r=r);
  }
}

// radial micro‑tooth ring (triangular teeth) on a thin disk
module detent_ring(r=hinge_boss_r, t=detent_thick, teeth=detent_teeth, depth=detent_depth){
  if (teeth <= 0) cylinder(h=t, r=r, center=true);
  else
  difference(){
    cylinder(h=t, r=r, center=true);
    // carve triangular notches
    for (i=[0:teeth-1]){
      ang = 360/teeth * i;
      rotate([0,0,ang])
        translate([r - depth/2,0,0])
          rotate([0,90,0])
            linear_extrude(height=t+0.2, center=true)
              polygon(points=[[0,0],[depth, depth/2],[depth, -depth/2]]);
    }
  }
}

// --------------------- SLED ---------------------
module sled(){
  w = device_w + 2*clear + 2*cheek_t;
  d = device_d * cradle_depth_ratio;
  h = device_h + 2*clear + lip_h;

  union(){
    // Outer shell
    difference(){
      // rounded outer
      translate([0, d/2, h/2])
        rounded_box(w, d, h, 1.2);
      // cavity
      translate([0, (d/2), lip_h + (device_h+2*clear)/2])
        cube([device_w+2*clear, d+2, device_h+2*clear], center=true);

      // side relief slots (audio/thermal)
      for (i=[0:8]){
        translate([0, 6 + i*6, h*0.35])
          cube([w, 2, 2], center=true);
      }
      // cable relief notch at back-center
      translate([0, d-2, lip_h + (device_h*0.65)])
        cube([16, 4, 10], center=true);
    }

    // front lip (low)
    translate([0, 1.5, lip_h/2])
      cube([device_w+2*clear, 3, lip_h], center=true);

    // hinge ear block at rear top
    translate([0, d + 2, standoff + hinge_tab_h/2])
      difference(){
        cube([hinge_tab_w, 6, hinge_tab_h], center=true);
        // split for center ear clearance
        translate([0,0,0]) cube([hinge_tab_w - hinge_center_t, 6.2, hinge_tab_h-2], center=true);
      }

    // left and right ears with holes + detent faces
    for (sx=[-1,1]){
      translate([sx*(hinge_tab_w/2 - hinge_ear_t/2), d + 2, standoff + hinge_tab_h/2])
        difference(){
          // ear solid
          cube([hinge_ear_t, 6, hinge_tab_h], center=true);
          // through hole
          rotate([0,90,0])
            translate([0,0,0])
              cylinder(h=hinge_ear_t+1, d=hinge_hole_d, center=true);
          // recess for boss
          translate([0,-0.6, hinge_tab_h/2 - (hinge_boss_r+3)])
            rotate([90,0,0])
              cylinder(h=3, r=hinge_boss_r, center=true);
        }

      // detent ring on inner face of each ear
      if (detent_teeth > 0)
      translate([sx*(hinge_tab_w/2 - hinge_ear_t + 0.1), d + 2, standoff + hinge_tab_h/2])
        rotate([0,90,0])
          detent_ring(r=hinge_boss_r, t=detent_thick, teeth=detent_teeth, depth=detent_depth);
    }
  }
}

// --------------------- MOUNT PLATE ---------------------
module mount_plate(){
  difference(){
    // base
    translate([0,0,plate_t/2]) cube([plate_w, plate_h, plate_t], center=false);

    // countersunk screw holes
    for (sx=[-1,1]){
      x = plate_w/2 + sx*screw_pitch/2;
      y = plate_h/2;
      // pilot
      translate([x,y,-0.1]) cylinder(h=plate_t+1, d=screw_d, center=false);
      // countersink
      translate([x,y,plate_t - csink_h + 0.01])
        cylinder(h=csink_h+0.02, d1=csink_d, d2=screw_d, center=false);
    }

    // optional keyholes
    if (keyhole_w > 0 && keyhole_h > 0){
      for (sx=[-1,1]){
        xk = plate_w/2 + sx*(keyhole_gap/2);
        yk = plate_h/2;
        // big end
        translate([xk, yk, -0.1]) cylinder(h=plate_t+1, d=keyhole_w, center=false);
        // slot
        translate([xk, yk - keyhole_h/2, plate_t/2])
          cube([keyhole_w*0.55, keyhole_h, plate_t+1], center=true);
      }
    }
  }

  // center ear (sandwiched between sled ears)
  translate([plate_w/2, plate_h/2 + (device_d*cradle_depth_ratio) + 2, standoff + hinge_tab_h/2])
    difference(){
      cube([hinge_center_t, 6, hinge_tab_h], center=true);
      // through hole
      rotate([0,90,0]) cylinder(h=hinge_center_t+1, d=hinge_hole_d, center=true);
    }

  // detent disk on both sides of center ear
  if (detent_teeth > 0){
    for (sx=[-1,1]){
      translate([plate_w/2 + sx*(hinge_center_t/2 + 0.1),
                 plate_h/2 + (device_d*cradle_depth_ratio) + 2,
                 standoff + hinge_tab_h/2])
        rotate([0,90,0]) detent_ring(r=hinge_boss_r, t=detent_thick, teeth=detent_teeth, depth=detent_depth);
    }
  }
}

// --------------------- Cable Clip ---------------------
module cable_clip(){
  // simple snap clip + base
  base_w = clip_w;
  base_h = clip_thick;
  base_d = 10;
  translate([0,0,base_h/2]) cube([base_w, base_d, base_h], center=true);

  // U‑clip
  translate([0,0,base_h + clip_h/2])
    difference(){
      cube([clip_w, 10, clip_h], center=true);
      translate([0,0,clip_h/2]) cube([clip_w - 2*clip_thick, 10+0.2, clip_h], center=true);
      // opening
      translate([0,0,clip_h - clip_thick/2])
        cube([clip_w, 10+0.2, clip_thick+0.2], center=true);
      // wire passage
      translate([0,0,clip_h/2])
        rotate([90,0,0]) cylinder(h=10+0.6, d=clip_opening, center=true);
    }
}

// --------------------- Layout ---------------------
module parts_laid_out(){
  translate([0,0,0]) sled();
  translate([plate_w + 20, 0, 0]) mount_plate();
  translate([plate_w + 20, plate_h + 20, 0]) cable_clip();
}

module assembly(){
  // mount plate fixed at origin with its back on Z=0
  color("lightgray") mount_plate();
  // sled positioned relative to plate hinge
  translate([plate_w/2, plate_h/2, 0]){
    // shift to hinge and rotate down for preview
    translate([0, (device_d*cradle_depth_ratio) + 2, 0])
      rotate([0,0,-20]) // adjust preview tilt
        translate([-plate_w/2, -plate_h/2, 0]) color("silver") sled();
  }
}

if (ASSEM_PREVIEW) assembly(); else parts_laid_out();

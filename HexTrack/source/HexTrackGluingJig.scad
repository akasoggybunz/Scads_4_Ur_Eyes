// HexTrack Gluing Jig for N-Scale Single Tile Module
// This jig helps align and hold the two split halves while gluing

/* [Dimensions] */
hex_flat_to_flat = 246; // [200:260] Based on Hex-Trak standard
plate_thickness = 4; // [2:10]
feet_height = 8; // [5:15]
feet_diameter = 12; // [8:20]
feet_inset = 0.1; // [0:0.5] Fraction to move feet inward from the vertices toward the center
center_foot_diameter = 12; // [8:20]
include_center_foot = true; // [false, true]

/* [Jig Settings] */
jig_thickness = 20; // [10:30] Increased thickness for stability
jig_margin = 5; // [0:20] Margin around the foot holes for the jig base
hole_depth = 8; // [5:15] Depth of the foot holes in the jig
hole_tolerance = 0.5; // [0.1:1] Clearance around foot holes (0.1=tight, 0.5=loose, easiest removal)
jig_part = 1; // [0:Full,1:RightHalfJig,2:LeftHalfJig]

// Calculated values
// For a regular hexagon: flat-to-flat = sqrt(3) * circumradius.
hex_radius = hex_flat_to_flat / sqrt(3);
hex_points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];

// Foot positions (moved inward)
foot_positions = [for (p = hex_points) p * (1 - feet_inset)];

// Foot hole selection (turn on/off to choose which feet align in jig)
use_foot0 = true; // Right
use_foot1 = true; // Upper-right
use_foot2 = true; // Upper-left
use_foot3 = true; // Left
use_foot4 = true; // Lower-left
use_foot5 = true; // Lower-right

// Build the selected foot positions from the boolean toggles
jig_foot_positions = [
    for (i = [0:5])
        if ([use_foot0, use_foot1, use_foot2, use_foot3, use_foot4, use_foot5][i])
            foot_positions[i]
];

all_hole_positions = include_center_foot
    ? concat(jig_foot_positions, [[0, 0]])
    : jig_foot_positions;

module jig_base() {
    // Base sized only around the selected foot holes (smallest possible)
    x_coords = [for (p = all_hole_positions) p[0]];
    y_coords = [for (p = all_hole_positions) p[1]];
    x_min = min(x_coords);
    x_max = max(x_coords);
    y_min = min(y_coords);
    y_max = max(y_coords);

    translate([x_min - jig_margin, y_min - jig_margin, 0])
        cube([x_max - x_min + jig_margin*2, y_max - y_min + jig_margin*2, jig_thickness]);
}

module foot_holes() {
    for (pos = jig_foot_positions) {
        translate([pos[0], pos[1], jig_thickness - hole_depth])
            cylinder(d = feet_diameter + hole_tolerance, h = hole_depth + 0.1, $fn = 6); // Tolerance for easy fit
    }
    if (include_center_foot)
        translate([0, 0, jig_thickness - hole_depth])
            cylinder(d = center_foot_diameter + hole_tolerance, h = hole_depth + 0.1, $fn = 32);
}

module part_keep_cut() {
    // Keep only one side so each jig piece can fit smaller print beds.
    if (jig_part == 1) { // Right half
        translate([0, -hex_flat_to_flat * 2, -1])
            cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, jig_thickness + 2]);
    } else if (jig_part == 2) { // Left half
        translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -1])
            cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, jig_thickness + 2]);
    } else { // Full
        translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -1])
            cube([hex_flat_to_flat * 4, hex_flat_to_flat * 4, jig_thickness + 2]);
    }
}

// Assemble the jig (optionally as one half so no jig gluing is required).
intersection() {
    difference() {
        jig_base();
        foot_holes();
    }
    part_keep_cut();
}


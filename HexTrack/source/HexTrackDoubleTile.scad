// HexTrack Double Tile Module for N-Scale
// Two single hex tiles joined side-to-side with selectable mating sides.

/* [Dimensions] */
hex_flat_to_flat = 246; // [200:260]
plate_thickness = 4; // [2:10]
feet_height = 8; // [5:15]
feet_diameter = 12; // [8:20]
feet_at_vertices = true;
feet_inset = 0.1; // [0:0.5]
center_foot_diameter = 12; // [8:20]

/* [Tracks] */
track_variant = 1; // [1:Single,2:Double,3:Triple]
track_spacing = 33; // [20:40]
cutout_depth = 1; // [0.5:2]
alignment_slit_width = 0.5; // [0.2:1]
alignment_slit_depth = 2; // [1:5]

/* [Features] */
include_feet = true;
include_center_foot = false; // [false, true]
include_cutouts = true;
include_alignment = true;

/* [Double Hex Layout] */
mate_side_hex1 = 2; // [0:5] Side on hex #1 that mates to hex #2
mate_side_hex2 = 5; // [0:5] Side on hex #2 that mates to hex #1
mate_gap = 0; // [0:0.1:5] Extra gap between mated side faces (mm)

/* [Splitting / Printing] */
split_mode = 0; // [0:Full, 1:RightSide, 2:LeftSide]
split_line_angle = 30; // [0:1:359] Direction of split line through model space (degrees)
split_line_offset = 0; // [-200:1:200] Offset perpendicular to split line (mm)
// mode 1 keeps one side of the line, mode 2 keeps the opposite side

// Calculated values
hex_radius = hex_flat_to_flat / sqrt(3);
hex_points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];

function side_midpoint(i) = (hex_points[i] + hex_points[(i + 1) % 6]) / 2;
function side_normal_angle(i) = 30 + 60 * i;
function track_positions(variant, spacing) =
    variant == 1 ? [0] :
    variant == 2 ? [-spacing/2, spacing/2] :
    [-spacing, 0, spacing];

module hexagon_plate() {
    linear_extrude(height = plate_thickness)
        polygon(hex_points);
}

module feet() {
    if (include_feet) {
        if (feet_at_vertices) {
            for (p = hex_points) {
                inset_p = p * (1 - feet_inset);
                translate([inset_p[0], inset_p[1], -feet_height])
                    cylinder(d = feet_diameter, h = feet_height, $fn = 6);
            }
        }
        if (include_center_foot) {
            translate([0, 0, -feet_height])
                cylinder(d = center_foot_diameter, h = feet_height, $fn = 6);
        }
    }
}

module track_cutouts() {
    if (include_cutouts) {
        for (i = [0:5]) {
            p1 = hex_points[i];
            p2 = hex_points[(i + 1) % 6];
            mid = (p1 + p2) / 2;
            dir = [p2[1] - p1[1], p1[0] - p2[0]];
            translate([mid[0], mid[1], plate_thickness - cutout_depth])
                rotate([0, 0, atan2(dir[0], dir[1])])
                cube([hex_flat_to_flat / 10, alignment_slit_width * 2, cutout_depth + 0.1], center = true);
        }
    }
}

module alignment_slits() {
    if (include_alignment) {
        positions = track_positions(track_variant, track_spacing);
        for (i = [0:5]) {
            p1 = hex_points[i];
            p2 = hex_points[(i + 1) % 6];
            mid = (p1 + p2) / 2;
            dir = [p2[1] - p1[1], p1[0] - p2[0]];
            dir_norm = dir / norm(dir);
            len = norm(p2 - p1);
            for (pos = positions) {
                offset = pos * dir_norm;
                slit_pos = mid + offset * (len / 2 / max(abs(pos), 1));
                translate([slit_pos[0], slit_pos[1], plate_thickness - alignment_slit_depth])
                    rotate([0, 0, atan2(dir[0], dir[1])])
                    cube([len / 10, alignment_slit_width, alignment_slit_depth + 0.1], center = true);
            }
        }
    }
}

module single_hex_tile() {
    difference() {
        union() {
            hexagon_plate();
            feet();
        }
        track_cutouts();
        alignment_slits();
    }
}

module double_hex_tile() {
    side1 = mate_side_hex1 % 6;
    side2 = mate_side_hex2 % 6;

    angle1 = side_normal_angle(side1);
    // Rotate hex #2 so side2 faces back toward side1.
    rot2 = 180 + 60 * (side1 - side2);
    center_dist = hex_flat_to_flat + mate_gap;
    offset = [center_dist * cos(angle1), center_dist * sin(angle1), 0];

    union() {
        single_hex_tile();
        translate(offset)
            rotate([0, 0, rot2])
            single_hex_tile();
    }
}

module split_cut() {
    if (split_mode != 0) {
        span = hex_flat_to_flat * 12;
        zspan = plate_thickness + feet_height + 200;
        // Convert to a local frame where the split line becomes local Y=0.
        // Then remove one half-space with a large cube.
        translate([-split_line_offset * sin(split_line_angle), split_line_offset * cos(split_line_angle), 0])
            rotate([0, 0, split_line_angle]) {
                if (split_mode == 1) {
                    // Keep local y >= 0: remove local y < 0.
                    translate([-span, -span, -100])
                        cube([2 * span, span, zspan]);
                } else if (split_mode == 2) {
                    // Keep local y <= 0: remove local y > 0.
                    translate([-span, 0, -100])
                        cube([2 * span, span, zspan]);
                }
            }
    }
}

difference() {
    double_hex_tile();
    split_cut();
}

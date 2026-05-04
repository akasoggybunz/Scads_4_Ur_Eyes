// HexTrack Double Layer Module
// Lower deck with feet + elevated upper deck + six configurable walls

/* [Dimensions] */
hex_flat_to_flat = 248;      // [200:260]
plate_thickness = 4;         // [2:10]
riser_height = 40;           // [10:80] Clear height between lower top and upper underside
wall_thickness = 2.4;        // [1.2:0.1:6]
wall_end_clearance = 0.6;    // [0:0.1:3]

/* [Feet] */
include_feet = true;         // [false, true]
feet_height = 8;             // [5:15]
feet_diameter = 12;          // [8:20]
feet_inset = 0.1;            // [0:0.5]
include_center_foot = false; // [false, true]
center_foot_diameter = 12;   // [8:20]

/* [Wall Openings] */
arch_opening_width = 54;     // [10:120]
arch_opening_height = 24;    // [6:60]
square_opening_width = 32;   // [6:120]
square_opening_height = 28;  // [6:60]
opening_bottom_margin = 6;   // [0:30]

/* [Wall Type Per Side] */
// 0 = Blank, 1 = Arch, 2 = Square
side0_wall = 1;
side1_wall = 0;
side2_wall = 2;
side3_wall = 1;
side4_wall = 0;
side5_wall = 2;

/* [Track Clips] */
show_track_clips = true;
track_variant = 1;           // [1:Single,2:Double,3:Triple]
track_clip_spacing = 33;     // [20:40]
track_clip_file = "C:/Users/Breakfast/Documents/SCADS/Projects/HexTrack/STLs/Track clip.stl";
track_clip_edge_offset = -6; // [-20:20]
track_clip_rotation_z = 0;   // [0:15:360]
track_clip_local_x_offset = -327.7; // [-1000:1000]
track_clip_local_y_offset = 131.375; // [-1000:1000]
track_clip_local_z_offset = 0; // [-100:100]
lower_track_clip_z_offset = -0.75; // [-10:10] relative to lower deck top
upper_track_clip_z_offset = -0.75; // [-10:10] relative to upper deck top
clips_on_lower_layer = true;
clips_on_upper_layer = true;

// Clip placement by side
track_clip_at_side0 = true;
track_clip_at_side1 = true;
track_clip_at_side2 = true;
track_clip_at_side3 = true;
track_clip_at_side4 = true;
track_clip_at_side5 = true;

/* [Output] */
part_to_render = 0;          // [0:FullAssemblyPreview,1:LowerDeckOnly,2:UpperDeckOnly,3:SingleBlankWall,4:SingleArchWall,5:SingleSquareWall]
split_mode = 0;              // [0:Full,1:RightHalf,2:LeftHalf]

$fn = 64;

hex_radius = hex_flat_to_flat / sqrt(3);
hex_points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];
lower_top_z = plate_thickness;
upper_base_z = plate_thickness + riser_height;
upper_top_z = upper_base_z + plate_thickness;

function side_len(i) = norm(hex_points[(i + 1) % 6] - hex_points[i]);
function side_mid(i) = (hex_points[i] + hex_points[(i + 1) % 6]) / 2;
function side_angle(i) = atan2(
    hex_points[(i + 1) % 6][1] - hex_points[i][1],
    hex_points[(i + 1) % 6][0] - hex_points[i][0]
);
function side_wall_type(i) = [side0_wall, side1_wall, side2_wall, side3_wall, side4_wall, side5_wall][i];
function track_positions(variant, spacing) =
    variant == 1 ? [0] :
    variant == 2 ? [-spacing/2, spacing/2] :
    [-spacing, 0, spacing];

module deck_at_z(z0) {
    translate([0, 0, z0])
        linear_extrude(height = plate_thickness)
            polygon(points = hex_points);
}

module lower_feet() {
    if (include_feet) {
        for (p = hex_points) {
            inset_p = p * (1 - feet_inset);
            translate([inset_p[0], inset_p[1], -feet_height])
                cylinder(d = feet_diameter, h = feet_height, $fn = 6);
        }

        if (include_center_foot)
            translate([0, 0, -feet_height])
                cylinder(d = center_foot_diameter, h = feet_height, $fn = 6);
    }
}

module wall_cutout_arch(panel_len) {
    w = min(arch_opening_width, panel_len - 2);
    h = min(arch_opening_height, riser_height - opening_bottom_margin - 1);
    r = w / 2;
    rect_h = max(0.1, h - r);

    translate([0, 0, opening_bottom_margin])
        union() {
            translate([-w/2, -wall_thickness, 0])
                cube([w, wall_thickness * 3, rect_h]);
            translate([0, wall_thickness / 2, rect_h])
                rotate([90, 0, 0])
                    cylinder(h = wall_thickness * 3, r = r, center = true);
        }
}

module wall_cutout_square(panel_len) {
    w = min(square_opening_width, panel_len - 2);
    h = min(square_opening_height, riser_height - opening_bottom_margin - 1);

    translate([-w/2, -wall_thickness, opening_bottom_margin])
        cube([w, wall_thickness * 3, h]);
}

module wall_panel(panel_len, wall_type = 0) {
    difference() {
        cube([panel_len, wall_thickness, riser_height]);

        if (wall_type == 1)
            translate([panel_len/2, wall_thickness/2, 0]) wall_cutout_arch(panel_len);
        else if (wall_type == 2)
            translate([panel_len/2, wall_thickness/2, 0]) wall_cutout_square(panel_len);
    }
}

module wall_on_side(i, wall_type = 0) {
    panel_len = max(10, side_len(i) - 2 * wall_end_clearance);
    mid = side_mid(i);

    translate([mid[0], mid[1], lower_top_z])
        rotate([0, 0, side_angle(i)])
            translate([-panel_len/2, -wall_thickness/2, 0])
                wall_panel(panel_len, wall_type);
}

module track_clips_at_layer(deck_top_z, z_offset) {
    if (show_track_clips && track_clip_file != "") {
        clip_lane_positions = track_positions(track_variant, track_clip_spacing);
        for (i = [0:5]) {
            show_this = (i==0 && track_clip_at_side0) ||
                        (i==1 && track_clip_at_side1) ||
                        (i==2 && track_clip_at_side2) ||
                        (i==3 && track_clip_at_side3) ||
                        (i==4 && track_clip_at_side4) ||
                        (i==5 && track_clip_at_side5);

            if (show_this) {
                p1 = hex_points[i];
                p2 = hex_points[(i+1) % 6];
                mid = (p1 + p2) / 2;
                edge = p2 - p1;
                edge_unit = edge / norm(edge);
                outward = mid / norm(mid);
                side_rotation = 30 + 60 * i;

                for (lane_offset = clip_lane_positions) {
                    lane_mid = mid + edge_unit * lane_offset;
                    clip_pos = lane_mid + outward * track_clip_edge_offset;
                    translate([clip_pos[0], clip_pos[1], deck_top_z + z_offset])
                        rotate([0, 0, side_rotation + track_clip_rotation_z])
                        translate([track_clip_local_x_offset, track_clip_local_y_offset, track_clip_local_z_offset])
                        import(track_clip_file);
                }
            }
        }
    }
}

module full_assembly() {
    union() {
        deck_at_z(0);
        lower_feet();

        for (i = [0:5])
            wall_on_side(i, side_wall_type(i));

        deck_at_z(upper_base_z);

        if (clips_on_lower_layer)
            track_clips_at_layer(lower_top_z, lower_track_clip_z_offset);
        if (clips_on_upper_layer)
            track_clips_at_layer(upper_top_z, upper_track_clip_z_offset);
    }
}

module selected_part() {
    if (part_to_render == 0) {
        full_assembly();
    } else if (part_to_render == 1) {
        union() {
            deck_at_z(0);
            lower_feet();
            if (clips_on_lower_layer)
                track_clips_at_layer(lower_top_z, lower_track_clip_z_offset);
        }
    } else if (part_to_render == 2) {
        union() {
            deck_at_z(upper_base_z);
            if (clips_on_upper_layer)
                track_clips_at_layer(upper_top_z, upper_track_clip_z_offset);
        }
    } else if (part_to_render == 3) {
        wall_panel(side_len(0) - 2 * wall_end_clearance, 0);
    } else if (part_to_render == 4) {
        wall_panel(side_len(0) - 2 * wall_end_clearance, 1);
    } else if (part_to_render == 5) {
        wall_panel(side_len(0) - 2 * wall_end_clearance, 2);
    }
}

module split_keep_region() {
    if (split_mode == 0) {
        translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -feet_height - 10])
            cube([hex_flat_to_flat * 4, hex_flat_to_flat * 4, upper_top_z + feet_height + 40]);
    } else if (split_mode == 1) { // Right half (x >= 0)
        translate([0, -hex_flat_to_flat * 2, -feet_height - 10])
            cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, upper_top_z + feet_height + 40]);
    } else if (split_mode == 2) { // Left half (x <= 0)
        translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -feet_height - 10])
            cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, upper_top_z + feet_height + 40]);
    }
}

intersection() {
    selected_part();
    split_keep_region();
}

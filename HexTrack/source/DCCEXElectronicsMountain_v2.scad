// V2 hollow low-poly mountain cover for housing DCC-EX electronics on one HexTrack tile.
// This version uses one continuous faceted shell instead of overlapping cone pieces.

/* [Output] */
show_build_volume = false; // [true, false]
show_hex_tile_footprint = false; // [true, false]

/* [Overall Size] */
base_width = 220; // [120:1:232]
base_depth = 205; // [120:1:232]
mountain_height = 160; // [80:1:220]
wall_thickness = 2.6; // [1.2:0.1:5]
base_rim_height = 5; // [0:0.5:15]

/* [Cable Exits] */
cable_side = "front"; // [front, back, left, right]
mains_hole_diameter = 22; // [10:1:35]
low_voltage_hole_diameter = 16; // [6:1:30]
cable_hole_z = 18; // [8:1:45]
cable_hole_spacing = 48; // [25:1:90]
cable_panel_width = 108; // [70:1:150]
cable_panel_height = 46; // [30:1:75]
cable_panel_depth = 24; // [10:1:45]

/* [Mountain Shape] */
facet_count = 9; // [6:1:14]

/* [Reference] */
hex_flat_to_flat = 248;
printer_volume = 232;

function side_angle(name) =
    name == "front" ? 0 :
    name == "back" ? 180 :
    name == "left" ? -90 : 90;
function scale_profile(profile, sx, sy, z_shift = 0) =
    [for (p = profile) [p[0] * sx, p[1] * sy, p[2] + z_shift]];

base_profile = [
    [-110, -80, 0],
    [-72, -102.5, 0],
    [8, -102.5, 0],
    [72, -96, 0],
    [110, -54, 0],
    [108, 38, 0],
    [52, 96, 0],
    [-28, 102.5, 0],
    [-98, 56, 0]
];

profile_1 = [
    [-92, -66, 34],
    [-60, -78, 34],
    [0, -82, 34],
    [58, -72, 34],
    [88, -38, 34],
    [86, 28, 34],
    [44, 78, 34],
    [-22, 84, 34],
    [-78, 46, 34]
];

profile_2 = [
    [-70, -46, 72],
    [-40, -62, 72],
    [10, -56, 72],
    [48, -44, 72],
    [66, -14, 72],
    [58, 28, 72],
    [30, 54, 72],
    [-12, 62, 72],
    [-52, 30, 72]
];

profile_3 = [
    [-44, -30, 112],
    [-22, -40, 112],
    [14, -34, 112],
    [38, -16, 112],
    [36, 18, 112],
    [16, 36, 112],
    [-10, 40, 112],
    [-34, 18, 112],
    [-50, -8, 112]
];

profile_4 = [
    [-20, -12, mountain_height],
    [-8, -20, mountain_height],
    [8, -16, mountain_height],
    [18, -4, mountain_height],
    [14, 12, mountain_height],
    [2, 20, mountain_height],
    [-12, 16, mountain_height],
    [-20, 4, mountain_height],
    [-24, -6, mountain_height]
];

module profile_poly(profile) {
    polyhedron(
        points = concat(profile, [[0, 0, profile[0][2]]]),
        faces = [
            [for (i = [0 : len(profile) - 1]) i],
            for (i = [0 : len(profile) - 1])
                [len(profile), i, (i + 1) % len(profile)]
        ],
        convexity = 4
    );
}

module shell_from_profiles(profiles) {
    for (i = [0 : len(profiles) - 2])
        hull() {
            profile_poly(profiles[i]);
            profile_poly(profiles[i + 1]);
        }
}

module cable_exit_panel() {
    rotate([0, 0, side_angle(cable_side)])
        translate([0, -base_depth / 2 + cable_panel_depth / 2, cable_panel_height / 2])
            cube([cable_panel_width, cable_panel_depth, cable_panel_height], center = true);
}

module panel_overburden() {
    rotate([0, 0, side_angle(cable_side)])
        hull() {
            translate([0, -base_depth / 2 + cable_panel_depth - 1, cable_panel_height + 1])
                cube([cable_panel_width + 10, 6, 6], center = true);
            translate([0, -base_depth / 2 + 56, 74])
                cube([72, 22, 10], center = true);
        }
}

module mountain_outer() {
    union() {
        shell_from_profiles([base_profile, profile_1, profile_2, profile_3, profile_4]);
        cable_exit_panel();
        panel_overburden();
    }
}

module mountain_inner_cutout() {
    translate([0, 0, -base_rim_height - 4])
        shell_from_profiles([
            scale_profile(base_profile, (base_width - wall_thickness * 2) / base_width, (base_depth - wall_thickness * 2) / base_depth),
            scale_profile(profile_1, 0.96, 0.96),
            scale_profile(profile_2, 0.94, 0.94),
            scale_profile(profile_3, 0.90, 0.90),
            scale_profile(profile_4, 0.82, 0.82)
        ]);
}

module cable_hole(x_offset, diameter) {
    rotate([0, 0, side_angle(cable_side)])
        translate([x_offset, -base_depth / 2 - 3, cable_hole_z])
            rotate([90, 0, 0])
                cylinder(d = diameter, h = cable_panel_depth + 26, center = true, $fn = 40);
}

module cable_holes() {
    cable_hole(-cable_hole_spacing / 2, mains_hole_diameter);
    cable_hole(cable_hole_spacing / 2, low_voltage_hole_diameter);
}

module bottom_opening() {
    translate([0, 0, -base_rim_height - 20])
        cube([base_width * 2, base_depth * 2, 40], center = true);
}

module hollow_mountain_cover() {
    difference() {
        mountain_outer();
        mountain_inner_cutout();
        cable_holes();
        bottom_opening();
    }
}

module hex_tile_footprint() {
    hex_radius = hex_flat_to_flat / sqrt(3);
    points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];

    color([0.2, 0.5, 0.9, 0.18])
        translate([0, 0, -0.2])
            linear_extrude(height = 0.2)
                polygon(points);
}

module build_volume_preview() {
    color([1, 0.4, 0.1, 0.12])
        translate([0, 0, printer_volume / 2])
            cube([printer_volume, printer_volume, printer_volume], center = true);
}

if (show_hex_tile_footprint)
    hex_tile_footprint();

if (show_build_volume)
    build_volume_preview();

hollow_mountain_cover();


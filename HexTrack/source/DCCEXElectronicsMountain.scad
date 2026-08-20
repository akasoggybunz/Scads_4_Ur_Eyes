// Hollow low-poly mountain cover for housing DCC-EX electronics on one HexTrack tile.
// Print as a standalone open-bottom shell, then place it over the electronics.

/* [Output] */
show_build_volume = false; // [true, false]
show_hex_tile_footprint = false; // [true, false]

/* [Overall Size] */
base_width = 220; // [120:1:232]
base_depth = 205; // [120:1:232]
mountain_height = 160; // [80:1:220]
wall_thickness = 2.4; // [1.2:0.1:5]
base_rim_height = 5; // [0:0.5:15]

/* [Cable Exits] */
cable_side = "front"; // [front, back, left, right]
mains_hole_diameter = 22; // [10:1:35]
low_voltage_hole_diameter = 16; // [6:1:30]
cable_hole_z = 18; // [8:1:45]
cable_hole_spacing = 48; // [25:1:90]
cable_panel_width = 106; // [60:1:150]
cable_panel_height = 46; // [28:1:70]
cable_panel_depth = 28; // [12:1:50]

/* [Mountain Shape] */
facet_count = 7; // [5:1:12]

/* [Reference] */
hex_flat_to_flat = 248;
printer_volume = 232;

function side_angle(name) =
    name == "front" ? 0 :
    name == "back" ? 180 :
    name == "left" ? -90 : 90;

module faceted_peak(x, y, rx, ry, h, rot = 0) {
    translate([x, y, 0])
        rotate([0, 0, rot])
            scale([rx, ry, 1])
                cylinder(d1 = 2, d2 = 0.05, h = h, $fn = facet_count);
}

module faceted_ridge(x, y, sx, sy, h, rot = 0) {
    translate([x, y, 0])
        rotate([0, 0, rot])
            scale([sx, sy, 1])
                cylinder(d1 = 2, d2 = 0.32, h = h, $fn = 4);
}

module cable_exit_panel() {
    rotate([0, 0, side_angle(cable_side)])
        translate([0, -base_depth / 2 + cable_panel_depth / 2, cable_panel_height / 2])
            intersection() {
                cube([cable_panel_width, cable_panel_depth, cable_panel_height], center = true);
                translate([0, 0, -cable_panel_height / 2])
                    scale([base_width / 2, base_depth / 2, 1])
                        cylinder(d = 2, h = cable_panel_height, $fn = facet_count * 4);
            }
}

module service_face_cover() {
    rotate([0, 0, side_angle(cable_side)])
        hull() {
            translate([0, -base_depth / 2 + cable_panel_depth - 2, cable_panel_height + 2])
                cube([cable_panel_width + 8, 5, 5], center = true);
            translate([0, -base_depth / 2 + cable_panel_depth + 36, cable_panel_height + 30])
                cube([54, 12, 8], center = true);
        }
}

module mountain_core() {
    union() {
        scale([base_width / 2, base_depth / 2, 1])
            cylinder(d = 2, h = base_rim_height, $fn = facet_count * 4);

        cable_exit_panel();

        // Overlapping asymmetric peaks create a mountain range instead of a cone.
        faceted_peak(-32, -8, 77, 88, mountain_height, 12);
        faceted_peak(32, 16, 72, 74, 128, -18);
        faceted_peak(62, -38, 43, 45, 86, 9);
        faceted_peak(-66, 35, 39, 38, 68, -30);
        faceted_peak(-8, 58, 39, 36, 78, 26);

        // Low angular ridges break up the sides and make broad print-friendly slopes.
        faceted_ridge(-16, -43, 88, 17, 90, -20);
        faceted_ridge(26, -22, 75, 15, 82, 22);
        faceted_ridge(-50, 18, 65, 14, 72, 40);
        faceted_ridge(45, 42, 56, 13, 66, -35);
        faceted_ridge(5, 6, 92, 16, 105, 72);

        // Low overburden helps the service face read as part of the hill.
        faceted_ridge(0, -71, 58, 18, 64, 0);
    }
}

module mountain_mass() {
    union() {
        mountain_core();
        service_face_cover();
    }
}

module hollow_cutout() {
    translate([0, 0, -base_rim_height - 4])
        scale([
            (base_width - wall_thickness * 2) / base_width,
            (base_depth - wall_thickness * 2) / base_depth,
            1
        ])
            mountain_core();
}

module cable_hole(x_offset, diameter) {
    rotate([0, 0, side_angle(cable_side)])
        translate([x_offset, -base_depth / 2 - 3, cable_hole_z])
            rotate([90, 0, 0])
                cylinder(d = diameter, h = wall_thickness + 42, center = true, $fn = 40);
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
        mountain_mass();
        hollow_cutout();
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

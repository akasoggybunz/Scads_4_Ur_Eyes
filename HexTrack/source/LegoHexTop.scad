// Lego plates tiled onto HexTrack single tile
// Parameters: choose split mode (full/left/right), include feet, and reserve space for Kato Unitrack

// --- User parameters ---
tile_stl = "../stl/HexTrackSingleTile.stl"; // path to hex tile STL (adjust if needed)
lego_plate_stl = "LegoHexTrak/Lego_6x10_Plate_44237-Body.stl"; // path to LEGO plate STL relative to this file

mode = "full"; // "full", "left", "right"
include_feet = true;

// Hex geometry (matches HexTrack defaults)
hex_flat_to_flat = 246; // mm
plate_thickness = 4; // top plate thickness used for Z positioning of plates

// LEGO plate layout parameters (stud pitch = 8 mm)
stud = 8;
lego_x_studs = 10; // studs along X (long side)
lego_y_studs = 6; // studs along Y (short side)
lego_size_x = lego_x_studs * stud; // ~80 mm
lego_size_y = lego_y_studs * stud; // ~48 mm
lego_clearance = 0.5; // small gap between plates
placement_spacing_x = lego_size_x + lego_clearance;
placement_spacing_y = lego_size_y + lego_clearance;

// Reserve space for Kato Unitrack (a rectangular strip centered on chosen orientation)
unitrak_reserved_width = 40; // mm across the direction of the track (adjust to fit your unitrak)
unitrak_reserved_length = hex_flat_to_flat * 1.2; // ensure it spans the tile
// orientation: 0 = horizontal (X axis), 90 = vertical (Y axis), or any degrees
unitrak_orientation = 0; // degrees

// Feet parameters (if generating feet instead of using the tile STL feet)
feet_height = 8;
feet_diameter = 12;
feet_inset = 0.02; // fraction inset from vertex toward center

// Derived
hex_radius = hex_flat_to_flat / sqrt(3);
hex_points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];

module hex_plate_area(h = plate_thickness) {
    linear_extrude(height = h)
        polygon(hex_points);
}

module import_tile() {
    // If a tile STL is available, import it. Otherwise fall back to a drawn hex plate.
    if (tile_stl != "")
        import(tile_stl);
    else
        hex_plate_area();
}

module lego_plate() {
    // Place LEGO plate such that its bottom sits on top of the hex plate
    // STL is expected with origin at plate bottom center; if not, adjust translate Z.
    import(lego_plate_stl);
}

// Create a grid of plate placements covering bounding box, then clip to hex and reserve unitrak area
module plates_grid() {
    // bounding box for sampling: square that fully contains hex
    box = hex_flat_to_flat;
    x_min = -box/2 - placement_spacing_x;
    x_max = box/2 + placement_spacing_x;
    y_min = -box/2 - placement_spacing_y;
    y_max = box/2 + placement_spacing_y;

    // Place plates in a simple grid centered at origin
    for (x = [x_min : placement_spacing_x : x_max]) {
        for (y = [y_min : placement_spacing_y : y_max]) {
            translate([x, y, plate_thickness])
                lego_plate();
        }
    }
}

module unitrak_reserved() {
    // A rectangular prism representing the reserved area for unitrak, rotated by orientation
    translate([0,0,plate_thickness - 1]) // slightly intersect top
        rotate([0,0,unitrak_orientation])
            translate([-unitrak_reserved_length/2, -unitrak_reserved_width/2, 0])
                cube([unitrak_reserved_length, unitrak_reserved_width, plate_thickness+10], center = false);
}

module add_feet_module() {
    for (p = hex_points) {
        inset_p = p * (1 - feet_inset);
        translate([inset_p[0], inset_p[1], -feet_height])
            cylinder(d = feet_diameter, h = feet_height, $fn = 6);
    }
}

// Split helpers: similar to existing project split behavior
function mode_to_split(m) = m == "full" ? 0 : (m == "right" ? 1 : 2);

// Assemble full union (tile + plates clipped + feet)
module full_union() {
    union() {
        import_tile();
        difference() {
            intersection() { plates_grid(); hex_plate_area(h = plate_thickness + 1); }
            unitrak_reserved();
        }
        if (include_feet) add_feet_module();
    }
}

// Default render: full or the selected half
if (mode == "full")
    full_union();
else {
    // Render full union but cut away the opposite half
    difference() {
        full_union();
        // cutter: subtract the half we don't want
        if (mode == "right")
            // subtract left half
            translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -100])
                cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, plate_thickness + feet_height + 200]);
        else
            // subtract right half
            translate([0, -hex_flat_to_flat * 2, -100])
                cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, plate_thickness + feet_height + 200]);
    }
}

// HexTrack Single Tile Module for N-Scale
// OpenSCAD Customizer Parameters
include <BOSL2/std.scad>
include <BOSL2/joiners.scad>

/* [Dimensions] */
hex_flat_to_flat = 246; // [200:260] Based on Hex-Trak standard
plate_thickness = 4; // [2:10]
feet_height = 8; // [5:15]
feet_diameter = 12; // [8:20]
feet_at_vertices = true; // Enable feet at hexagon vertices
feet_inset = 0.1; // [0:0.5] Fraction to move feet inward from the vertices toward the center
center_foot_diameter = 12; // [8:20]

/* [Tracks] */
track_variant = 1; // [1:Single,2:Double,3:Triple]
track_spacing = 33; // [20:40] Distance between track centers (HexTrack multi-main standard uses 33 mm)
cutout_depth = 1; // [0.5:2] Depth of track cutouts
alignment_slit_width = 0.5; // [0.2:1] Width of alignment slits
alignment_slit_depth = 2; // [1:5] Depth of alignment slits

/* [Features] */
include_feet = true;
include_center_foot = false; // [false, true]
include_cutouts = true;
include_alignment = true;
include_internal_voids = true; // [false, true]
add_feeder_holes = false; // [false, true]
show_feeder_hole_preview = true; // [false, true] Visualize feeder hole locations (preview only)

/* [Internal Voids] */
internal_void_count = 6; // [0:6]
internal_void_diameter = 50; // [5:1:60]
internal_void_ring_radius = 35; // [10:1:100]
internal_void_bottom_skin = 1.0; // [0.4:0.1:2]
internal_void_top_skin = 1.0; // [0.4:0.1:2]

/* [Track Visualization] */
show_track = false; // Enable to show track STL for reference
track_file = ""; // Path to track STL (e.g., "KatoTrack.stl")

/* [Track Clips] */
show_track_clips = true; // Enable to show track clip placement
track_clip_file = "STLs/Track Clip.stl"; // Path to track clip STL (relative to this SCAD)
track_clip_z_offset = 0; // [-10:10] Z position of clip (relative to plate top)
track_clip_edge_offset = 0; // [-20:20] Offset normal to the selected hex side (positive = outward)
track_clip_spacing = 33; // [20:40] Track-center spacing for clips (HexTrack standard = 33 mm)
track_clip_rotation_z = 0; // [0:15:360] Rotation around Z axis
track_clip_local_x_offset = -764.816; // [-1000:1000] Local STL X offset (fixes STL origin mismatch)
track_clip_local_y_offset = 544.114; // [-1000:1000] Local STL Y offset (fixes STL origin mismatch)
track_clip_local_z_offset = -1.625; // [-100:100] Local STL Z offset before placement (bottom of clip to Z=0)
// Clip placement: which hex sides get clips
track_clip_at_side0 = false;
track_clip_at_side1 = false;
track_clip_at_side2 = true;
track_clip_at_side3 = false;
track_clip_at_side4 = false;
track_clip_at_side5 = true;

/* [Feeder Holes] */
feeder_hole_diameter = 3; // [1:0.1:8]
feeder_hole_side = 2; // [0:5] Hex side index for feeder hole
feeder_hole_lane = 0; // [-1:1] Lane selector: -1 inner, 0 center, 1 outer
feeder_hole_inset = 8; // [0:0.5:30] Distance inward from selected side (mm)
feeder_hole_count = 1; // [1:3]
feeder_hole_spacing = 12; // [0:0.5:40] Spacing between multiple holes along side

/* [Splitting / Printing] */
split_mode = 0; // [0:Full, 1:RightHalf, 2:LeftHalf]
joiner_enabled = true;
joiner_count = 2;
joiner_spacing = 70;
joiner_male_half = 1; // [1:RightHalf, 2:LeftHalf]
rabbit_clip_length = 18; // [8:0.5:30] Length along the split face
rabbit_clip_width = 3; // [2:0.25:4] Width through the plate thickness
rabbit_clip_snap = 1.2; // [0.4:0.1:3] Snap depth at each side of the clip
rabbit_clip_thickness = 1.2; // [0.6:0.1:2.5] Thickness of the flexible clip line
rabbit_clip_depth = 7; // [3:0.5:12] How far the clip projects into the mating half
rabbit_clip_socket_extra_depth = 0.5; // [0.2:0.1:1.5] Extra socket depth for easier insertion
rabbit_clip_compression = 0.1; // [0:0.05:0.5] Extra ear width for a firmer snap
rabbit_clip_clearance = 0.15; // [0:0.05:0.6] Extra socket clearance for printer fit

// Calculated values
// For a regular hexagon: flat-to-flat = sqrt(3) * circumradius.
hex_radius = hex_flat_to_flat / sqrt(3);
hex_points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];

// Function to get track positions based on variant
function track_positions(variant, spacing) =
    variant == 1 ? [0] :
    variant == 2 ? [-spacing/2, spacing/2] :
    [-spacing, 0, spacing];

function clamp(v, lo, hi) = max(lo, min(hi, v));
function feeder_lane_offset(variant, spacing, lane_sel) =
    variant == 1 ? 0 :
    variant == 2 ? (lane_sel <= 0 ? -spacing/2 : spacing/2) :
    (lane_sel < 0 ? -spacing : (lane_sel > 0 ? spacing : 0));

module hexagon_plate() {
    linear_extrude(height = plate_thickness)
        polygon(hex_points);
}

module feet() {
    if (include_feet) {
        for (p = hex_points) {
            // Move feet slightly inward so they sit inside the hexagon outline
            inset_p = p * (1 - feet_inset);
            translate([inset_p[0], inset_p[1], -feet_height])
                cylinder(d = feet_diameter, h = feet_height, $fn = 6);
        }

        if (include_center_foot)
            translate([0, 0, -feet_height])
                cylinder(d = center_foot_diameter, h = feet_height, $fn = 6);
    }
}

module track_cutouts() {
    if (include_cutouts) {
        for (i = [0:5]) {
            // Midpoint of each side
            p1 = hex_points[i];
            p2 = hex_points[(i+1)%6];
            mid = (p1 + p2) / 2;
            // Direction perpendicular to side
            dir = [p2[1] - p1[1], p1[0] - p2[0]];
            dir_norm = dir / norm(dir);
            // Cutout along the side
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
            p2 = hex_points[(i+1)%6];
            mid = (p1 + p2) / 2;
            dir = [p2[1] - p1[1], p1[0] - p2[0]];
            dir_norm = dir / norm(dir);
            len = norm(p2 - p1);
            for (pos = positions) {
                offset = pos * dir_norm;
                slit_pos = mid + offset * (len / 2 / max(abs(pos), 1)); // Scale to fit
                translate([slit_pos[0], slit_pos[1], plate_thickness - alignment_slit_depth])
                    rotate([0, 0, atan2(dir[0], dir[1])])
                    cube([len / 10, alignment_slit_width, alignment_slit_depth + 0.1], center = true);
            }
        }
    }
}

// Joiner helper functions
function joiner_positions() = [for (i = [0:joiner_count-1]) ( (i - (joiner_count-1)/2) * joiner_spacing )];
function rabbit_male_orient() = joiner_male_half == 1 ? LEFT : RIGHT;
function rabbit_socket_orient() = rabbit_male_orient();

module rabbit_split_joiner(type, orient_dir) {
    rabbit_clip(
        type = type,
        length = rabbit_clip_length,
        width = rabbit_clip_width,
        snap = rabbit_clip_snap,
        thickness = rabbit_clip_thickness,
        depth = rabbit_clip_depth + (type == "socket" ? rabbit_clip_socket_extra_depth : 0),
        compression = rabbit_clip_compression,
        clearance = rabbit_clip_clearance,
        anchor = BOTTOM,
        orient = orient_dir
    );
}

module rabbit_split_pins() {
    if ((split_mode == 1 || split_mode == 2) && joiner_enabled && split_mode == joiner_male_half) {
        for (ypos = joiner_positions())
            translate([0, ypos, plate_thickness/2])
                rabbit_split_joiner("pin", rabbit_male_orient());
    }
}

module rabbit_split_sockets() {
    if ((split_mode == 1 || split_mode == 2) && joiner_enabled && split_mode != joiner_male_half) {
        for (ypos = joiner_positions())
            translate([0, ypos, plate_thickness/2])
                rabbit_split_joiner("socket", rabbit_socket_orient());
    }
}

module split_cut() {
    if (split_mode != 0) {
        // Cut along the vertical centerline (top-to-bottom) so each half fits on 255x255 print bed
        if (split_mode == 1) {
            // Keep right half (x >= 0)
            translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -100])
                cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, plate_thickness + feet_height + 200]);
        } else if (split_mode == 2) {
            // Keep left half (x <= 0)
            translate([0, -hex_flat_to_flat * 2, -100])
                cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, plate_thickness + feet_height + 200]);
        }

    }
}

module track_visualization() {
    if (show_track && track_file != "") {
        // Import and display track STLs (visual reference only, not printed)
        // Position track on top of the plate
        color([0.8, 0.8, 0.8, 0.5]) // Semi-transparent gray
            translate([0, 0, plate_thickness])
            import(track_file);
    }
}

module track_clips_geometry() {
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

                // Place one clip per active track lane on this side.
                for (lane_offset = clip_lane_positions) {
                    lane_mid = mid + edge_unit * lane_offset;
                    clip_pos = lane_mid + outward * track_clip_edge_offset;
                    translate([clip_pos[0], clip_pos[1], plate_thickness + track_clip_z_offset])
                        rotate([0, 0, side_rotation + track_clip_rotation_z])
                        translate([track_clip_local_x_offset, track_clip_local_y_offset, track_clip_local_z_offset])
                        import(track_clip_file);
                }
            }
        }
    }
}

module feeder_wire_holes() {
    if (add_feeder_holes) {
        side = clamp(round(feeder_hole_side), 0, 5);
        lane_sel = clamp(round(feeder_hole_lane), -1, 1);
        lane_offset = feeder_lane_offset(track_variant, track_clip_spacing, lane_sel);

        p1 = hex_points[side];
        p2 = hex_points[(side+1) % 6];
        mid = (p1 + p2) / 2;
        edge = p2 - p1;
        edge_unit = edge / norm(edge);
        outward = mid / norm(mid);
        inward = -outward;

        hole_count = clamp(feeder_hole_count, 1, 3);
        offsets = hole_count == 1 ? [0] :
                  hole_count == 2 ? [-feeder_hole_spacing/2, feeder_hole_spacing/2] :
                                    [-feeder_hole_spacing, 0, feeder_hole_spacing];

        for (along = offsets) {
            lane_mid = mid + edge_unit * lane_offset + edge_unit * along;
            hole_pos = lane_mid + inward * feeder_hole_inset;
            // Start below the feet to guarantee a full through-hole after boolean ops.
            translate([hole_pos[0], hole_pos[1], -feet_height - 1])
                cylinder(d = feeder_hole_diameter, h = feet_height + plate_thickness + 2, $fn = 32);
        }
    }
}

module feeder_wire_hole_preview() {
    if (show_feeder_hole_preview && !add_feeder_holes) {
        side = clamp(round(feeder_hole_side), 0, 5);
        lane_sel = clamp(round(feeder_hole_lane), -1, 1);
        lane_offset = feeder_lane_offset(track_variant, track_clip_spacing, lane_sel);

        p1 = hex_points[side];
        p2 = hex_points[(side+1) % 6];
        mid = (p1 + p2) / 2;
        edge = p2 - p1;
        edge_unit = edge / norm(edge);
        outward = mid / norm(mid);
        inward = -outward;

        hole_count = clamp(feeder_hole_count, 1, 3);
        offsets = hole_count == 1 ? [0] :
                  hole_count == 2 ? [-feeder_hole_spacing/2, feeder_hole_spacing/2] :
                                    [-feeder_hole_spacing, 0, feeder_hole_spacing];

        for (along = offsets) {
            lane_mid = mid + edge_unit * lane_offset + edge_unit * along;
            hole_pos = lane_mid + inward * feeder_hole_inset;
            %translate([hole_pos[0], hole_pos[1], -feet_height - 1])
                cylinder(d = feeder_hole_diameter, h = feet_height + plate_thickness + 2, $fn = 32);
        }
    }
}

module internal_voids() {
    if (include_internal_voids && internal_void_count > 0) {
        cavity_h = plate_thickness - internal_void_bottom_skin - internal_void_top_skin;
        if (cavity_h > 0) {
            for (i = [0:internal_void_count-1]) {
                a = 360 * i / internal_void_count;
                p = [internal_void_ring_radius * cos(a), internal_void_ring_radius * sin(a)];
                translate([p[0], p[1], internal_void_bottom_skin])
                    cylinder(d = internal_void_diameter, h = cavity_h, $fn = 48);
            }
        }
    }
}
// Assemble the module - clips merged with base geometry
union() {
    difference() {
        union() {
            hexagon_plate();
            feet();
            track_clips_geometry(); // Clips merged into base before cuts
        }
        track_cutouts();
        alignment_slits();
        feeder_wire_holes();
        internal_voids();
        rabbit_split_sockets();
        split_cut();
    }
    rabbit_split_pins();
}

// Display track visualization (reference only, not exported)
track_visualization();
feeder_wire_hole_preview();





// Topo HexTrack tile with procedural rocks / terrain features.
//
// Rock STL attribution:
// - "Model Railroad Terrain Rocks Stones Cliffs Outcrop"
// - Thingiverse thing: https://www.thingiverse.com/thing:4630345
// - Designer profile: https://www.thingiverse.com/jeff_j3ffr3y/designs
// The STL files in ./Rocks are used as optional imported terrain rocks.

// --- User parameters ---
/* [Output] */
mode = "full"; // [full, left, right]
include_feet = true; // [true, false]
include_track_clips = true; // [true, false]

/* [Geometry] */
hex_flat_to_flat = 246; // [200:1:280]
plate_thickness = 4; // [1:0.1:12]

/* [HexTrack Features] */
include_cutouts = false; // [false, true]
include_alignment = false; // [false, true]
track_variant = 1; // [1:Single, 2:Double, 3:Triple]
track_spacing = 33; // [20:1:40]
multi_track_alignment = "record_positive"; // [record_positive, record_negative, centered]
cutout_depth = 1; // [0:0.1:3]
alignment_slit_width = 0.5; // [0.1:0.1:2]
alignment_slit_depth = 2; // [0:0.1:6]

/* [Track Clearance] */
track_clearance_enabled = true; // [true, false]
track_clearance_shape = "straight"; // [straight, curve]
track_clearance_width = 54; // [20:1:110]
track_clearance_from = "side1"; // [side0, side1, side2, side3, side4, side5]
track_clearance_to = "side4"; // [side0, side1, side2, side3, side4, side5]
track_clearance_extra_length = 20; // [0:1:80]
track_clearance_curve_radius = 130; // [40:1:260]
track_clearance_curve_direction = "ccw"; // [ccw, cw]
track_clearance_curve_fit = "bezier"; // [bezier, tangent, radius]
track_clearance_curve_bulge = 75; // [-160:1:160]
track_clearance_curve_steps = 32; // [8:4:64]

/* [Terrain] */
enable_terrain = true; // [true, false]
terrain_source = "stl_rocks"; // [stl_rocks, procedural]
terrain_style = "mixed"; // [mixed, rocks, mounds]
terrain_spacing = 22; // [10:1:45]
terrain_edge_margin = 14; // [5:1:35]
terrain_clearance_margin = 18; // [0:1:60]
terrain_seed = 17; // [0:1:999]
stl_rock_scale = 0.35; // [0.1:0.05:1.5]
stl_rock_density = 0.35; // [0:0.05:1]
stl_rock_footprint_padding = 8; // [0:1:40]
stl_rock_footprint_safety = 1.25; // [1:0.05:2]
stl_rock_max_radius = 120; // [5:1:160]
procedural_layers = 5; // [2:1:9]
procedural_cluster_count = 3; // [1:1:6]
rock_min_diameter = 8; // [4:1:30]
rock_max_diameter = 20; // [6:1:45]
rock_min_height = 3; // [1:0.5:20]
rock_max_height = 16; // [2:0.5:35]
rock_facets = 8; // [5:1:14]
mound_min_diameter = 16; // [8:1:45]
mound_max_diameter = 40; // [12:1:80]
mound_min_height = 2; // [1:0.5:12]
mound_max_height = 10; // [2:0.5:25]

/* [Track Clips] */
track_clip_stl = "../../stl/Track Clip.stl";
track_clip_z_offset = -0.75; // [-10:0.1:10]
track_clip_edge_offset = -8; // [-20:0.1:20]
track_clip_local_x = -764.816; // [-1000:0.1:1000]
track_clip_local_y = 544.114; // [-1000:0.1:1000]
track_clip_local_z = -1.625; // [-100:0.1:100]
track_clip_render = "selected_pair"; // [none, selected_one, selected_pair, all]
track_clip_side = "side1"; // [side0, side1, side2, side3, side4, side5]
track_clip_side_a = "side1"; // [side0, side1, side2, side3, side4, side5]
track_clip_side_b = "side4"; // [side0, side1, side2, side3, side4, side5]

/* [Feet] */
feet_height = 8; // [5:15]
feet_diameter = 12; // [8:20]
feet_at_vertices = true; // [true, false]
feet_inset = 0.1; // [0:0.01:0.5]
include_center_foot = false; // [false, true]
center_foot_diameter = 12; // [8:20]

// Rock STL metadata measured from files in ./Rocks.
rock_stl_files = [
    "Rocks/Various_Flat-Bottomed_Rocks_for_Scenery.stl",
    "Rocks/Various_Flat-Bottomed_Rocks_for_Scenery_1.stl",
    "Rocks/Various_Flat-Bottomed_Rocks_for_Scenery_2.stl",
    "Rocks/Various_Flat-Bottomed_Rocks_for_Scenery_3.stl",
    "Rocks/Various_Flat-Bottomed_Rocks_for_Scenery_4.stl",
    "Rocks/Various_Flat-Bottomed_Rocks_for_Scenery_5.stl"
];
rock_stl_centers = [
    [(29.3 + 93) / 2, (-95 + -43.624) / 2, 0],
    [(27.19 + 94.81) / 2, (-38 + 105.96) / 2, 0],
    [(-94.563 + -11) / 2, (-87 + -44.014) / 2, 0],
    [(-60 + 17.749) / 2, (-66.936 + -1) / 2, 0],
    [(-7 + 19.65) / 2, (4 + 49.708) / 2, 0],
    [(-94 + -20.294) / 2, (-38 + 62.978) / 2, 0]
];
rock_stl_radii = [
    norm([63.7, 51.376]) / 2,
    norm([67.62, 143.96]) / 2,
    norm([83.563, 42.986]) / 2,
    norm([77.749, 65.936]) / 2,
    norm([26.65, 45.708]) / 2,
    norm([73.706, 100.978]) / 2
];

// Derived
hex_radius = hex_flat_to_flat / sqrt(3);
hex_points = [for (i = [0:5]) [hex_radius * cos(60 * i), hex_radius * sin(60 * i)]];

function track_positions(variant, spacing) =
    multi_track_alignment == "centered" ?
        (variant == 1 ? [0] :
         variant == 2 ? [-spacing / 2, spacing / 2] :
         [-spacing, 0, spacing]) :
    multi_track_alignment == "record_negative" ?
        (variant == 1 ? [0] :
         variant == 2 ? [0, -spacing] :
         [-spacing, 0, spacing]) :
        (variant == 1 ? [0] :
         variant == 2 ? [0, spacing] :
         [-spacing, 0, spacing]);

function side_index(side_name) =
    side_name == "side0" ? 0 :
    side_name == "side1" ? 1 :
    side_name == "side2" ? 2 :
    side_name == "side3" ? 3 :
    side_name == "side4" ? 4 : 5;
function side_midpoint(i) = (hex_points[i] + hex_points[(i + 1) % 6]) / 2;
function side_edge_unit(i) =
    let(edge = hex_points[(i + 1) % 6] - hex_points[i])
    edge / norm(edge);
function side_outward(i) =
    let(mid = side_midpoint(i))
    mid / norm(mid);
function positive_mod(a, m) = a - floor(a / m) * m;
function clamp_value(v, lo, hi) = max(lo, min(hi, v));
function pseudo_random(n, seed = 0) = positive_mod(sin(n * 37.719 + seed * 91.13) * 43758.5453, 1);
function range_value(n, lo, hi, seed = 0) = lo + pseudo_random(n, seed) * (hi - lo);
function angle_between(a, start, end, direction) =
    direction == "ccw" ?
        positive_mod(a - start, 360) <= positive_mod(end - start, 360) :
        positive_mod(start - a, 360) <= positive_mod(start - end, 360);
function line_intersection(p1, d1, p2, d2) =
    let(
        denom = d1[0] * d2[1] - d1[1] * d2[0],
        delta = p2 - p1,
        t = (delta[0] * d2[1] - delta[1] * d2[0]) / denom
    )
    p1 + d1 * t;
function dist_to_segment(p, a, b) =
    let(
        ab = b - a,
        ap = p - a,
        denom = ab[0] * ab[0] + ab[1] * ab[1],
        t = denom <= 0 ? 0 : clamp_value((ap[0] * ab[0] + ap[1] * ab[1]) / denom, 0, 1),
        closest = a + ab * t
    )
    norm(p - closest);
function bezier_point(p0, p1, p2, t) =
    p0 * (1 - t) * (1 - t) + p1 * 2 * (1 - t) * t + p2 * t * t;
function bezier_curve_control(p1, p2, bulge, direction) =
    let(
        chord = p2 - p1,
        chord_len = norm(chord),
        mid = (p1 + p2) / 2,
        normal = [-chord[1] / chord_len, chord[0] / chord_len],
        sign = direction == "ccw" ? 1 : -1
    )
    mid + normal * bulge * sign;
function dist_to_bezier(p, p0, p1, p2, steps) =
    min([
        for (i = [0 : steps - 1])
            dist_to_segment(
                p,
                bezier_point(p0, p1, p2, i / steps),
                bezier_point(p0, p1, p2, (i + 1) / steps)
            )
    ]);
function safe_curve_radius(p1, p2, r) = max(r, norm(p2 - p1) / 2 + 0.01);
function curve_center(p1, p2, r, direction) =
    let(
        chord = p2 - p1,
        chord_len = norm(chord),
        mid = (p1 + p2) / 2,
        safe_r = safe_curve_radius(p1, p2, r),
        offset = sqrt(safe_r * safe_r - (chord_len / 2) * (chord_len / 2)),
        normal = [-chord[1] / chord_len, chord[0] / chord_len],
        sign = direction == "ccw" ? -1 : 1
    )
    mid + normal * offset * sign;
function tangent_curve_center(side_a, side_b, fallback_r, direction) =
    let(
        p1 = side_midpoint(side_a),
        p2 = side_midpoint(side_b),
        n1 = side_outward(side_a),
        n2 = side_outward(side_b),
        denom = n1[0] * n2[1] - n1[1] * n2[0]
    )
    abs(denom) < 0.001 ? curve_center(p1, p2, fallback_r, direction) : line_intersection(p1, n1, p2, n2);
function clip_side_enabled(i) =
    track_clip_render == "all" ||
    (track_clip_render == "selected_one" && i == side_index(track_clip_side)) ||
    (track_clip_render == "selected_pair" && (i == side_index(track_clip_side_a) || i == side_index(track_clip_side_b)));
function point_in_hex(p, margin = 0) =
    abs(p[0]) <= hex_flat_to_flat / sqrt(3) - margin &&
    abs(p[1]) <= hex_flat_to_flat / 2 - margin &&
    sqrt(3) * abs(p[0]) + abs(p[1]) <= hex_flat_to_flat - 2 * margin;

function point_in_clearance_lane(p, lane_offset = 0, extra_width = 0) =
    !track_clearance_enabled || track_clearance_width <= 0 ? false :
    track_clearance_shape == "curve" ?
    let(
        side_a = side_index(track_clearance_from),
        side_b = side_index(track_clearance_to),
        p1 = side_midpoint(side_a),
        p2 = side_midpoint(side_b),
        lane_p1 = p1 + side_edge_unit(side_a) * lane_offset,
        lane_p2 = p2 + side_edge_unit(side_b) * lane_offset,
        lane_control = bezier_curve_control(lane_p1, lane_p2, track_clearance_curve_bulge, track_clearance_curve_direction),
        bezier_distance = dist_to_bezier(p, lane_p1, lane_control, lane_p2, track_clearance_curve_steps),
        center = track_clearance_curve_fit == "tangent" ?
            tangent_curve_center(side_a, side_b, track_clearance_curve_radius, track_clearance_curve_direction) :
            curve_center(p1, p2, track_clearance_curve_radius, track_clearance_curve_direction),
        safe_r = norm(p1 - center),
        start_angle = positive_mod(atan2(p1[1] - center[1], p1[0] - center[0]), 360),
        end_angle = positive_mod(atan2(p2[1] - center[1], p2[0] - center[0]), 360),
        point_angle = positive_mod(atan2(p[1] - center[1], p[0] - center[0]), 360),
        radial_distance = norm(p - center)
    )
    track_clearance_curve_fit == "bezier" ?
    bezier_distance <= (track_clearance_width + extra_width) / 2 :
        abs(radial_distance - safe_r) <= (track_clearance_width + extra_width) / 2 &&
        angle_between(point_angle, start_angle, end_angle, track_clearance_curve_direction) :
    let(
        side_a = side_index(track_clearance_from),
        p1 = side_midpoint(side_a),
        p2 = side_midpoint(side_index(track_clearance_to)),
        lane_dir = side_edge_unit(side_a),
        lane_p1 = p1 + lane_dir * lane_offset,
        lane_p2 = p2 + lane_dir * lane_offset,
        span = lane_p2 - lane_p1,
        clear_len = norm(span) + track_clearance_extra_length,
        center = (lane_p1 + lane_p2) / 2,
        ux = span[0] / norm(span),
        uy = span[1] / norm(span),
        dx = p[0] - center[0],
        dy = p[1] - center[1],
        along = dx * ux + dy * uy,
        across = -dx * uy + dy * ux
    )
    abs(along) <= clear_len / 2 && abs(across) <= (track_clearance_width + extra_width) / 2;

function point_in_track_clearance(p, extra_width = 0) =
    max([for (lane_offset = track_positions(track_variant, track_spacing)) point_in_clearance_lane(p, lane_offset, extra_width) ? 1 : 0]) > 0;
function point_fits_hex_disc(p, radius, margin = 0) =
    point_in_hex(p, margin + radius);

module hex_top_prism(h = plate_thickness + 2) {
    linear_extrude(height = h)
        polygon(hex_points);
}

module generated_feet() {
    if (include_feet) {
        if (feet_at_vertices) {
            for (p = hex_points) {
                inset_p = p * (1 - feet_inset);
                translate([inset_p[0], inset_p[1], -feet_height])
                    cylinder(d = feet_diameter, h = feet_height, $fn = 6);
            }
        }

        if (include_center_foot)
            translate([0, 0, -feet_height])
                cylinder(d = center_foot_diameter, h = feet_height, $fn = 6);
    }
}

module track_cutouts() {
    if (include_cutouts && cutout_depth > 0) {
        positions = track_positions(track_variant, track_spacing);
        for (i = [0:5]) {
            p1 = hex_points[i];
            p2 = hex_points[(i + 1) % 6];
            mid = (p1 + p2) / 2;
            edge = p2 - p1;
            edge_unit = edge / norm(edge);
            outward = mid / norm(mid);
            side_rotation = atan2(edge[1], edge[0]);

            for (lane_offset = positions) {
                lane_mid = mid + edge_unit * lane_offset;
                cut_pos = lane_mid - outward * cutout_depth / 2;
                translate([cut_pos[0], cut_pos[1], plate_thickness - cutout_depth])
                    rotate([0, 0, side_rotation])
                        cube([hex_flat_to_flat / 10, cutout_depth * 2, cutout_depth + 0.1], center = true);
            }
        }
    }
}

module alignment_slits() {
    if (include_alignment && alignment_slit_depth > 0) {
        positions = track_positions(track_variant, track_spacing);
        for (i = [0:5]) {
            p1 = hex_points[i];
            p2 = hex_points[(i + 1) % 6];
            mid = (p1 + p2) / 2;
            edge = p2 - p1;
            edge_unit = edge / norm(edge);
            side_rotation = atan2(edge[1], edge[0]);

            for (lane_offset = positions) {
                slit_pos = mid + edge_unit * lane_offset;
                translate([slit_pos[0], slit_pos[1], plate_thickness - alignment_slit_depth])
                    rotate([0, 0, side_rotation])
                        cube([hex_flat_to_flat / 10, alignment_slit_width, alignment_slit_depth + 0.1], center = true);
            }
        }
    }
}

module generated_tile() {
    difference() {
        union() {
            hex_top_prism(h = plate_thickness);
            generated_feet();
        }
        track_cutouts();
        alignment_slits();
    }
}

module organic_blob(seed_id, d, h, layers = 5, facets = 14) {
    layer_h = h / layers;
    for (layer = [0 : layers - 1]) {
        t = layer / max(layers - 1, 1);
        layer_d = d * (1 - 0.72 * t) * range_value(seed_id + layer * 13, 0.82, 1.16, terrain_seed);
        sx = range_value(seed_id + layer * 17 + 1, 0.72, 1.28, terrain_seed);
        sy = range_value(seed_id + layer * 19 + 2, 0.72, 1.28, terrain_seed);
        ox = d * 0.08 * range_value(seed_id + layer * 23 + 3, -1, 1, terrain_seed) * (1 - t);
        oy = d * 0.08 * range_value(seed_id + layer * 29 + 4, -1, 1, terrain_seed) * (1 - t);
        rz = range_value(seed_id + layer * 31 + 5, 0, 360, terrain_seed);

        translate([ox, oy, layer * layer_h])
            rotate([0, 0, rz])
                scale([sx, sy, 1])
                    cylinder(d = layer_d, h = layer_h + 0.08, $fn = facets);
    }
}

module low_poly_rock(seed_id, d, h) {
    sx = range_value(seed_id + 11, 0.75, 1.25, terrain_seed);
    sy = range_value(seed_id + 23, 0.75, 1.25, terrain_seed);
    rot = range_value(seed_id + 37, 0, 360, terrain_seed);
    rotate([0, 0, rot])
        scale([sx, sy, 1])
            organic_blob(seed_id, d, h, procedural_layers, max(rock_facets, 8));
}

module terrain_mound(seed_id, d, h) {
    sx = range_value(seed_id + 53, 0.7, 1.3, terrain_seed);
    sy = range_value(seed_id + 67, 0.7, 1.3, terrain_seed);
    rotate([0, 0, range_value(seed_id + 71, 0, 360, terrain_seed)])
        scale([sx, sy, 1])
            organic_blob(seed_id + 5000, d, h, procedural_layers + 1, 18);
}

module terrain_cluster(seed_id, is_mound) {
    for (c = [0 : procedural_cluster_count - 1]) {
        angle = range_value(seed_id + c * 41, 0, 360, terrain_seed);
        distance = c == 0 ? 0 : range_value(seed_id + c * 43, 2, rock_max_diameter * 0.38, terrain_seed);
        local_d = is_mound ?
            range_value(seed_id + c * 47, mound_min_diameter, mound_max_diameter, terrain_seed) :
            range_value(seed_id + c * 47, rock_min_diameter, rock_max_diameter, terrain_seed);
        local_h = is_mound ?
            range_value(seed_id + c * 53, mound_min_height, mound_max_height, terrain_seed) :
            range_value(seed_id + c * 53, rock_min_height, rock_max_height, terrain_seed);

        translate([distance * cos(angle), distance * sin(angle), 0]) {
            if (is_mound)
                terrain_mound(seed_id + c * 101, local_d, local_h);
            else
                low_poly_rock(seed_id + c * 101, local_d, local_h);
        }
    }
}

module terrain_features() {
    if (enable_terrain) {
        max_i = ceil(hex_flat_to_flat / terrain_spacing);
        for (ix = [-max_i : max_i])
            for (iy = [-max_i : max_i]) {
                seed_id = (ix + max_i) * 97 + (iy + max_i) * 31;
                jitter = terrain_spacing * 0.35;
                p = [
                    ix * terrain_spacing + range_value(seed_id + 1, -jitter, jitter, terrain_seed),
                    iy * terrain_spacing + range_value(seed_id + 2, -jitter, jitter, terrain_seed)
                ];
                use_here = pseudo_random(seed_id + 3, terrain_seed) > 1 - stl_rock_density;
                is_mound = terrain_style == "mounds" || (terrain_style == "mixed" && pseudo_random(seed_id + 4, terrain_seed) > 0.55);
                rock_index = floor(range_value(seed_id + 9, 0, len(rock_stl_files) - 0.001, terrain_seed));
                stl_radius = min(rock_stl_radii[rock_index] * stl_rock_scale * stl_rock_footprint_safety + stl_rock_footprint_padding, stl_rock_max_radius);
                procedural_radius = (is_mound ? mound_max_diameter : rock_max_diameter) / 2;
                feature_radius = terrain_source == "stl_rocks" ? stl_radius : procedural_radius;

                if (use_here && point_fits_hex_disc(p, feature_radius, terrain_edge_margin) && !point_in_track_clearance(p, terrain_clearance_margin * 2 + feature_radius * 2)) {
                    translate([p[0], p[1], plate_thickness - 0.05]) {
                        if (terrain_source == "stl_rocks")
                            rotate([0, 0, range_value(seed_id + 10, 0, 360, terrain_seed)])
                                scale([stl_rock_scale, stl_rock_scale, stl_rock_scale])
                                    translate([-rock_stl_centers[rock_index][0], -rock_stl_centers[rock_index][1], -rock_stl_centers[rock_index][2]])
                                        import(rock_stl_files[rock_index]);
                        else if (terrain_style == "rocks" || !is_mound)
                            terrain_cluster(seed_id, false);
                        else
                            terrain_cluster(seed_id, true);
                    }
                }
            }
    }
}

module place_track_clips() {
    if (include_track_clips && track_clip_render != "none") {
        for (i = [0:5]) {
            if (clip_side_enabled(i)) {
                mid = side_midpoint(i);
                outward = mid / norm(mid);
                side_rotation = 30 + 60 * i;

                edge_unit = track_clearance_shape == "straight" && track_clip_render == "selected_pair" ?
                    side_edge_unit(side_index(track_clip_side_a)) :
                    side_edge_unit(i);

                for (lane_offset = track_positions(track_variant, track_spacing)) {
                    lane_mid = mid + edge_unit * lane_offset;
                    translate([lane_mid[0] + outward[0] * track_clip_edge_offset, lane_mid[1] + outward[1] * track_clip_edge_offset, plate_thickness + track_clip_z_offset])
                        rotate([0, 0, side_rotation])
                            translate([track_clip_local_x, track_clip_local_y, track_clip_local_z])
                                import(track_clip_stl);
                }
            }
        }
    }
}

module full_assembly() {
    union() {
        generated_tile();
        terrain_features();
        place_track_clips();
    }
}

module split_cutter(m) {
    if (m == "right")
        translate([-hex_flat_to_flat * 2, -hex_flat_to_flat * 2, -100])
            cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, plate_thickness + feet_height + rock_max_height + 200]);
    else if (m == "left")
        translate([0, -hex_flat_to_flat * 2, -100])
            cube([hex_flat_to_flat * 2, hex_flat_to_flat * 4, plate_thickness + feet_height + rock_max_height + 200]);
}

if (mode == "full")
    full_assembly();
else
    difference() {
        full_assembly();
        if (mode == "right")
            split_cutter("left");
        else
            split_cutter("right");
    }

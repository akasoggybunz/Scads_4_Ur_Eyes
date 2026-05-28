// Quartered LEGO HexTrack tile with procedural studs, domino alignment slots, and foot placement markers.

// --- User parameters ---
/* [Output] */
quarter_mode = "full_preview"; // [full_preview, front_left, front_right, back_left, back_right, domino_key]
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

/* [LEGO Studs] */
enable_studs = true; // [true, false]
stud_pitch = 8; // [6:0.1:10]
stud_diameter = 4.8; // [3:0.1:6]
stud_height = 1.8; // [0.8:0.1:3]
stud_edge_margin = 4; // [0:0.5:12]
stud_merge_depth = 0.15; // [0.05:0.05:0.5]
stud_fn = 24; // [12:4:48]

/* [Blank Surface] */
blank_surface_enabled = true; // [true, false]
blank_surface_shape = "straight"; // [straight, curve]
blank_surface_width = 40; // [0:1:80]
blank_surface_from = "side1"; // [side0, side1, side2, side3, side4, side5]
blank_surface_to = "side4"; // [side0, side1, side2, side3, side4, side5]
blank_surface_extra_length = 20; // [0:1:80]
blank_surface_curve_radius = 130; // [40:1:260] fallback/manual radius
blank_surface_curve_direction = "ccw"; // [ccw, cw]
blank_surface_curve_fit = "bezier"; // [bezier, tangent, radius]
blank_surface_curve_bulge = 75; // [-160:1:160]
blank_surface_curve_steps = 32; // [8:4:64]

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

/* [Quarter Assembly] */
quarter_gap = 0.2; // [0:0.05:1]
split_seam_clearance = 18; // [8:1:40]
split_seam_remove_studs = true; // [true, false]
domino_enabled = true; // [true, false]
domino_length = 22; // [10:0.5:40]
domino_width = 7; // [3:0.5:16]
domino_depth = 10; // [3:0.5:18]
domino_height = 2.2; // [0.8:0.1:4]
domino_z = 1.2; // [0.4:0.1:3]
domino_clearance = 0.35; // [0:0.05:1]
domino_positions = [-85, -45, 45, 85];

/* [Foot Markers] */
show_foot_markers = true; // [true, false]
foot_marker_diameter = 12; // [8:20]
foot_marker_line_width = 1.0; // [0.4:0.1:2]
foot_marker_depth = 0.35; // [0.1:0.05:1]
foot_marker_at_vertices = true; // [true, false]
foot_marker_inset = 0.1; // [0:0.01:0.5]
foot_marker_at_center = false; // [false, true]

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
function clamp_value(v, lo, hi) = max(lo, min(hi, v));
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
function bezier_curve_control_for_lane(lane_p1, lane_p2, bulge, direction) =
    bezier_curve_control(lane_p1, lane_p2, bulge, direction);
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

module hex_top_prism(h = plate_thickness + 2) {
    translate([0,0,0])
        linear_extrude(height = h)
            polygon(hex_points);
}

module foot_marker_at(p) {
    translate([p[0], p[1], plate_thickness - foot_marker_depth])
        difference() {
            cylinder(d = foot_marker_diameter, h = foot_marker_depth + 0.02, $fn = 36);
            translate([0, 0, -0.01])
                cylinder(d = max(0.1, foot_marker_diameter - 2 * foot_marker_line_width), h = foot_marker_depth + 0.04, $fn = 36);
        }
}

module foot_markers() {
    if (show_foot_markers) {
        if (foot_marker_at_vertices) {
            for (p = hex_points) {
                inset_p = p * (1 - foot_marker_inset);
                foot_marker_at(inset_p);
            }
        }

        if (foot_marker_at_center)
            foot_marker_at([0, 0]);
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
            foot_markers();
        }
        track_cutouts();
        alignment_slits();
    }
}

function point_in_hex(p, margin = 0) =
    abs(p[0]) <= hex_flat_to_flat / sqrt(3) - margin &&
    abs(p[1]) <= hex_flat_to_flat / 2 - margin &&
    sqrt(3) * abs(p[0]) + abs(p[1]) <= hex_flat_to_flat - 2 * margin;

function point_in_blank_lane(p, lane_offset = 0) =
    !blank_surface_enabled || blank_surface_width <= 0 ? false :
    blank_surface_shape == "curve" ?
    let(
        side_a = side_index(blank_surface_from),
        side_b = side_index(blank_surface_to),
        p1 = side_midpoint(side_a),
        p2 = side_midpoint(side_b),
        lane_dir_a = side_edge_unit(side_a),
        lane_dir_b = side_edge_unit(side_b),
        lane_p1 = p1 + lane_dir_a * lane_offset,
        lane_p2 = p2 + lane_dir_b * lane_offset,
        lane_control = bezier_curve_control_for_lane(lane_p1, lane_p2, blank_surface_curve_bulge, blank_surface_curve_direction),
        bezier_distance = dist_to_bezier(p, lane_p1, lane_control, lane_p2, blank_surface_curve_steps),
        center = blank_surface_curve_fit == "tangent" ?
            tangent_curve_center(side_a, side_b, blank_surface_curve_radius, blank_surface_curve_direction) :
            curve_center(p1, p2, blank_surface_curve_radius, blank_surface_curve_direction),
        safe_r = norm(p1 - center),
        start_angle = positive_mod(atan2(p1[1] - center[1], p1[0] - center[0]), 360),
        end_angle = positive_mod(atan2(p2[1] - center[1], p2[0] - center[0]), 360),
        point_angle = positive_mod(atan2(p[1] - center[1], p[0] - center[0]), 360),
        radial_distance = norm(p - center)
    )
    blank_surface_curve_fit == "bezier" ?
        bezier_distance <= blank_surface_width / 2 :
        abs(radial_distance - safe_r) <= blank_surface_width / 2 &&
        angle_between(point_angle, start_angle, end_angle, blank_surface_curve_direction) :
    let(
        side_a = side_index(blank_surface_from),
        side_b = side_index(blank_surface_to),
        p1 = side_midpoint(side_a),
        p2 = side_midpoint(side_b),
        lane_dir = side_edge_unit(side_a),
        lane_p1 = p1 + lane_dir * lane_offset,
        lane_p2 = p2 + lane_dir * lane_offset,
        span = lane_p2 - lane_p1,
        blank_len = norm(span) + blank_surface_extra_length,
        center = (lane_p1 + lane_p2) / 2,
        ux = span[0] / norm(span),
        uy = span[1] / norm(span),
        dx = p[0] - center[0],
        dy = p[1] - center[1],
        along = dx * ux + dy * uy,
        across = -dx * uy + dy * ux
    )
    abs(along) <= blank_len / 2 && abs(across) <= blank_surface_width / 2;

function point_in_blank_surface(p) =
    max([for (lane_offset = track_positions(track_variant, track_spacing)) point_in_blank_lane(p, lane_offset) ? 1 : 0]) > 0;
function point_in_split_seam(p) =
    split_seam_remove_studs && (abs(p[0]) <= split_seam_clearance / 2 || abs(p[1]) <= split_seam_clearance / 2);

module lego_studs() {
    if (enable_studs) {
        stud_span = hex_flat_to_flat + 2 * stud_pitch;
        max_i = ceil(stud_span / stud_pitch / 2);
        for (ix = [-max_i : max_i])
            for (iy = [-max_i : max_i]) {
                p = [ix * stud_pitch, iy * stud_pitch];
                if (point_in_hex(p, stud_edge_margin + stud_diameter / 2) && !point_in_blank_surface(p) && !point_in_split_seam(p)) {
                    translate([p[0], p[1], plate_thickness - stud_merge_depth])
                        cylinder(d = stud_diameter, h = stud_height + stud_merge_depth, $fn = stud_fn);
                }
            }
    }
}

module blank_surface_cut() {
    if (blank_surface_enabled && blank_surface_width > 0) {
        p1 = side_midpoint(side_index(blank_surface_from));
        p2 = side_midpoint(side_index(blank_surface_to));
        center = (p1 + p2) / 2;
        span = p2 - p1;
        cut_len = norm(span) + blank_surface_extra_length;
        cut_angle = atan2(span[1], span[0]);

        translate([center[0], center[1], plate_thickness - 1])
            rotate([0, 0, cut_angle])
                cube([cut_len, blank_surface_width, plate_thickness + 10], center = true);
    }
}

module place_track_clips() {
    if (include_track_clips && track_clip_render != "none") {
        // place one clip at midpoint of each side (tweak as needed)
        for (i = [0:5]) {
            if (clip_side_enabled(i)) {
                mid = side_midpoint(i);
                outward = mid / norm(mid);
                side_rotation = 30 + 60 * i;

                edge_unit = blank_surface_shape == "straight" && track_clip_render == "selected_pair" ?
                    side_edge_unit(side_index(track_clip_side_a)) :
                    side_edge_unit(i);

                for (lane_offset = track_positions(track_variant, track_spacing)) {
                    lane_mid = mid + edge_unit * lane_offset;
                    translate([lane_mid[0] + outward[0]*track_clip_edge_offset, lane_mid[1] + outward[1]*track_clip_edge_offset, plate_thickness + track_clip_z_offset])
                        rotate([0,0,side_rotation])
                            translate([track_clip_local_x, track_clip_local_y, track_clip_local_z])
                                import(track_clip_stl);
                }
            }
        }
    }
}

module domino_slot_x(ypos, side_sign) {
    x0 = side_sign > 0 ? quarter_gap / 2 : -quarter_gap / 2 - domino_depth - domino_clearance;
    translate([x0, ypos - (domino_length + domino_clearance) / 2, domino_z - 0.05])
        cube([domino_depth + domino_clearance, domino_length + domino_clearance, domino_height + 0.1]);
}

module domino_slot_y(xpos, side_sign) {
    y0 = side_sign > 0 ? quarter_gap / 2 : -quarter_gap / 2 - domino_depth - domino_clearance;
    translate([xpos - (domino_length + domino_clearance) / 2, y0, domino_z - 0.05])
        cube([domino_length + domino_clearance, domino_depth + domino_clearance, domino_height + 0.1]);
}

module domino_slots_for_quarter(q) {
    if (domino_enabled) {
        if (q == "front_left" || q == "back_left" || q == "front_right" || q == "back_right") {
            for (ypos = domino_positions)
                if ((q == "front_left" && ypos <= -quarter_gap) ||
                    (q == "front_right" && ypos <= -quarter_gap) ||
                    (q == "back_left" && ypos >= quarter_gap) ||
                    (q == "back_right" && ypos >= quarter_gap))
                    domino_slot_x(ypos, (q == "front_right" || q == "back_right") ? 1 : -1);

            for (xpos = domino_positions)
                if ((q == "front_left" && xpos <= -quarter_gap) ||
                    (q == "back_left" && xpos <= -quarter_gap) ||
                    (q == "front_right" && xpos >= quarter_gap) ||
                    (q == "back_right" && xpos >= quarter_gap))
                    domino_slot_y(xpos, (q == "back_left" || q == "back_right") ? 1 : -1);
        }
    }
}

module domino_key() {
    rounded = min(domino_width / 2, 2);
    linear_extrude(height = domino_height)
        offset(r = rounded, $fn = 12)
            offset(delta = -rounded)
                square([domino_length, domino_depth * 2 - domino_clearance], center = true);
}

module quarter_keep_mask(q) {
    span = hex_flat_to_flat * 3;
    seam_half = quarter_gap / 2;
    x0 = (q == "front_right" || q == "back_right") ? seam_half : -span;
    y0 = (q == "back_left" || q == "back_right") ? seam_half : -span;
    sx = (q == "front_right" || q == "back_right") ? span : span - seam_half;
    sy = (q == "back_left" || q == "back_right") ? span : span - seam_half;
    translate([x0, y0, -100])
        cube([sx, sy, plate_thickness + stud_height + domino_height + 220]);
}

module quartered_assembly(q) {
    intersection() {
        difference() {
            full_unquartered_assembly();
            domino_slots_for_quarter(q);
        }
        quarter_keep_mask(q);
    }
}

module full_unquartered_assembly() {
    union() {
        generated_tile();
        lego_studs();

        place_track_clips();
    }
}

// Render based on quarter mode.
if (quarter_mode == "domino_key")
    domino_key();
else if (quarter_mode == "full_preview")
    full_unquartered_assembly();
else
    quartered_assembly(quarter_mode);

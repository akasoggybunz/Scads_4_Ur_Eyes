// Starlink Mini insert for Milwaukee Packout 48-22-8430
// Clean V2 model: fit outline first, Starlink dish second.
// Units: mm

$fn = 64;

/* [Preview] */
show_starlink_preview = false;
show_8430_template_overlay = false;
show_raw_body = false;
render_section_id = 0; // [0:all, 1:left_front, 2:left_back, 3:center_front, 4:center_back, 5:right_front, 6:right_back]
use_exact_stl_fit_body = true;
// Leave this off for the new 8430 STLs: at least one mesh is not closed, so
// OpenSCAD can fail when projection/boolean conversion tries to make it CGAL.
use_template_projection_outline = false;

/* [Packout 48-22-8430 Fit] */
// Official 48-22-8430 interior dimensions are 18.0 x 12.0 x 3.9 in.
case_inner_x = 422.0;
case_inner_y = 306.0;
case_inner_z = 99;
case_clearance = 1.2;

// Fit layer follows the Packout outline. Top tray is clipped to this same
// outline so nothing overhangs the case-fitting footprint.
base_height = 25;
tray_height = 42;
insert_depth_reduction = 25.4; // 1 in shallower than the native 8430 template depth
insert_opening_top_chamfer = 5;
fit_corner_r = 8;

// Outer outline tuning. These are intentionally easy to tune against the
// 8430 template overlay.
corner_clip_x = 14;
corner_clip_y = 14;
side_notch_w = 13;
side_notch_h = 66;
edge_tab_w = 28;
edge_tab_d = 7;
front_back_center_relief_w = 116;
front_back_center_relief_d = 9;

// Center divider bridge: 2.25 in wide x 11.75 in long x 1 in high/deep.
divider_bridge_x = 57.15;
divider_bridge_y = 298.45;
divider_bridge_h = 25.4;
divider_extra_x = 50.8; // add 2 in of usable center width
divider_bridge_r = 5;

/* [Starlink Mini] */
mini_stl_file = "mini/files/ImageToStl.com_Starlink_Mini_Antenna_Assembly_v1_0.stl";
mini_mesh_x = 260.02;
mini_mesh_y = 299.02;
mini_mesh_min_z = -30.107;
mini_mesh_max_z = 6.559;

// Current best orientation: Starlink long side across X, with underside flipped.
mini_rotate_z_deg = 90;
mini_flip_x_180 = true;
mini_preview_z_lift = 1.5;

dish_clearance = 2.5;
right_dish_extra_clearance = 2;
dish_front_back_wall_extra = 2;
extend_right_dish_chamfer_to_top = false;
dish_x = 298.5; // rotated footprint X
dish_y = 259;
dish_z = 38.5;
dish_corner_r = 13;

// Position inside the fit outline. Keep the whole pocket inside the outline.
dish_center_x = -20;
dish_center_y = 0;

// Underside relief for kickstand / pole mount receiver.
mount_relief_x = 134;
mount_relief_y = 118;
mount_relief_depth = 24;
mount_relief_r = 10;

// Keep the Starlink support floor above the top-aligned center STL's bottom.
// Center STL is 19 mm higher than the side STL bottoms, so 22 mm leaves margin.
dish_floor_clearance_from_bottom = 26;
floor_under_relief = 25;
dish_insert_depth = 26;
top_lip = insert_opening_top_chamfer;
level_starlink_floor_to_center_bottom = false;
add_side_leveling_feet = false;
side_leveling_foot_height = 25.4;
side_leveling_foot_w = 42;
side_leveling_foot_d = 58;
side_leveling_foot_r = 6;
raise_side_dish_floor_for_packout_divider = false;
side_dish_floor_raise = 25.4;
add_right_pole_relief = false;
right_pole_relief_w = 63.5;
right_pole_relief_y_margin = 36;
right_pole_relief_x_offset = 155.5;
right_pole_relief_r = 4;
right_pole_relief_chamfer = 5;
add_side_lower_material_relief = false;
side_lower_relief_wall = 16;
side_lower_relief_floor = 3;
side_lower_relief_top_skin = 5;
side_lower_relief_r = 6;
add_side_top_half_material_relief = false;
side_top_half_relief_wall = 16;
side_top_half_relief_bottom_skin = 3;
side_top_half_relief_fraction = 0.5;
side_top_half_relief_r = 6;
trim_top_above_dish_floor = false;
trim_top_keep_fraction_above_dish = 0.5;

/* [Right Accessory Pockets] */
add_right_accessory_pockets = true;
accessory_col_x = 184;
accessory_floor_thickness = 10;
accessory_chamfer = 5;
cable_pocket_x = 82;
cable_pocket_y = 210;
cable_pocket_depth = 34;
cable_corner_r = 10;
front_cable_pocket_y = -28;
pole_channel_x = 42;
pole_channel_y = 128;
pole_channel_depth = 34;
pole_channel_r = 9;
pole_knob_d = 46;
back_pole_channel_y = 56;
back_pole_knob_y = 18;
mount_pocket_x = 70;
mount_pocket_y = 48;
mount_pocket_depth = 30;
mount_pocket_r = 10;
back_mount_pocket_y = 122;

/* [8430 Template Overlay] */
fit_template_lefttop = "mini/files/48-22-8430_lefttop.stl";
fit_template_leftbottom = "mini/files/48-22-8430_leftbottom.stl";
fit_template_righttop = "mini/files/48-22-8430_righttop.stl";
fit_template_rightbottom = "mini/files/48-22-8430_rightbottom.stl";
template_spacing_x = 203.922;
template_spacing_y = 146.0;

/* [8430 Three-Part Template] */
use_three_part_8430_template = true;
template_8430_left = "48228430/Left.stl";
template_8430_center = "repaired/Center_repaired.stl";
template_8430_right = "48228430/Right.stl";

template_8430_side_x = 207.582;
template_8430_side_y = 317.653;
template_8430_side_z = 79.000;
template_8430_native_side_z = template_8430_side_z;
template_8430_center_x = 56.114;
template_8430_center_y = 295.848;
template_8430_center_z = 60.000;
template_8430_total_x = 2*template_8430_side_x + template_8430_center_x;
template_8430_center_top_align_z = template_8430_native_side_z - template_8430_center_z;
template_8430_side_bottom_z = -1;
template_8430_center_bottom_z = -1 + template_8430_center_top_align_z;

/* [Derived] */
insert_x = case_inner_x - 2*case_clearance;
insert_y = case_inner_y - 2*case_clearance;
insert_z = use_exact_stl_fit_body
    ? template_8430_native_side_z - insert_depth_reduction
    : min(base_height + tray_height - insert_depth_reduction, case_inner_z - 2);
top_layer_z = insert_z - base_height;

dish_pocket_x = dish_x + 2*dish_clearance;
dish_pocket_y = dish_y + 2*dish_clearance - 2*dish_front_back_wall_extra;
is_side_section = (render_section_id == 1 || render_section_id == 2 || render_section_id == 5 || render_section_id == 6);
dish_floor_target_z = (level_starlink_floor_to_center_bottom ? template_8430_center_bottom_z : floor_under_relief)
    + ((raise_side_dish_floor_for_packout_divider && is_side_section) ? side_dish_floor_raise : 0);
dish_pocket_depth = min(dish_insert_depth, insert_z - dish_floor_target_z);
dish_floor_z = insert_z - dish_pocket_depth;
mount_feature_y_sign = mini_flip_x_180 ? -1 : 1;
mini_preview_floor_offset_z = mini_flip_x_180 ? -mini_mesh_max_z : -mini_mesh_min_z;

assert(dish_center_x - dish_pocket_x/2 > -insert_x/2 + 4, "Dish pocket is outside left edge.");
assert(dish_center_x + dish_pocket_x/2 < insert_x/2 - 4, "Dish pocket is outside right edge.");
assert(dish_center_y - dish_pocket_y/2 > -insert_y/2 + 4, "Dish pocket is outside front edge.");
assert(dish_center_y + dish_pocket_y/2 < insert_y/2 - 4, "Dish pocket is outside back edge.");

module rr2d(x, y, r) {
    offset(r=r) offset(delta=-r)
        square([x, y], center=true);
}

module rr_prism(x, y, z, r) {
    linear_extrude(height=z)
        rr2d(x, y, r);
}

module right_expanded_rr_prism(x, y, z, r, right_extra=0) {
    linear_extrude(height=z)
        translate([right_extra/2, 0])
            rr2d(x + right_extra, y, r);
}

module right_band_2d(x, y, r, right_extra, band_w) {
    right_face_x = x/2 + right_extra;

    intersection() {
        union() {
            rr2d(x, y, r);
            if (right_extra > 0)
                translate([right_extra/2, 0])
                    square([x + right_extra, y - 2*r], center=true);
        }
        translate([right_face_x - band_w/2, 0])
            square([band_w, y + 2*(r + right_extra + top_lip)], center=true);
    }
}

module right_band_prism(x, y, z, r, right_extra, band_w) {
    linear_extrude(height=z)
        right_band_2d(x, y, r, right_extra, band_w);
}

module fit_outline_2d(x, y) {
    hx = x/2;
    hy = y/2;
    rw = front_back_center_relief_w/2;
    rd = front_back_center_relief_d;

    difference() {
        offset(r=fit_corner_r) offset(delta=-fit_corner_r)
            polygon(points=[
                [-hx + corner_clip_x, -hy],
                [-rw, -hy],
                [-rw + 8, -hy + rd],
                [ rw - 8, -hy + rd],
                [ rw, -hy],
                [ hx - corner_clip_x, -hy],
                [ hx, -hy + corner_clip_y],
                [ hx,  hy - corner_clip_y],
                [ hx - corner_clip_x,  hy],
                [ rw,  hy],
                [ rw - 8,  hy - rd],
                [-rw + 8,  hy - rd],
                [-rw,  hy],
                [-hx + corner_clip_x,  hy],
                [-hx,  hy - corner_clip_y],
                [-hx, -hy + corner_clip_y]
            ]);

        for (sx=[-1,1]) {
            translate([sx*(hx - side_notch_w/2), 0])
                square([side_notch_w + 1, side_notch_h], center=true);
            translate([sx*(hx - edge_tab_w/2), hy - edge_tab_d/2])
                square([edge_tab_w, edge_tab_d + 1], center=true);
            translate([sx*(hx - edge_tab_w/2), -hy + edge_tab_d/2])
                square([edge_tab_w, edge_tab_d + 1], center=true);
        }
    }
}

module fit_outline_prism(z) {
    if (use_template_projection_outline) {
        linear_extrude(height=z)
            template_footprint_2d();
    } else if (use_three_part_8430_template) {
        linear_extrude(height=z)
            traced_8430_three_part_outline_2d();
    } else {
        linear_extrude(height=z)
            fit_outline_2d(insert_x, insert_y);
    }
}

module traced_8430_side_outline_2d() {
    // Conservative 2D trace of one side STL's outside envelope. The imported
    // STLs stay as overlay references, but this closed polygon is used for
    // all booleans so previews/renders do not depend on non-manifold meshes.
    x = template_8430_side_x;
    y = template_8430_side_y;
    hx = x/2;
    hy = y/2;
    c = 14;
    side_relief_w = 11;
    side_relief_h = 66;
    bottom_tab_w = 82;
    bottom_tab_d = 10;

    difference() {
        offset(r=5) offset(delta=-5)
            polygon(points=[
                [-hx + c, -hy],
                [ hx - c, -hy],
                [ hx, -hy + c],
                [ hx, -hy + 58],
                [ hx - side_relief_w, -hy + 68],
                [ hx - side_relief_w,  hy - 68],
                [ hx,  hy - 58],
                [ hx,  hy - c],
                [ hx - c,  hy],
                [-hx + c,  hy],
                [-hx,  hy - c],
                [-hx, -hy + c]
            ]);

        translate([0, -hy + bottom_tab_d/2])
            square([bottom_tab_w, bottom_tab_d + 0.5], center=true);
    }
}

module traced_8430_three_part_outline_2d() {
    union() {
        translate([-(template_8430_center_x + template_8430_side_x)/2, 0])
            traced_8430_side_outline_2d();

        rr2d(template_8430_center_x,
            template_8430_center_y,
            4);

        mirror([1,0])
            translate([-(template_8430_center_x + template_8430_side_x)/2, 0])
                traced_8430_side_outline_2d();
    }
}

module template_footprint_2d() {
    // Exact 2D footprint from the 8430 template STLs after placement.
    // Projection removes the template's vertical/internal walls from the final
    // solid because we re-extrude only the projected footprint.
    offset(delta=-0.4)
        projection(cut=false)
            template_body_for_projection();
}

module template_body_for_projection() {
    if (use_three_part_8430_template) {
        template_8430_three_part_body();
    } else {
        template_part(fit_template_lefttop, -1,  1, [-128.000, 179.200, 0]);
        template_part(fit_template_righttop, 1,  1, [-128.000, -128.000, 0]);
        template_part(fit_template_leftbottom, -1, -1, [-435.200, 179.200, 0]);
        template_part(fit_template_rightbottom, 1, -1, [-435.200, -128.000, 0]);
    }
}

module template_8430_three_part_body() {
    // Native STL origins are lower-left corners. These translations stitch the
    // three pieces left-center-right and center the combined footprint at XY 0.
    translate([-template_8430_total_x/2,
        -template_8430_side_y/2,
        -1])
        import(template_8430_left);

    translate([-template_8430_center_x/2,
        -template_8430_center_y/2,
        -1 + template_8430_center_top_align_z])
        import(template_8430_center);

    translate([template_8430_center_x/2,
        -template_8430_side_y/2,
        -1])
        import(template_8430_right);
}

module exact_8430_fit_body() {
    if (render_section_id == 1 || render_section_id == 2) {
        translate([-template_8430_total_x/2,
            -template_8430_side_y/2,
            -1])
            import(template_8430_left);
    } else if (render_section_id == 3 || render_section_id == 4) {
        translate([-template_8430_center_x/2,
            -template_8430_center_y/2,
            -1 + template_8430_center_top_align_z])
            import(template_8430_center);
    } else if (render_section_id == 5 || render_section_id == 6) {
        translate([template_8430_center_x/2,
            -template_8430_side_y/2,
            -1])
            import(template_8430_right);
    } else {
        template_8430_three_part_body();
    }
}

module height_clip(z) {
    translate([-template_8430_total_x/2 - 2,
        -template_8430_side_y/2 - 2,
        template_8430_side_bottom_z - 0.5])
        cube([template_8430_total_x + 4,
            template_8430_side_y + 4,
            z - template_8430_side_bottom_z + 0.5]);
}

module divider_bridge(z) {
    rr_prism(divider_bridge_x + divider_extra_x,
        divider_bridge_y,
        z,
        divider_bridge_r);
}

module clipped_divider_bridge(z) {
    intersection() {
        divider_bridge(z);
        fit_outline_prism(z);
    }
}

module body() {
    if (use_exact_stl_fit_body) {
        exact_8430_fit_body();
    } else {
        union() {
            // Case-fitting lower base.
            fit_outline_prism(base_height);
            clipped_divider_bridge(max(base_height, divider_bridge_h));

            // Clean Starlink support layer, clipped to the same fit outline.
            translate([0,0,base_height])
                union() {
                    fit_outline_prism(top_layer_z);
                    clipped_divider_bridge(top_layer_z);
                }
        }
    }
}

module dish_local(x, y, z) {
    translate([dish_center_x, dish_center_y, 0])
        rotate([0, 0, mini_rotate_z_deg])
            translate([x, mount_feature_y_sign*y, z])
                children();
}

module right_dish_full_height_chamfer() {
    bottom_w = 0.4;
    top_w = 2*top_lip + bottom_w;

    hull() {
        translate([dish_center_x, dish_center_y, dish_floor_z])
            right_band_prism(dish_pocket_x, dish_pocket_y, 0.4, dish_corner_r, right_dish_extra_clearance, bottom_w);
        translate([dish_center_x, dish_center_y, insert_z + 1.2])
            right_band_prism(dish_pocket_x + 2*top_lip,
                dish_pocket_y + 2*top_lip,
                0.4,
                dish_corner_r + top_lip,
                right_dish_extra_clearance,
                top_w);
    }
}

module right_dish_corner_transition_chamfer() {
    corner_span = dish_corner_r + top_lip;
    bottom_w = 0.4;
    top_w = 2*top_lip + bottom_w;
    bottom_x = dish_center_x + dish_pocket_x/2 + right_dish_extra_clearance - bottom_w/2;
    top_x = dish_center_x + dish_pocket_x/2 + right_dish_extra_clearance + top_lip - top_w/2;

    for (sy=[-1, 1]) {
        hull() {
            translate([bottom_x, dish_center_y + sy*(dish_pocket_y/2 - corner_span/2), dish_floor_z])
                rr_prism(bottom_w, corner_span, 0.4, 0.1);
            translate([top_x, dish_center_y + sy*(dish_pocket_y/2 + top_lip - corner_span/2), insert_z + 1.2])
                rr_prism(top_w, corner_span, 0.4, top_lip);
        }
    }
}

module front_back_dish_corner_transition_chamfer() {
    corner_span = dish_corner_r + top_lip;
    cut_w = right_dish_extra_clearance + top_lip + 0.6;
    cut_d = top_lip + 0.6;
    cut_x = dish_center_x + dish_pocket_x/2 + right_dish_extra_clearance - cut_w/2;
    cut_z = dish_floor_z + (dish_pocket_depth + top_lip + 3)/2 - 1;

    for (sy=[-1, 1]) {
        translate([cut_x,
            dish_center_y + sy*(dish_pocket_y/2 - cut_d/2),
            cut_z])
            cube([cut_w, cut_d, dish_pocket_depth + top_lip + 3], center=true);
    }
}

module dish_cavity() {
    translate([dish_center_x, dish_center_y, dish_floor_z])
        right_expanded_rr_prism(dish_pocket_x, dish_pocket_y, dish_pocket_depth + 2, dish_corner_r, right_dish_extra_clearance);

    hull() {
        translate([dish_center_x, dish_center_y, insert_z - top_lip])
            right_expanded_rr_prism(dish_pocket_x, dish_pocket_y, 0.4, dish_corner_r, right_dish_extra_clearance);
        translate([dish_center_x, dish_center_y, insert_z + 1.2])
            right_expanded_rr_prism(dish_pocket_x + 2*top_lip,
                dish_pocket_y + 2*top_lip,
                0.4,
                dish_corner_r + top_lip,
                right_dish_extra_clearance);
    }

    if (extend_right_dish_chamfer_to_top)
        right_dish_full_height_chamfer();

    if (extend_right_dish_chamfer_to_top)
        right_dish_corner_transition_chamfer();

    if (extend_right_dish_chamfer_to_top)
        front_back_dish_corner_transition_chamfer();

    dish_local(0, 54, floor_under_relief)
        rr_prism(mount_relief_x, mount_relief_y, mount_relief_depth + 3, mount_relief_r);

    dish_local(0, 44, floor_under_relief)
        cylinder(d=72, h=mount_relief_depth + 5);

    for (sy=[-1,1])
        translate([dish_center_x, sy*(dish_pocket_y/2 - 18), insert_z - 28])
            rr_prism(58, 42, 34, 8);
}

function accessory_cut_depth(requested_depth) =
    min(requested_depth, max(1, insert_z - accessory_floor_thickness));

module chamfered_rr_cut(cx, cy, x, y, depth, r, chamfer=accessory_chamfer) {
    cut_depth = accessory_cut_depth(depth);

    translate([cx, cy, insert_z - cut_depth])
        rr_prism(x, y, cut_depth + 2, r);

    hull() {
        translate([cx, cy, insert_z - chamfer])
            rr_prism(x, y, 0.4, r);
        translate([cx, cy, insert_z + 1.2])
            rr_prism(x + 2*chamfer, y + 2*chamfer, 0.4, r + chamfer);
    }
}

module chamfered_cylinder_cut(cx, cy, d, depth, chamfer=accessory_chamfer) {
    cut_depth = accessory_cut_depth(depth);

    translate([cx, cy, insert_z - cut_depth])
        cylinder(d=d, h=cut_depth + 2);

    hull() {
        translate([cx, cy, insert_z - chamfer])
            cylinder(d=d, h=0.4);
        translate([cx, cy, insert_z + 1.2])
            cylinder(d=d + 2*chamfer, h=0.4);
    }
}

module right_accessory_pockets() {
    if (add_right_accessory_pockets && (render_section_id == 0 || render_section_id == 5 || render_section_id == 6)) {
        chamfered_rr_cut(accessory_col_x,
            front_cable_pocket_y,
            cable_pocket_x,
            cable_pocket_y,
            cable_pocket_depth,
            cable_corner_r);

        if (render_section_id == 0 || render_section_id == 6) {
            chamfered_rr_cut(accessory_col_x,
                back_pole_channel_y,
                pole_channel_x,
                pole_channel_y,
                pole_channel_depth,
                pole_channel_r);
            chamfered_cylinder_cut(accessory_col_x,
                back_pole_knob_y,
                pole_knob_d,
                pole_channel_depth);
            chamfered_rr_cut(accessory_col_x,
                back_mount_pocket_y,
                mount_pocket_x,
                mount_pocket_y,
                mount_pocket_depth,
                mount_pocket_r);
        }
    }
}

module right_pole_relief() {
    if (add_right_pole_relief && (render_section_id == 5 || render_section_id == 6)) {
        right_side_x0 = template_8430_center_x/2;
        relief_center_x = right_side_x0 + right_pole_relief_x_offset;
        relief_y = template_8430_side_y - 2*right_pole_relief_y_margin;
        relief_z = insert_z - dish_floor_z + 3;

        translate([relief_center_x, 0, dish_floor_z + right_pole_relief_chamfer])
            rr_prism(right_pole_relief_w + 2*right_pole_relief_chamfer,
                relief_y + 2*right_pole_relief_chamfer,
                relief_z,
                right_pole_relief_r + right_pole_relief_chamfer);

        hull() {
            translate([relief_center_x, 0, dish_floor_z])
                rr_prism(right_pole_relief_w,
                    relief_y,
                    0.4,
                    right_pole_relief_r);
            translate([relief_center_x, 0, dish_floor_z + right_pole_relief_chamfer])
                rr_prism(right_pole_relief_w + 2*right_pole_relief_chamfer,
                    relief_y + 2*right_pole_relief_chamfer,
                    0.4,
                    right_pole_relief_r + right_pole_relief_chamfer);
        }
    }
}

module side_lower_material_relief() {
    if (add_side_lower_material_relief && is_side_section) {
        side_x_margin = side_lower_relief_wall;
        side_y_margin = side_lower_relief_wall;
        relief_x = template_8430_side_x - 2*side_x_margin;
        relief_y = template_8430_side_y/2 - 2*side_y_margin;
        relief_z0 = template_8430_side_bottom_z + side_lower_relief_floor;
        relief_h = max(1, dish_floor_z - relief_z0 - side_lower_relief_top_skin);
        is_front = (render_section_id == 1 || render_section_id == 5);
        side_sign = (render_section_id == 1 || render_section_id == 2) ? -1 : 1;
        side_center_x = side_sign * (template_8430_center_x/2 + template_8430_side_x/2);
        y_center = is_front
            ? -template_8430_side_y/4 - side_y_margin/2
            : template_8430_side_y/4 + side_y_margin/2;

        translate([side_center_x, y_center, relief_z0])
            rr_prism(relief_x, relief_y, relief_h, side_lower_relief_r);
    }
}

module side_top_half_material_relief() {
    if (add_side_top_half_material_relief && is_side_section) {
        side_x_margin = side_top_half_relief_wall;
        side_y_margin = side_top_half_relief_wall;
        relief_x = template_8430_side_x - 2*side_x_margin;
        relief_y = template_8430_side_y/2 - 2*side_y_margin;
        lower_z = template_8430_side_bottom_z + side_top_half_relief_bottom_skin;
        available_h = max(1, dish_floor_z - lower_z);
        relief_h = available_h * side_top_half_relief_fraction;
        relief_z0 = dish_floor_z - relief_h;
        is_front = (render_section_id == 1 || render_section_id == 5);
        side_sign = (render_section_id == 1 || render_section_id == 2) ? -1 : 1;
        side_center_x = side_sign * (template_8430_center_x/2 + template_8430_side_x/2);
        y_center = is_front
            ? -template_8430_side_y/4 - side_y_margin/2
            : template_8430_side_y/4 + side_y_margin/2;

        translate([side_center_x, y_center, relief_z0])
            rr_prism(relief_x, relief_y, relief_h + 3, side_top_half_relief_r);
    }
}

module side_leveling_feet() {
    foot_z0 = template_8430_side_bottom_z;
    foot_h = side_leveling_foot_height;
    foot_x_inset = 58;
    foot_y = dish_pocket_y/2 - 45;
    render_left = (render_section_id == 0 || render_section_id == 1 || render_section_id == 2);
    render_right = (render_section_id == 0 || render_section_id == 5 || render_section_id == 6);

    if (add_side_leveling_feet) {
        for (sx=[-1, 1]) if ((sx < 0 && render_left) || (sx > 0 && render_right)) {
            side_center_x = sx * (template_8430_center_x/2 + template_8430_side_x/2);
            for (sy=[-1, 1]) {
                translate([side_center_x - sx*foot_x_inset,
                    sy*foot_y,
                    foot_z0])
                    rr_prism(side_leveling_foot_w,
                        side_leveling_foot_d,
                        foot_h,
                        side_leveling_foot_r);
            }
        }
    }
}

module insert() {
    union() {
        difference() {
            body();
            dish_cavity();
            right_accessory_pockets();
            right_pole_relief();
            side_lower_material_relief();
            side_top_half_material_relief();
        }
        if (use_exact_stl_fit_body)
            side_leveling_feet();
    }
}

module section_clip() {
    section_overlap = 0.2;
    y_mid_overlap = 0.3;
    front_y0 = -template_8430_side_y/2 - 1;
    back_y0 = -y_mid_overlap;
    half_y = template_8430_side_y/2 + 1 + y_mid_overlap;

    is_front = (render_section_id == 1 || render_section_id == 3 || render_section_id == 5);
    y0 = is_front ? front_y0 : back_y0;

    if (render_section_id == 1 || render_section_id == 2) {
        translate([-template_8430_total_x/2 - 1, y0, -1])
            cube([template_8430_side_x + section_overlap,
                half_y,
                insert_z + 2]);
    } else if (render_section_id == 3 || render_section_id == 4) {
        translate([-template_8430_center_x/2 - section_overlap,
            y0,
            -1])
            cube([template_8430_center_x + 2*section_overlap,
                half_y,
                insert_z + 2]);
    } else if (render_section_id == 5 || render_section_id == 6) {
        translate([template_8430_center_x/2 - section_overlap,
            y0,
            -1])
            cube([template_8430_side_x + section_overlap + 1,
                half_y,
                insert_z + 2]);
    } else {
        translate([-template_8430_total_x/2 - 1, -template_8430_side_y/2 - 1, -1])
            cube([template_8430_total_x + 2,
                template_8430_side_y + 2,
                template_8430_side_z + 2]);
    }
}

module selected_insert_raw() {
    if (render_section_id == 0) {
        intersection() {
            insert();
            height_clip(insert_z);
        }
    } else {
        intersection() {
            insert();
            section_clip();
        }
    }
}

module top_trim_clip() {
    top_z = dish_floor_z + (insert_z - dish_floor_z) * trim_top_keep_fraction_above_dish;

    translate([-template_8430_total_x/2 - 5,
        -template_8430_side_y/2 - 5,
        template_8430_side_bottom_z - 5])
        cube([template_8430_total_x + 10,
            template_8430_side_y + 10,
            top_z - template_8430_side_bottom_z + 5]);
}

module selected_insert() {
    if (trim_top_above_dish_floor) {
        intersection() {
            selected_insert_raw();
            top_trim_clip();
        }
    } else {
        selected_insert_raw();
    }
}

module template_part(path, qx, qy, center_offset) {
    target_x = qx * template_spacing_x/2;
    target_y = qy * template_spacing_y/2;
    translate([target_x, target_y, -1])
        translate(center_offset)
            import(path);
}

module template_overlay() {
    if (use_three_part_8430_template) {
        if (render_section_id == 0 || render_section_id == 1 || render_section_id == 2)
            color([0.1, 0.45, 1.0, 0.22])
                translate([-template_8430_total_x/2,
                    -template_8430_side_y/2,
                    -1])
                    import(template_8430_left);
        if (render_section_id == 0 || render_section_id == 3 || render_section_id == 4)
            color([0.2, 0.9, 0.35, 0.22])
                translate([-template_8430_center_x/2,
                    -template_8430_center_y/2,
                    -1 + template_8430_center_top_align_z])
                    import(template_8430_center);
        if (render_section_id == 0 || render_section_id == 5 || render_section_id == 6)
            color([0.1, 0.75, 1.0, 0.22])
                translate([template_8430_center_x/2,
                    -template_8430_side_y/2,
                    -1])
                    import(template_8430_right);
    } else {
        color([0.1, 0.45, 1.0, 0.22])
            template_part(fit_template_lefttop, -1,  1, [-128.000, 179.200, 0]);
        color([0.1, 0.75, 1.0, 0.22])
            template_part(fit_template_righttop, 1,  1, [-128.000, -128.000, 0]);
        color([0.2, 0.9, 0.35, 0.22])
            template_part(fit_template_leftbottom, -1, -1, [-435.200, 179.200, 0]);
        color([0.4, 1.0, 0.25, 0.22])
            template_part(fit_template_rightbottom, 1, -1, [-435.200, -128.000, 0]);
    }
}

module starlink_preview() {
    color([0.9, 0.9, 0.86, 0.42])
        translate([dish_center_x, dish_center_y,
            dish_floor_z + mini_preview_floor_offset_z + mini_preview_z_lift])
            rotate([0, 0, mini_rotate_z_deg])
                rotate(mini_flip_x_180 ? [180, 0, 0] : [0, 0, 0])
                    import(mini_stl_file);
}

if (show_raw_body)
    body();
else
    selected_insert();

if (show_8430_template_overlay)
    template_overlay();

if (show_starlink_preview)
    starlink_preview();

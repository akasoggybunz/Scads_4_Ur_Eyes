// Seven loose feet for the quartered HexTrack tile: six vertex feet plus one center foot.

feet_count = 7;
feet_height = 8;
feet_diameter = 12;
foot_spacing = 18;

for (i = [0 : feet_count - 1]) {
    translate([(i - (feet_count - 1) / 2) * foot_spacing, 0, 0])
        cylinder(d = feet_diameter, h = feet_height, $fn = 6);
}

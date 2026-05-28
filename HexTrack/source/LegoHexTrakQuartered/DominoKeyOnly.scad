domino_length = 22;
domino_width = 7;
domino_height = 2.2;

module domino_key() {
    rounded = min(domino_width / 2, 2);
    linear_extrude(height = domino_height)
        offset(r = rounded, $fn = 12)
            offset(delta = -rounded)
                square([domino_length, domino_width], center = true);
}

domino_key();

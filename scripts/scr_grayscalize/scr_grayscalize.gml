function scr_grayscalize(color) {
	return make_color_hsv(color_get_hue(color), 0, color_get_value(color)/2);
}
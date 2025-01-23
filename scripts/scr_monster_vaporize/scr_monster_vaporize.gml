function scr_monster_vaporize(in_rate, in_part_speed, in_part_fade_style, in_src_downscale_x, in_src_downscale_y) {
	var inst = instance_create_depth(x, y, depth, obj_monster_vaporized);

	with (inst) {
		sprite_index = other.sprite_index; image_index = other.image_index;
		image_xscale = other.image_xscale; image_yscale = other.image_yscale;
		image_blend = other.image_blend; image_alpha = other.image_alpha;
		// image_angle = other.image_angle;

		if (!is_undefined(in_rate))
			rate = in_rate;
		if (!is_undefined(in_part_speed))
			part_speed = in_part_speed;
		if (!is_undefined(in_part_fade_style))
			part_fade_style = in_part_fade_style;
		if (!is_undefined(in_src_downscale_x))
			src_downscale_x = in_src_downscale_x;
		if (!is_undefined(in_src_downscale_y))
			src_downscale_y = in_src_downscale_y;
	}

	return inst;
}
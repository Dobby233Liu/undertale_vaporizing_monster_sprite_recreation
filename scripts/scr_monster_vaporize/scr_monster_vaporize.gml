function scr_monster_vaporize(_rate=4, _part_speed=1, _part_fade_style=0, _src_downscale_x=2, _src_downscale_y=2) {
	var inst = instance_create_depth(x, y, depth, obj_monster_vaporized);

	with (inst) {
		sprite_index = other.sprite_index; image_index = other.image_index;
		image_xscale = other.image_xscale; image_yscale = other.image_yscale;
		image_blend = other.image_blend; image_alpha = other.image_alpha;
		// image_angle = other.image_angle;

		if (!is_undefined(_rate))
			rate = _rate;
		if (!is_undefined(_part_speed))
			part_speed = _part_speed;
		if (!is_undefined(_part_fade_style))
			part_fade_style = _part_fade_style;
		if (!is_undefined(_src_downscale_x))
			src_downscale_x = _src_downscale_x;
		if (!is_undefined(_src_downscale_y))
			src_downscale_y = _src_downscale_y;
	}

	return inst;
}
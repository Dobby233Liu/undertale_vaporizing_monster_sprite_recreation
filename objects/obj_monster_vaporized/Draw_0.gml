if (!sprite_exists(sprite_index)) return;

var line_scaled = line * src_downscale_y;
draw_sprite_general(
	sprite_index, image_index,
	0, line_scaled,
	sprite_get_width(sprite_index), sprite_get_height(sprite_index) - line_scaled,
	x - sprite_xoffset, y - sprite_yoffset + line_scaled * image_yscale,
	image_xscale, image_yscale, image_angle,
	image_blend, image_blend, image_blend, image_blend, image_alpha);
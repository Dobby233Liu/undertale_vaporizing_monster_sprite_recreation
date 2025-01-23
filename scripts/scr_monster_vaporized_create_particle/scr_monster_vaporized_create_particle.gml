function scr_monster_vaporized_create_particle(xoff, xscale, color) {
	var particle = instance_create_depth(
		x - sprite_xoffset + xoff * src_downscale_x * image_xscale,
		y - sprite_yoffset + line * src_downscale_y * image_yscale,
		depth - 1, obj_monster_vaporized_particle);

	with (particle) {
		image_blend = color & 0xFFFFFF; base_blend = image_blend;
		grayscale_blend = scr_grayscalize(image_blend);

		image_alpha = (color >> 0x18 & 0xFF) / 0xFF * other.image_alpha;
		base_alpha = image_alpha;

		/* if (other.part_fade_style == 2 && other.src_downscale_x >= 4)
			sprite_index = spr_monster_vaporized_particle_circular; */

		image_xscale = other.image_xscale * other.src_downscale_x * xscale / sprite_width;
		image_yscale = other.image_yscale * other.src_downscale_y / sprite_height;
		x += sprite_xoffset; y += sprite_yoffset;

		var hspd_scale_factor = sprite_width / xscale,
			vspd_scale_factor = sprite_height;
		hspeed = random_range(-1, 1) * hspd_scale_factor * other.part_speed;
		gravity_direction = other.image_angle + 90;
		gravity = random_range(0.1, 0.35) * vspd_scale_factor * other.part_speed;

		fade_style = other.part_fade_style;
		fade_speed *= other.part_speed;
	}

	return particle;
}
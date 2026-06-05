if (delay > 0) {
	delay--;
	return;
}

if (fade_speed <= 0)
	return;

/*phy_accum += phy_rate;
while (phy_accum >= 1) {*/
_hspeed += cos(degtorad(_gravity_direction)) * _gravity * phy_rate;
_vspeed -= sin(degtorad(_gravity_direction)) * _gravity * phy_rate;
x += _hspeed * phy_rate; y += _vspeed * phy_rate;
/*	phy_accum--;
}*/

if (fade_progress >= 1) {
	instance_destroy();
	return;
}

if (fade_style == 0) {
	image_blend = merge_color(base_blend, grayscale_blend, fade_progress);
} else {
	image_blend = merge_color(base_blend, grayscale_blend, clamp(fade_progress * 2, 0, 1));
	image_alpha = lerp(base_alpha, 0, fade_progress);
}
fade_progress += fade_speed;
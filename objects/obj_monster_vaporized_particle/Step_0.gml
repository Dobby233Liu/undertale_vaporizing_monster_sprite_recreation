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

switch (fade_style) {
	case 0:
	default:
		image_blend = merge_color(base_blend, grayscale_blend, fade_progress);
		break;
	
	case 1:
		image_blend = merge_color(base_blend, grayscale_blend, clamp(fade_progress * 2, 0, 1));
		image_alpha = lerp(base_alpha, 0, fade_progress);
		break;
	
	case 2:
		if (fade_progress < 0.5)
			image_blend = merge_color(base_blend, grayscale_blend, fade_progress / 0.5);
		else
			image_blend = merge_color(grayscale_blend, toby_grey, (fade_progress - 0.5) / 0.5);
		image_alpha = lerp(base_alpha, 0, fade_progress);
		break;
}
fade_progress += fade_speed;
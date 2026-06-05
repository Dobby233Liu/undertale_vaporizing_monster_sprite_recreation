if (fade_speed <= 0)
	return;

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
fade_progress = clamp(fade_progress + fade_speed, 0, 1);
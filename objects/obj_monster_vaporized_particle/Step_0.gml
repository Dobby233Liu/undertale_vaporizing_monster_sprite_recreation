if (fade_speed <= 0)
	return;

if (fade_progress >= 1) {
	instance_destroy();
	return;
}

if (fade_style == 0) {
	image_blend = merge_color(base_blend, $494949, fade_progress);
} else {
	image_blend = merge_color(base_blend, grayscale_blend, clamp(fade_progress * 2, 0, 1));
	image_alpha = lerp(base_alpha, 0, clamp(fade_progress - fade_speed, 0, 1));
}
fade_progress = clamp(fade_progress + fade_speed, 0, 1);
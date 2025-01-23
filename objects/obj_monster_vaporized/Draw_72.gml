if (pixels_buf == undefined && sprite_exists(sprite_index)) {
	pixels_w = ceil(sprite_get_width(sprite_index) / src_downscale_x);
	pixels_h = ceil(sprite_get_height(sprite_index) / src_downscale_y);
	pixels_buf_w = scr_round_to_pow2(pixels_w);
	var pixels_buf_h = scr_round_to_pow2(pixels_h);

	var interpolation_enabled = gpu_get_texfilter();
	var depth_buffer_enabled = surface_get_depth_disable();
	// Otherwise the interpolating pixels will be extremely troubling to handle
	gpu_set_texfilter(false);
	surface_depth_disable(true);
	pixels_surf = surface_create(pixels_buf_w, pixels_buf_h);
	if (pixels_surf == -1)
		show_error("failed to create surface to obtain source pixels", false);
	surface_set_target(pixels_surf);
	draw_clear_alpha(c_black, 0);
	// Origin point is ignored here
	draw_sprite_stretched_ext(sprite_index, image_index, 0, 0, pixels_w, pixels_h, image_blend, 1);
	surface_reset_target();
	gpu_set_texfilter(interpolation_enabled);
	surface_depth_disable(depth_buffer_enabled);

	// It's assumed that the surface's pixel format is rgba8unorm.
	// Can't ensure this in GM LTS
	pixels_buf = buffer_create(pixels_buf_w * pixels_buf_h * 4, buffer_fixed, 1);
	if (pixels_buf == -1)
		show_error("failed to create buffer to obtain source pixels", false);
	buffer_get_surface(pixels_buf, pixels_surf, 0);

	surface_free(pixels_surf);
	pixels_surf = -1;

	if (chunked_mode < 0)
		chunked_mode = (pixels_w * image_xscale) > maximum_unchunked_width;
}
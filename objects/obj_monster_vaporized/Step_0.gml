if (pixels_buf == undefined || rate <= 0) return;

if (line == 0 && accumulator == 0)
	audio_play_sound(snd_vaporized, 80, false);

var produced_part = false;
accumulator += rate;
while (accumulator >= 1 && line < pixels_h) {
	var chunk_col = undefined, chunk_w = 0;
	for (var xx = 0; xx < pixels_w; xx++) {
		var valid = false, separate = false;
		var pixel = buffer_read(pixels_buf, buffer_u32);

		if ((pixel >> 0x18 & 0xFF) < (0xFF - alpha_tolerance)
			|| color_get_value(pixel & 0xFFFFFF) < (0xFF - black_tolerance)) {
			separate = true;
		} else {
			valid = true;
			if (chunk_col == undefined) {
				chunk_col = pixel; chunk_w = 1;
			} else if (chunk_col != pixel)
				separate = true;
			else if (chunked_mode)
				chunk_w++;
		}

		if (!chunked_mode) {
			if (valid)
				produced_part = !!scr_monster_vaporized_create_particle(xx, 1, pixel);
		} else if ((separate || chunk_w == chunk_max_width) && chunk_w > 0) {
			produced_part = !!scr_monster_vaporized_create_particle(xx - chunk_w, chunk_w, chunk_col);

			if (valid) {
				chunk_col = pixel; chunk_w = 1;
			} else {
				chunk_col = undefined; chunk_w = 0;
			}
		}
	}
	if (chunked_mode && chunk_w > 0)
		produced_part = !!scr_monster_vaporized_create_particle(pixels_w - chunk_w, chunk_w, chunk_col);
	if (pixels_buf_w - pixels_w > 0)
		buffer_seek(pixels_buf, buffer_seek_relative, (pixels_buf_w - pixels_w) * 4);

	line++; accumulator--;
}

if (play_chug && rate * part_speed <= 2 && produced_part) {
	audio_stop_sound(snd_chug);
	audio_play_sound(snd_chug, 50, false);
}

if (line == pixels_h)
	instance_destroy();
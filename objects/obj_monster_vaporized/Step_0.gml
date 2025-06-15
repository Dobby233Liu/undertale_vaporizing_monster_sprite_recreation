if (pixels_buf == undefined || rate <= 0) return;

if (line == 0 && accumulator == 0)
	audio_play_sound(snd_vaporized, 80, false);

var produced_part = false;
accumulator += rate;
show_debug_message(string("start_accum={0}", string_format(accumulator, 0, 2)));
var last_line_no = line;
while (accumulator >= 1 && line < pixels_h) {
	var accum_off = accumulator % 1;
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
				produced_part = !!scr_monster_vaporized_create_particle(xx, 1, pixel, accum_off);
		} else if ((separate || chunk_w == chunk_max_width) && chunk_w > 0) {
			produced_part = !!scr_monster_vaporized_create_particle(xx - chunk_w, chunk_w, chunk_col, accum_off);

			if (valid) {
				chunk_col = pixel; chunk_w = 1;
			} else {
				chunk_col = undefined; chunk_w = 0;
			}
		}
	}
	if (chunked_mode && chunk_w > 0)
		produced_part = !!scr_monster_vaporized_create_particle(pixels_w - chunk_w, chunk_w, chunk_col, accum_off);
	if (pixels_buf_w - pixels_w > 0)
		buffer_seek(pixels_buf, buffer_seek_relative, (pixels_buf_w - pixels_w) * 4);

	line++; accumulator--;
}
if (accumulator <= 0) accumulator = 0;
show_debug_message(string("took_time={0} last_lines={1} dt_lines={2} accum={3}", current_time - last_time, last_line_no, line - last_line_no, string_format(accumulator, 0, 2)));
if (line % 4 == 0) show_debug_message("--- 4 lines passed ---");
last_time = current_time;

if (play_chug && rate * part_speed <= 2 && produced_part) {
	audio_stop_sound(snd_chug);
	audio_play_sound(snd_chug, 50, false);
}

if (line == pixels_h)
	instance_destroy();
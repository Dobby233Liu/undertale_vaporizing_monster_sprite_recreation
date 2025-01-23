image_speed = 0;

src_downscale_x = 2; src_downscale_y = 2;
// 0xFF = don't skip
black_tolerance = 0xFF - 1;
alpha_tolerance = 0x80;

rate = 4;
part_speed = 1;
part_fade_style = 0;

// -1 = auto
chunked_mode = -1;
maximum_unchunked_width = 60;
// according to analysis on vanilla vapor data
chunk_max_width = 36;

// vanilla obj_vaporizer_new doesn't play snd_chug
// but I thought it would be neat to reintroduce it
play_chug = true;

pixels_surf = undefined; pixels_buf = undefined;
pixels_w = -1; pixels_h = -1;
pixels_buf_w = -1;

line = 0; accumulator = 0;
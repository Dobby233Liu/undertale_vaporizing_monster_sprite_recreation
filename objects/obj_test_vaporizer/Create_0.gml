if (sprite_index == spr_test_vaporizer) {
	image_xscale = 1; image_yscale = 1;
	image_xscale = room_width/sprite_width;
	image_yscale = room_height/sprite_height;
	x = sprite_xoffset; y = sprite_yoffset;
}

alarm[0] = 30;
if (sprite_index == spr_test_vaporizer_large) {
	image_xscale = 1; image_yscale = 1;
	image_xscale = room_width/sprite_width;
	image_yscale = room_height/sprite_height;
	x = sprite_xoffset; y = sprite_yoffset;
}
if (sprite_index == spr_test_vaporizer_asg) {
	room_speed_modifier = 3;
	room_speed = 30;
}

alarm[0] = 15;
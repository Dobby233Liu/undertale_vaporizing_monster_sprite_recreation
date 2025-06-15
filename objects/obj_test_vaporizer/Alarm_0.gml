if (sprite_index == spr_test_vaporizer_large)
	scr_monster_vaporize(5, 1, 1, 4, 4);
else
	scr_monster_vaporize(4/room_speed_modifier, 1/room_speed_modifier, 0, 2, 2);
sprite_index = noone;
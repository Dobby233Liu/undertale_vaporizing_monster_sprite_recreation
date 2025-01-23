function scr_round_to_pow2(v) {
	if (!is_numeric(v))
		show_error("input is not numeric", true);

	// crime
	v = int64(v);

	// https://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
	v--;
	v |= v >> 1;
	v |= v >> 2;
	v |= v >> 4;
	v |= v >> 8;
	v |= v >> 16;
	v |= v >> 32;
	v++;
	v += (v == 0);

	return real(v);
}
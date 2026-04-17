shader_type canvas_item;


void fragment() {
	ivec2 p = ivec2(FRAGCOORD.xy);
	vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
	float val = 0.5;

	if (p.x % 5 == 0) {
		COLOR = vec4(float(p.x)/screen_size.x, 0.0, 0.0, 1.0);
	}
	else if (p.x % 5 == 1) {
		COLOR = vec4(float(p.x)/screen_size.x, val, 0.0, 1.0);
	}
	else if (p.x % 5 == 2) {
		COLOR = vec4(float(p.x)/screen_size.x, val, val, 1.0);
	}
	else if (p.y % 5 == 3) {
		COLOR = vec4(float(p.y)/screen_size.y, 0.0, 0.0, 1.0);
	}
	else if (p.y % 5 == 4) {
		COLOR = vec4(float(p.y)/screen_size.y, val, 0.0, 1.0);
	}
	//COLOR = vec4(UV.x, 0.0, 0.0, 1.0);
}

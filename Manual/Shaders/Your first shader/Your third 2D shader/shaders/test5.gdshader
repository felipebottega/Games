shader_type canvas_item;


void fragment() {
	vec2 uv = UV;
	uv = uv - 0.5;
	float uv_size = length(uv);
	if (int(TIME) % 2 == 0) {
		COLOR.r = pow(1.0 - uv_size, 2);
	}
}

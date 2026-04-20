shader_type canvas_item;


uniform vec2 size = vec2(32.0, 28.0);
uniform sampler2D screen_texture : hint_screen_texture;


vec2 compute_delta(vec2 norm_size,  vec2 norm_uv, bool less_than_half) {
	vec2 delta;
	vec2 mix1 = mix(vec2(norm_size.x, -norm_size.y), vec2(0.0, -norm_size.y), float(norm_uv.x < 0.5));
	vec2 mix2 = mix(vec2(0.0, -norm_size.y), vec2(-norm_size.x, -norm_size.y), float(norm_uv.x < 0.5));
	vec2 mix3 = mix(mix1, mix2, float(less_than_half));
	float k = float(norm_uv.y < 0.3333333) * float(norm_uv.y / 0.3333333 < (abs(norm_uv.x - 0.5) * 2.0));
	
	delta = mix(vec2(0.0, 0.0), mix3, k);
	
	return delta;
}

void fragment() {
        vec2 norm_size = size * SCREEN_PIXEL_SIZE;
        bool less_than_half = mod(SCREEN_UV.y / 2.0, norm_size.y) / norm_size.y < 0.5;
        vec2 uv = SCREEN_UV + vec2(norm_size.x * 0.5 * float(less_than_half), 0.0);
        vec2 center_uv = floor(uv / norm_size) * norm_size;
        vec2 norm_uv = mod(uv, norm_size) / norm_size;
        
		center_uv += compute_delta(norm_size, norm_uv, less_than_half);
        COLOR = textureLod(screen_texture, center_uv, 0.0);
}

shader_type canvas_item;


uniform int iter;
uniform sampler2D input_texture;


void fragment() {
	vec2 p = FRAGCOORD.xy;
	vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
	
	if (iter == 0) {
		if (abs(p.x - p.y) < 10.0) {
			COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		}
		else {
			COLOR = vec4(1.0);
		}
	}
	else {
		if (p.y > 10.0) {
			vec2 new_p = vec2(p.x, p.y - 10.0);
			vec2 uv = new_p / screen_size; 
	    	COLOR = texture(input_texture, uv);
		}
		else {
			COLOR = vec4(1.0);
		}
	}
}

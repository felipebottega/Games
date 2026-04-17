shader_type canvas_item;


uniform int iter;
uniform sampler2D input_texture;


void fragment() {
	vec2 uv = UV;
	
	if (iter == 0) {
		if (abs(uv.x - uv.y) < 0.01) {
			COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		}
		else {
			COLOR = vec4(1.0);
		}
	}
	else {
		if (uv.y >= 0.01) {
			uv.y -= 0.01;
	    	COLOR = texture(input_texture, uv);
		}
		else {
			COLOR = vec4(1.0);
		}
	}
}

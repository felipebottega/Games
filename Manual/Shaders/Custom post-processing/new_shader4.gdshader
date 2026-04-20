shader_type canvas_item;


uniform sampler2D screen_texture : hint_screen_texture;


void fragment() {
	vec3 col = texture(screen_texture, SCREEN_UV).xyz;
	col.r = 0.6;
	
	COLOR = vec4(col, 1.0);
}

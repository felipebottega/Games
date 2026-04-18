shader_type canvas_item;


void fragment() {
	ivec2 p = ivec2(FRAGCOORD.xy);

	// Alterna preto e branco em padrão tipo xadrez 1px.
	int checker = (p.x + p.y) % 2;

	vec3 color = checker == 0 ? vec3(0.0) : vec3(1.0);

	COLOR = vec4(color, 1.0);
}
shader_type canvas_item;


void fragment() {
	vec2 uv = 2.0 * UV; // box entre (0, 0) e (2, 2)
	uv = uv - 1.0; // box entre (-1, -1) e (1, 1)
	float d = length(uv); // distância ao centro
	d -= 0.5;  // borda de 0.5 em torno do centro para escurecer
	d = abs(d); // tudo dentro do raio volta a clarear
	d = step(0.1, d); // função step: menor que 0.1 vira zero, caso contrário vira 1
	COLOR = vec4(d, d, d, 1.0); 
}

shader_type canvas_item;


void fragment() {
	vec2 uv = 2.0 * UV; // box entre (0, 0) e (2, 2)
	uv = uv - 1.0; // box entre (-1, -1) e (1, 1)
	float d = length(uv); // distância ao centro
	float frequency = 5.0;
	float speed = 1.5;
	d = sin(d * frequency + TIME * speed);  // borda para a região de escurecimento
	d = 0.05/d; // inversão de intensidade
	COLOR = vec4(d, d, d, 1.0); 
}

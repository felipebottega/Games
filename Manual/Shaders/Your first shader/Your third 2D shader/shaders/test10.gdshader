shader_type canvas_item;

vec3 palette(float t) {
	// Paleta de cores baseada em um float.
	return 0.1 + 0.8 * vec3(abs(cos(0.5+t)), sin(TAU*t) + cos(20.0 + t), cos(t));
}

void fragment() {
	vec2 uv = 2.0 * UV; // box entre (0, 0) e (2, 2)
	uv = uv - 1.0; // box entre (-1, -1) e (1, 1)
	
	float d = length(uv); // distância ao centro
	float frequency = 5.0;
	float speed = 0.5;
	d = sin(d * frequency + TIME * speed);  // borda para a região de escurecimento
	d = abs(d);
	d = 0.05/d; // inversão de intensidade
	COLOR = vec4(palette(d + TIME * speed), 1.0); 
}

shader_type canvas_item;


uniform float zoom = 2.0;
uniform vec2 center = vec2(0.0, 0.0);
uniform int max_iter = 500;
uniform float colors = 0.5;


vec3 palette(int i) {
	float t = float(i) / float(max_iter);

	// Corta exterior completamente.
	if (i < int(0.01 * float(max_iter))) {
		return vec3(0.0);
	}

	// Remapeia só a região interessante.
	t = (t - 0.1) / 0.8;

	// Melhora contraste perto da borda.
	t = pow(t, 0.2);

	// Paleta com cores distintas.
	return 0.5 + colors * cos(2.0 * colors * TAU * (t + vec3(0.0, 0.25, 0.5)));
}

vec4 compute_iteration(vec2 c) {
	vec2 z = vec2(0.0, 0.0);
	
	for (int i = 0; i < max_iter; i++) {
		// Iteração z = z^2 + c.
		z = vec2(z.x * z.x - z.y * z.y + c.x, 2.0 * z.x * z.y + c.y);
		
		// Verifica se diverge.
		if (length(z) > 2.0) {
			vec3 color = palette(i);
			return vec4(color, 1.0);
		}
		
	}
	
	return vec4(1.0, 1.0, 1.0, 1.0);
}

void fragment() {
	vec2 uv = UV;
	
	// Muda para as coordenadas entre -1 e 1.
	uv = uv * 2.0 - 1.0;
	
	// Aplica zoom.
	uv *= zoom;

	// Aplica deslocamento (pan).
	uv += center;
	
	COLOR = compute_iteration(uv);
	
	if (length(uv) < 0.01) {
		COLOR = vec4(1.0, 0.0, 0.0, 1.0);
	}
}

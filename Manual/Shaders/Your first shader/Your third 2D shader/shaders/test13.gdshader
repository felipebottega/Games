shader_type canvas_item;

uniform int n = 4; // número de divisões em blocos

vec3 palette(float t) {
	// Paleta de cores baseada em um float.
	return 0.1 + 0.8 * vec3(abs(cos(0.5+t)), sin(TAU*t) + cos(20.0 + t), cos(t));
}

void fragment() {
	vec2 uv = float(n) * UV; // box entre (0, 0) e (n, n)
	uv = uv - float(n)/2.0; // box entre (-n/2, -n/2) e (n/2, n/2)
	vec2 uv0 = uv; // memoriza o ponto original antes de cortar a parte inteira
	float d0 = length(uv0); // usaremos a distância ao centro rela para aplicar na paleta
		
	// Guarda a cor em uma variável externa ao loop.
	vec3 final_color = vec3(0.0);
		
	// A cada iteração do loop, temos um uv diferente, o que acarreta em estar repetindo  
	// o padrão em outro ponto. Este comportamento repetido cria uma estrutura 
	// com aspectos fractais.
	for (int i = 0; i < 4; i++) {
		// A função retorna a parte fracionária do número. Então dada uma coordenada
		// uv = a0.a1a2...an, a função retorna 0.a1a2...an. Como temos 4 quadrantes 
		// com partes inteiras positivas teremos 4 imagem repetidas.
		uv = fract(uv);
		uv = uv - 0.5; // ajuste para todos ficarem centralizados novamente
		
		float d = length(uv); // distância ao centro por bloco
		float frequency = 5.0;
		float speed = 0.5;
		vec3 base_palette = palette(d0 + TIME * speed);
		d = sin(d * frequency + TIME * speed);  // borda para a região de escurecimento
		d = abs(d);
		d = 0.05/d; // inversão de intensidade
		
		final_color += d * base_palette;
	}
	
	COLOR = vec4(final_color, 1.0); 
}

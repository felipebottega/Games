shader_type canvas_item;


uniform int iter;
uniform int dims = 2048;
uniform float seed = 1.0;
uniform float radius = 0.3;
uniform int pattern = 0;
uniform sampler2D input_texture;


vec4 add_noise(vec2 p) {
	// Introduz um pouco de ruído para não ter um padrão perfeito.
	if (fract(sin(dot(p, vec2(123.4, 567.8))) * seed/9.0) < 0.3) {
		return vec4(1.0, 1.0, 1.0, 1.0);
	}
	else {
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
}

vec4 pattern_0(vec2 p) {
	// Random.
	return add_noise(p);
}

vec4 pattern_1(vec2 p) {
	// Diagonal.
	if (abs(p.x - p.y) < 100.0) {
		return add_noise(p);
	}
	else {
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
}

vec4 pattern_2(vec2 p) {
	// Double diagonal.
	if (abs(p.x - p.y) < 100.0 || abs(p.x + p.y - float(dims)) < 100.0) {
		return add_noise(p);
	}
	else {
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
}

vec4 pattern_3(vec2 p) {
	// Vertical.
	if (abs(p.x - float(dims)/2.0) < 100.0) {
		return add_noise(p);
	}
	else {
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
}

vec4 pattern_4(vec2 p) {
	// Horizontal.
	if (abs(p.y - float(dims)/2.0) < 100.0) {
		return add_noise(p);
	}
	else {
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
}

vec4 pattern_5(vec2 p) {
	// Checkers.
	if (int(p.x + p.y) % 2 == 0) {
		return vec4(1.0, 1.0, 1.0, 1.0);
	}
	else {
		return vec4(0.0, 0.0, 0.0, 1.0);
	}
}

vec4 initialization(vec2 uv, vec2 p) {
	vec4 color;
	
	if (length(uv - vec2(0.5)) < radius) {
		switch (pattern) {
			case 0:
				color = pattern_0(p);
				return color;
			case 1:
				color = pattern_1(p);
				return color;
			case 2:
				color = pattern_2(p);
				return color;
			case 3:
				color = pattern_3(p);
				return color;
			case 4:
				color = pattern_4(p);
				return color;
			case 5:
				color = pattern_5(p);
				return color;
		}
    } 
	else {
		color = vec4(0.0, 0.0, 0.0, 1.0);
    }

	return color;
}

void fragment() {
    // Extrai coordenada do centro do pixel.
    vec2 p = FRAGCOORD.xy;

    // Resolução da tela (grid da simulação).
    vec2 size = 1.0 / SCREEN_PIXEL_SIZE;

    // UV da textura.
    vec2 uv = p * SCREEN_PIXEL_SIZE;

    // Tamanho de 1 pixel nas coordenadas UV.
    vec2 texel = SCREEN_PIXEL_SIZE;

    // Inicialização (posicionamento inicial das células vivas).
    if (iter == 0) {
        COLOR = initialization(uv, p);
    } 
	else {
        // Extrai o estado atual a partir da textura que foi armazenada do frame anterior. A partir
		// disso, extrai o valor do canal red para saber se o pixel é branco ou preto. Isso basta.
        float center = texture(input_texture, uv).r;

        // Verifica as estados/cores dos 8 vizinhos ao redor do pixel.
        float n1 = texture(input_texture, uv + texel * vec2(-1.0, -1.0)).r;
        float n2 = texture(input_texture, uv + texel * vec2( 0.0, -1.0)).r;
        float n3 = texture(input_texture, uv + texel * vec2( 1.0, -1.0)).r;
        float n4 = texture(input_texture, uv + texel * vec2(-1.0,  0.0)).r;
        float n5 = texture(input_texture, uv + texel * vec2( 1.0,  0.0)).r;
        float n6 = texture(input_texture, uv + texel * vec2(-1.0,  1.0)).r;
        float n7 = texture(input_texture, uv + texel * vec2( 0.0,  1.0)).r;
        float n8 = texture(input_texture, uv + texel * vec2( 1.0,  1.0)).r;

        // O total de vizinhos vivos coincide com a soma das cores extraídas acima. Um vizinho vivo
		// é branco, então terá o canal red igual a 1. Caso contrário o valor do canal será 0.
        int alive_neighbors = int(n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8);

        // Aplicação da regra do Game of Life para decidir se a célula central será preta ou branca.
        int next_color;

		// Regra para o caso da célula estar viva/branca.
        if (center > 0.5) {
            next_color = (alive_neighbors == 2 || alive_neighbors == 3) ? 1 : 0;
        } 
		// Regra para o caso da célula estar morta/preta.
		else {
            next_color = (alive_neighbors == 3) ? 1 : 0;
        }

        // Atualização do estado/cor da célula.
        COLOR = vec4(vec3(float(next_color)), 1.0);
    }
}
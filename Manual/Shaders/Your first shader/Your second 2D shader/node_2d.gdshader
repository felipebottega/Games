shader_type canvas_item;


uniform int effect;
uniform float frequency = 10.0;
uniform float amplitude = 0.02;
uniform float speed = 2.0;
uniform float falloff_strength = 10.0;
uniform float highlight_intensity = 0.6;
uniform float highlight_sharpness = 4.0;
uniform float threshold = 0.8;
uniform float rgb_offset = 0.01;
uniform float pixel_size = 100.0; // Quantos "blocos" cabem na tela (quanto maior, menor o pixel).
uniform float scanline_frequency = 800.0;
uniform float outline_thickness = 0.002; // Espessura do contorno


vec4 waves(sampler2D tex, vec2 uv) {
	float wave = sin(uv.x * frequency + TIME * speed);
	uv.y += wave * amplitude;
	return texture(tex, uv);
}

vec4 ripple(sampler2D tex, vec2 uv, vec2 diff, float dist) {
	// Direção radial 
	vec2 direction = normalize(diff);
	
	// Onda
	float wave = sin(dist * frequency - TIME * speed);
	uv += direction * wave * amplitude;
	return texture(tex, uv);
}

vec4 shiny_water(sampler2D tex, vec2 uv, vec2 diff, float dist) {
	// Direção radial (igual ao ripple)
	vec2 direction = normalize(diff);

	// Onda
	float wave = sin(dist * frequency - TIME * speed);

	// Atenuação com distância.
	float falloff = 1.0 / (1.0 + dist * falloff_strength);

	// Distorção do UV.
	uv += direction * wave * falloff * amplitude;
	vec4 col = texture(tex, uv);

	// Direção da luz (fixa).
	vec2 light_dir = normalize(vec2(1.0, -1.0));

	// "Normal" fake baseada na onda.
	vec2 fake_normal = direction * wave;

	// Quanto a luz bate nessa "superfície".
	float light = dot(normalize(fake_normal), light_dir);

	// Intensidade do brilho.
	float highlight = pow(max(light, 0.0), highlight_sharpness);

	// Aplica brilho na cor.
	col.rgb += highlight * falloff * highlight_intensity;

	return col;
}

vec4 glitch(sampler2D tex, vec2 uv) {
	float wave = sin(uv.y * frequency + TIME * speed);
	float mask = step(threshold, wave);
	uv.x += mask * amplitude;
	return texture(tex, uv);
}

vec4 rgb_split(sampler2D tex, vec2 uv) {
	float r = texture(tex, uv + vec2(rgb_offset, 0.0)).r;
	float g = texture(tex, uv).g;
	float b = texture(tex, uv - vec2(rgb_offset, 0.0)).b;
	return vec4(r, g, b, 1.0);
}

vec4 heat_distortion(sampler2D tex, vec2 uv) {
	float wave = sin(uv.y * frequency + TIME * speed);
	uv.x += wave * amplitude;
	return texture(tex, uv);
}

vec4 pixelation(sampler2D tex, vec2 uv) {
	// Escala o UV de [0,1] para uma grade (ex: 0–100).
	vec2 uv_scaled = uv * pixel_size;

	// Remove a parte decimal, todos os valores dentro do mesmo bloco ficam iguais.
	vec2 uv_snapped = floor(uv_scaled);

	// Volta para o espaço UV [0,1], agora com valores "travados" na grade.
	vec2 uv_final = uv_snapped / pixel_size;

	// Amostra a textura usando o UV quantizado → cria o efeito de pixelização.
	return texture(tex, uv_final);
}

vec4 scanlines_crt(sampler2D tex, vec2 uv) {
	// Gera uma senoide baseada na posição vertical.
	// Frequência alta -> muitas linhas finas (efeito CRT).
	float scanline_intensity = 0.1;
	float lines = sin(uv.y * scanline_frequency) * scanline_intensity;
	vec4 col = texture(tex, uv);
	col.rgb -= lines;
	return col;
}

vec4 outline(sampler2D tex, vec2 uv) {
	// Desenha um contorno ao redor de áreas opacas da textura,
	// detectando pixels transparentes que possuem vizinhos com alpha > 0.
	// Usa amostragem dos 4 lados (cima, baixo, esquerda, direita).
	// A textura DEVE possuir transparência (alpha).
	float alpha = texture(tex, uv).a;

	float edge = texture(tex, uv + vec2(outline_thickness, 0)).a
	           + texture(tex, uv - vec2(outline_thickness, 0)).a
	           + texture(tex, uv + vec2(0, outline_thickness)).a
	           + texture(tex, uv - vec2(0, outline_thickness)).a;

	// Pixel transparente com vizinho opaco, desenha contorno preto.
	if (alpha < 0.01 && edge > 0.0) {
		return vec4(0.0, 0.0, 0.0, 1.0);
	} 
	else {
		return texture(tex, uv);
	}
}

vec4 zoom_pulse(sampler2D tex, vec2 uv, vec2 center) {
	uv -= center;
	float scale = 1.0 + sin(TIME * speed) * amplitude;
	uv *= scale;
	return texture(tex, uv + center);
}

vec4 mask(sampler2D tex, vec2 uv) {
	float mask = sin(uv.x * frequency + TIME * speed);
	vec4 col = texture(tex, uv);
	col.a *= mask;
	return col;
}


void vertex() {
	// Called for every vertex the material is visible on.
}


void fragment() {
	vec2 uv = UV;
	vec2 center = vec2(0.5, 0.5);
	vec2 diff = uv - center;
	float dist = length(diff);
	vec4 color;
		
	switch(effect) {
		case 0:
			COLOR = waves(TEXTURE, UV);
			break;
		case 1:
			COLOR = ripple(TEXTURE, UV, diff, dist);
			break;
		case 2:
			COLOR = shiny_water(TEXTURE, UV, diff, dist);
			break;
		case 3:
			COLOR = glitch(TEXTURE, UV);
			break;
		case 4:
			COLOR = rgb_split(TEXTURE, UV);
			break;
		case 5:
			COLOR = heat_distortion(TEXTURE, UV);
			break;
		case 6:
			COLOR = pixelation(TEXTURE, UV);
			break;
		case 7:
			COLOR = scanlines_crt(TEXTURE, UV);
			break;
		case 8:
			COLOR = outline(TEXTURE, UV);
			break;
		case 9:
			COLOR = zoom_pulse(TEXTURE, UV, center);
			break;
		case 10:
			COLOR = mask(TEXTURE, UV);
			break;
		case 11:
			break;
	}
	
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

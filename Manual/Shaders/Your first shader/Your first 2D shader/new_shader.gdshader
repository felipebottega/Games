shader_type canvas_item;

uniform float aa = 0.0;
uniform float bb = 0.0;
uniform float blue = 1.0;

void vertex() {
	//VERTEX += vec2(-100.0, 0.0);
	//VERTEX.x += VERTEX.y * b;
	//VERTEX += vec2(cos(TIME)*100.0, sin(TIME)*100.0);
	//VERTEX.x += VERTEX.y * sin(TIME);
	//VERTEX.y += sin(VERTEX.x * 0.05 + TIME * 5.0) * 50.0;
	//VERTEX.y += sin(VERTEX.x * 0.05 + TIME) * 100.0;
    //VERTEX.x += cos(VERTEX.y * 0.05 + TIME) * 100.0;
}

void fragment() {
	//COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	//COLOR = vec4(UV, 0.5, 1.0);
	//COLOR = texture(TEXTURE, UV);
	//COLOR.b = blue;
	//COLOR = texture(TEXTURE, vec2(UV.x * 1.7, UV.y));
	//COLOR = texture(TEXTURE, UV + vec2(0.7, 0.0));
	//COLOR = texture(TEXTURE, vec2(1.0 - UV.x, UV.y));
	//COLOR = texture(TEXTURE, vec2(UV.x * a, UV.y));
	
	// ondulação
	//vec2 uv = UV;
    //uv.y += sin(uv.x * 10.0 + TIME * 2.0) * 0.02;
    //COLOR = texture(TEXTURE, uv);
	
	// ripple
    //vec2 center = vec2(0.5, 0.5);
    //vec2 uv = UV;
    //vec2 diff = uv - center;
    //float dist = length(diff);
    //uv += normalize(diff) * sin(dist * 100.0 - TIME * 2.0) * 0.02;
    //COLOR = texture(TEXTURE, uv);
	
	// água com brilho
	//vec2 center = vec2(0.5, 0.5);
    //vec2 uv = UV;
    //vec2 diff = uv - center;
    //float dist = length(diff);
    //vec2 dir = diff / max(dist, 0.0001);
    // ripple
    //float wave = sin(dist * 80.0 - TIME * 2.0);
    // decaimento (importante pra ficar natural)
    //float falloff = 1.0 / (1.0 + dist * 10.0);
    // distorção UV
    //uv += dir * wave * falloff * 0.01;
    //vec4 col = texture(TEXTURE, uv);
    // ✨ brilho baseado na onda
    //float highlight = pow(max(wave, 0.0), 4.0);
    //col.rgb += highlight * falloff * 0.6;
    //COLOR = col;
	
	// água com brilho 2
	//vec2 center = vec2(0.5, 0.5);
    //vec2 uv = UV;
    //vec2 diff = uv - center;
    //float dist = length(diff);
    //vec2 dir = diff / max(dist, 0.0001);
    // ripple
    //float wave = sin(dist * 80.0 - TIME * 4.0);
    //float falloff = 1.0 / (1.0 + dist * 10.0);
    // distorção
    //uv += dir * wave * falloff * 0.05;
    //vec4 col = texture(TEXTURE, uv);
    // 💡 direção da luz (canto superior direito)
    //vec2 light_dir = normalize(vec2(1.0, -1.0));
    // 🧠 "normal fake" baseada na direção do ripple
    //vec2 fake_normal = dir * wave;
    // ✨ intensidade do brilho baseada na direção da luz
    //float light = dot(normalize(fake_normal), light_dir);
    //float highlight = pow(max(light, 0.0), 4.0);
    //col.rgb += highlight * falloff * 0.6;
    //COLOR = col;
	
	// Glitch
	//vec2 uv = UV;
	//uv.x += step(0.8, sin(UV.y * 50.0 + TIME * 10.0)) * 0.05;
	//COLOR = texture(TEXTURE, uv);
	
	// RGB Split (aberração cromática)
	//float offset = 0.01;
    //float r = texture(TEXTURE, UV + vec2(offset, 0.0)).r;
    //float g = texture(TEXTURE, UV).g;
    //float b = texture(TEXTURE, UV - vec2(offset, 0.0)).b;
    //COLOR = vec4(r, g, b, 1.0);
	
	// Heat distortion (ar quente)
	//vec2 uv = UV;
	//uv.x += sin(UV.y * 10.0 + TIME * 2.0) * 0.05;
    //COLOR = texture(TEXTURE, uv);
	
	// Pixelation
	//float size = 100.0;
	//vec2 uv = floor(UV * size) / size;
	//COLOR = texture(TEXTURE, uv);
	
	// Scanlines (CRT)
	//float lines = sin(UV.y * 800.0) * 0.1;
	//vec4 col = texture(TEXTURE, UV);
	//col.rgb -= lines;
	//COLOR = col;
	
	// Outline (contorno)
	//float offset = 0.002;
	//float alpha = texture(TEXTURE, UV).a;
	//float edge = texture(TEXTURE, UV + vec2(offset,0)).a
    //       + texture(TEXTURE, UV - vec2(offset,0)).a
    //       + texture(TEXTURE, UV + vec2(0,offset)).a
    //       + texture(TEXTURE, UV - vec2(0,offset)).a;
	//if (alpha == 0.0 && edge > 0.0) {
    //	COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	//} else {
    //	COLOR = texture(TEXTURE, UV);
	//}
	
	// Zoom pulsante
    //vec2 center = vec2(0.5);
    //vec2 uv = UV - center;
    //uv *= 1.0 + sin(TIME) * 0.2;
    //COLOR = texture(TEXTURE, uv + center);
	
	// Mask animada
	float mask = sin(UV.x * 10.0 + TIME);
    vec4 col = texture(TEXTURE, UV);
    col.a *= mask;
    COLOR = col;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

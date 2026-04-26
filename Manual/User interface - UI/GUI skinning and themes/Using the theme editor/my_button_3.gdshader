shader_type canvas_item;

uniform float line_speed = 2.0;     // velocidade das linhas
uniform float line_density = 200.0; // quantidade de linhas
uniform float line_intensity = 0.15; // força do efeito
uniform float alpha = 0.85;         // transparência geral

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // cria linhas horizontais animadas
    float lines = sin((UV.y * line_density) + TIME * line_speed);

    // normaliza (0 a 1)
    lines = (lines + 1.0) * 0.5;

    // aplica intensidade
    float line_effect = mix(1.0 - line_intensity, 1.0, lines);

    // aplica efeito na cor
    tex.rgb *= line_effect;

    // leve flicker (opcional)
    float flicker = sin(TIME * 10.0) * 0.02;
    tex.rgb += flicker;

    // aplica transparência
    tex.a *= alpha;
	tex.g = 1.0;

    COLOR = tex;
}
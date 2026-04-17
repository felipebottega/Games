shader_type canvas_item;

uniform int iter;
uniform sampler2D input_texture;

void fragment() {

    // ============================================================
    // 1. PIXEL GRID
    // ============================================================
    vec2 p = FRAGCOORD.xy;

    // resolução da tela (grid da simulação)
    vec2 size = 1.0 / SCREEN_PIXEL_SIZE;

    // UV da textura
    vec2 uv = p * SCREEN_PIXEL_SIZE;

    // 1 pixel em UV
    vec2 texel = SCREEN_PIXEL_SIZE;


    // ============================================================
    // 2. INICIALIZAÇÃO
    // ============================================================
    if (iter == 0) {

        // padrão inicial simples
        // (diagonal viva)
        if (abs(p.x - p.y) < 10.0) {
            COLOR = vec4(0.0, 0.0, 0.0, 1.0);
        } else {
			if (p.x > 100.0) {
            	COLOR = vec4(1.0);
			}
			else {
				COLOR = vec4(0.0, 0.0, 0.0, 1.0);
			}
        }

    } else {

        // ========================================================
        // 3. ESTADO ATUAL
        // ========================================================
        float center = texture(input_texture, uv).r;

        // ========================================================
        // 4. VIZINHOS (8 DIREÇÕES)
        // ========================================================
        float n1 = texture(input_texture, uv + texel * vec2(-1.0, -1.0)).r;
        float n2 = texture(input_texture, uv + texel * vec2( 0.0, -1.0)).r;
        float n3 = texture(input_texture, uv + texel * vec2( 1.0, -1.0)).r;

        float n4 = texture(input_texture, uv + texel * vec2(-1.0,  0.0)).r;
        float n5 = texture(input_texture, uv + texel * vec2( 1.0,  0.0)).r;

        float n6 = texture(input_texture, uv + texel * vec2(-1.0,  1.0)).r;
        float n7 = texture(input_texture, uv + texel * vec2( 0.0,  1.0)).r;
        float n8 = texture(input_texture, uv + texel * vec2( 1.0,  1.0)).r;

        float alive_neighbors = n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8;

        // ========================================================
        // 5. REGRAS B3 / S23 (CONWAY REAL)
        // ========================================================

        float next;

        if (center > 0.5) {
            // célula viva
            next = (alive_neighbors == 2.0 || alive_neighbors == 3.0) ? 1.0 : 0.0;
        } else {
            // célula morta
            next = (alive_neighbors == 3.0) ? 1.0 : 0.0;
        }

        // ========================================================
        // 6. SAÍDA
        // ========================================================
        COLOR = vec4(vec3(next), 1.0);
    }
}
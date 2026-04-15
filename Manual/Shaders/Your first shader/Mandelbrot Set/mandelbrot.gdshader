shader_type canvas_item;

uniform vec2 center = vec2(-0.5, 0.0);
uniform float zoom = 3.0;

void fragment() {
    vec2 uv = SCREEN_UV;

    vec2 p = uv * 2.0 - 1.0;
    p.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;

    vec2 c = center + p * zoom;

    vec2 z = vec2(0.0);

    float iter = 0.0;
    float max_iter = 100.0;

    for (int i = 0; i < 100; i++) {
        if (dot(z, z) > 4.0) break;

        z = vec2(
            z.x*z.x - z.y*z.y,
            2.0*z.x*z.y
        ) + c;

        iter += 1.0;
    }

    float t = iter / max_iter;

    COLOR = vec4(vec3(t), 1.0);
}
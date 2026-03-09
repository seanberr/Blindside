shader_type canvas_item;

uniform float max_lod : hint_range(0.0, 5.0) = 3.0;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Player positions in SCREEN_UV space (0–1 range)
uniform vec2 player1_uv;
uniform vec2 player2_uv;

uniform float clear_radius = 0.15;
uniform float softness = 0.05;

void fragment()
{
    float d1 = distance(SCREEN_UV, player1_uv);
    float d2 = distance(SCREEN_UV, player2_uv);

    // Take nearest player
    float d = min(d1, d2);

    // Smooth transition from clear to blurred
    float blur_strength = smoothstep(clear_radius, clear_radius + softness, d);

    float lod = blur_strength * max_lod;

    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, lod);
    COLOR = color;
}
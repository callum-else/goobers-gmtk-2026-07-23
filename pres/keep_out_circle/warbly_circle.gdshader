shader_type spatial;
render_mode unshaded, cull_back, blend_mix, depth_draw_opaque;

uniform float radius : hint_range(0.0, 1.0) = 0.4;
uniform float line_width : hint_range(0.0, 0.2) = 0.03;
uniform float wobble_amount : hint_range(0.0, 0.5) = 0.08;
uniform float wobble_freq : hint_range(1.0, 20.0) = 6.0;
uniform float frame_rate : hint_range(1.0, 24.0) = 8.0;
uniform vec4 line_color : source_color = vec4(0.1, 0.1, 0.1, 1.0);

// hash-based value noise
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

void fragment() {
    vec2 centered_uv = UV - vec2(0.5);
    float angle = atan(centered_uv.y, centered_uv.x);
    float dist = length(centered_uv);

    float frame_seed = mod(floor(TIME * frame_rate), 2.0);
    vec2 frame_offset = vec2(frame_seed * 1000.0);
    float n = noise(vec2(cos(angle), sin(angle)) * wobble_freq + frame_offset);
    float wobble = (n - 0.5) * wobble_amount;

    float ring = abs(dist - (radius + wobble));
    float mask = 1.0 - step(line_width, ring);

    ALBEDO = line_color.rgb;
    ALPHA = mask * line_color.a;
}
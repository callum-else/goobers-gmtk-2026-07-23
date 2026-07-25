shader_type canvas_item;

// Circle wipe. progress 0 = fully clear, progress 1 = fully opaque.
// The clear circle in the center shrinks as progress increases.

instance uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	// viewport resolution from the screen pixel size, to correct aspect ratio
	vec2 res = 1.0 / SCREEN_PIXEL_SIZE;
	float aspect = res.x / res.y;
	vec2 p = SCREEN_UV - vec2(0.5);
	p.x *= aspect;                 // stretch x so distance is circular
	float max_r = length(vec2(0.5 * aspect, 0.5)); // corner distance
	float dist = length(p) / max_r;                // normalized 0..1
	float radius = 1.0 - progress;                 // shrinks as progress increases
	float alpha = step(radius, dist);
	COLOR = vec4(color.rgb, alpha);
}

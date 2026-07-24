shader_type canvas_item;

// 1.0 = full border, 0.0 = fully wiped away
instance uniform float progress : hint_range(0.0, 1.0) = 1.0;
uniform float border_thickness_px : hint_range(0.0, 100.0) = 6.0;
uniform bool clockwise_mode = false; // false = both sides meet at bottom-center, true = single clockwise sweep
uniform vec4 border_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

varying vec2 v_vertex;

void vertex() {
	v_vertex = VERTEX;
}

void fragment() {
	vec2 size = v_vertex / max(UV, vec2(0.000001));
	vec2 pixel = v_vertex;

	float dist_left = pixel.x;
	float dist_right = size.x - pixel.x;
	float dist_top = pixel.y;
	float dist_bottom = size.y - pixel.y;
	float dist_to_edge = min(min(dist_left, dist_right), min(dist_top, dist_bottom));

	if (dist_to_edge > border_thickness_px) {
		COLOR = vec4(0.0);
	} else {
		// Walk clockwise around the border, starting at top-center (t = 0).
		float half_w = size.x * 0.5;
		float perimeter = 2.0 * (size.x + size.y);
		float t;

		if (dist_top <= min(dist_left, min(dist_right, dist_bottom))) {
			t = pixel.x >= half_w ? pixel.x - half_w : perimeter - (half_w - pixel.x);
		} else if (dist_right <= min(dist_bottom, dist_left)) {
			t = half_w + pixel.y;
		} else if (dist_bottom <= dist_left) {
			t = half_w + size.y + (size.x - pixel.x);
		} else {
			t = half_w + size.y + size.x + (size.y - pixel.y);
		}

		float border_pos = t / perimeter; // 0..1, clockwise from top-center
		float erased = 1.0 - progress;

		bool visible;
		if (clockwise_mode) {
			visible = border_pos >= erased;
		} else {
			float dist_from_top = min(border_pos, 1.0 - border_pos); // 0 at top, 0.5 at bottom
			visible = dist_from_top >= erased * 0.5;
		}

		COLOR = visible ? border_color : vec4(0.0);
	}
}

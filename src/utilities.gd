class_name Utilities

static func flatten_vector(vector: Vector3) -> Vector3:
	vector.y = 0
	return vector

static func get_radial_spawn_positions(
	count: int,
	min_distance: float,
	max_distance: float,
	height: float = 0.1
) -> Array[Vector3]:
	var positions: Array[Vector3] = []
	if count <= 0:
		return positions
	var angle_step := TAU / count
	var angle_offset := randf() * TAU
	for i in range(count):
		var angle := angle_offset + angle_step * i
		var radius := randf_range(min_distance, max_distance)
		positions.append(Vector3(cos(angle) * radius, height, sin(angle) * radius))
	return positions

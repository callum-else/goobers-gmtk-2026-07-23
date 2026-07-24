extends Node
class_name KeepOutCircleGoobSpawner3D

@export var goob_scene: PackedScene
@export var goob_count: int
@export var min_distribution_distance: float
@export var max_distribution_distance: float

func _ready() -> void:
	var positions := _calculate_spawn_positions()
	for position in positions:
		var goob = goob_scene.instantiate() as GoobBody3D
		add_child(goob)
		goob.global_position = position

func _calculate_spawn_positions() -> Array[Vector3]:
	var positions: Array[Vector3] = []
	if goob_count <= 0:
		return positions

	var angle_step := TAU / goob_count
	var angle_offset := randf() * TAU
	for i in range(goob_count):
		var angle := angle_offset + angle_step * i
		var radius := randf_range(min_distribution_distance, max_distribution_distance)
		positions.append(Vector3(cos(angle) * radius, 0.1, sin(angle) * radius))
	return positions

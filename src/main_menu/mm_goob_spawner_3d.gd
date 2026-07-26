extends Node3D
class_name MainMenuGoobSpawner3D

@export var goob_scene: PackedScene
@export var goob_count: int
@export var min_distribution_distance: float
@export var max_distribution_distance: float

func _ready() -> void:
	var positions := Utilities.get_radial_spawn_positions(
		goob_count,
		min_distribution_distance,
		max_distribution_distance)
	for pos in positions:
		var goob = goob_scene.instantiate() as GoobBody3D
		var body_frames = GoobState.get_random_body()
		var body_color = GoobState.get_random_color()
		add_child(goob)
		goob.setup(body_frames, body_color)
		goob.global_position = pos

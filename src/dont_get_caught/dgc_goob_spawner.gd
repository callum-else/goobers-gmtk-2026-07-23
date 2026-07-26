extends Node3D
class_name DontGetCaughtGoobSpawner3D

@export var goob_scene: PackedScene
@export var goob_count: int
@export var min_distribution_distance: float
@export var max_distribution_distance: float

var _goobs: Array[GoobBody3D] = []

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
		_goobs.append(goob)
	Events.on_level_start.connect(_on_level_start)

func _exit_tree() -> void:
	Events.on_level_start.disconnect(_on_level_start)

func _on_level_start() -> void:
	if (_goobs.is_empty()):
		return
	var goob: GoobBody3D = _goobs.pick_random()
	goob.set_current_state(Constants.GoobState.TAGGED, GoobState3D.Priority.HIGH)

func get_goobs() -> Array[GoobBody3D]:
	return _goobs

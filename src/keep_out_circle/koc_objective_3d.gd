extends Node

@onready var _area: Area3D = $Area3D

func _ready() -> void:
	Events.on_level_timeout.connect(_on_level_timeout)

func _exit_tree() -> void:
	Events.on_level_timeout.disconnect(_on_level_timeout)

func _on_level_timeout() -> void:
	var bodies := _area.get_overlapping_bodies()
	if (bodies.is_empty()):
		LevelState.set_level_completed(Constants.LevelId.KEEP_OUT_CIRCLE)
	Events.freeze_goobs.emit(GoobState3D.Priority.FINAL)

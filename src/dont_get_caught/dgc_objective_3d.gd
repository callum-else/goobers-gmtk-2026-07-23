extends Node3D

@export var spawner: DontGetCaughtGoobSpawner3D

func _ready() -> void:
	Events.on_level_timeout.connect(_on_level_timeout)

func _exit_tree() -> void:
	Events.on_level_timeout.disconnect(_on_level_timeout)

func _on_level_timeout() -> void:
	for goob in spawner.get_goobs():
		if (goob.get_current_state() != Constants.GoobState.TAGGED):
			Events.on_level_success.emit(Constants.LevelId.DONT_GET_CAUGHT)
			break
	Events.freeze_goobs.emit(GoobState3D.Priority.FINAL)

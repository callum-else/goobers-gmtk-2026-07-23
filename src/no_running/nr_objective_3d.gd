extends Node

@export var spawner: NoRunningGoobSpawner3D

func _ready() -> void:
	Events.on_level_timeout.connect(_on_level_timeout)

func _exit_tree() -> void:
	Events.on_level_timeout.disconnect(_on_level_timeout)

func _on_level_timeout() -> void:
	_check_completed_state()
	Events.freeze_goobs.emit(GoobState3D.Priority.FINAL)

func _check_completed_state() -> void:
	for goob in spawner.get_goobs():
		if (goob.get_current_state() == Constants.GoobState.RUN):
			return
	Events.on_level_success.emit(Constants.LevelId.NO_RUNNING)

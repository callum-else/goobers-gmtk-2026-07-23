extends Node3D
class_name KeepOutCircleLevel

func _ready() -> void:
	Events.on_level_start.connect(_on_level_start)
	Events.on_level_timeout.connect(_on_level_timeout)
	Events.update_raycast_input.emit(false)
	Events.on_level_ready.emit()

func _exit_tree() -> void:
	Events.on_level_start.disconnect(_on_level_start)
	Events.on_level_timeout.disconnect(_on_level_timeout)

func _on_level_start() -> void:
	Events.update_raycast_input.emit(true)

func _on_level_timeout() -> void:
	Events.update_raycast_input.emit(false)

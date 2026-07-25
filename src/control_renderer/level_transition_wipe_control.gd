extends Control
class_name LevelTransitionWipeControl

@onready var _control: ColorRect = $WipeControlRect

func set_progress(percent: float) -> void:
	_control.set_instance_shader_parameter("progress", percent)

func get_progress() -> float:
	var progress = _control.get_instance_shader_parameter("progress")
	return progress as float if progress else 0.0

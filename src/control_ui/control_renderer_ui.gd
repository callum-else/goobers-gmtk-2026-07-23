extends Control
class_name ControlRendererUI

@onready var _duration_control: LevelDurationCountdownControl = $LevelDurationCountdownControl
@onready var _start_control: LevelStartCountdownControl = $LevelStartCountdownControl
@onready var _wipe_control: LevelTransitionWipeControl = $LevelTransitionWipeControl
@onready var _progress_control: LevelProgressControl = $LevelProgressControl

var _circle_wipe_tween: Tween

func block_view() -> void:
	if (_circle_wipe_tween):
		_circle_wipe_tween.kill()
	_wipe_control.set_progress(1)

func animate_circle_wipe_async(closed: bool, duration: float = 1) -> void:
	if (_circle_wipe_tween):
		_circle_wipe_tween.kill()
	_circle_wipe_tween = create_tween()
	var current := _wipe_control.get_progress()
	_circle_wipe_tween.tween_method(
		_wipe_control.set_progress, 
		current,
		1.0 if closed else 0.0,
		duration)
	await _circle_wipe_tween.finished

func reset_level_anims(full_clear: bool = false) -> void:
	_duration_control.disable()
	_start_control.disable()
	if (not full_clear):
		_duration_control.enable_border()

func animate_level_start_async(instruction: String) -> void:
	await _start_control.wait_for_timeout_async(instruction)

func animate_level_duration_async(duration: float) -> void:
	_duration_control.enable_label(str(ceili(duration)))
	await _duration_control.wait_for_timeout_async(duration)

func animate_progress_async(
	current_level: Constants.LevelId, 
	level_data: Array[Types.LevelData]
) -> void:
	await _progress_control.animate_progress_async(current_level, level_data)

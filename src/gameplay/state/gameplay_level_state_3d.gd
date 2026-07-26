extends GameplayState3D
class_name GameplayLevelState3D

@onready var _timeout_hang: Timer = $TimeoutHangTimer

var _args: GameplayState3D.SetupArgs

func get_id() -> Constants.GameplayState:
	return Constants.GameplayState.LEVEL_START

func setup(args: SetupArgs) -> void:
	_args = args

func enter() -> void:
	_args.control_renderer.reset_level_anims()
	var level_3d := _args.level_manager.get_current_level()
	var config := level_3d.level_config
	await _args.control_renderer.animate_circle_wipe_async(false)
	await _args.control_renderer.animate_level_start_async(
		config.instruction)
	Events.on_level_start.emit()
	await _args.control_renderer.animate_level_duration_async(
		config.level_duration)
	Events.on_level_timeout.emit()
	_timeout_hang.start()
	await _timeout_hang.timeout
	request_state.emit(Constants.GameplayState.LEVEL_TRANSITION)

func exit() -> void:
	pass

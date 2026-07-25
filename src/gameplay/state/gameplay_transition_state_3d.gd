extends GameplayState3D
class_name GameplayTransitionState3D

@onready var _timer: Timer = $MinimumTransitionWaitTimer

var _args: GameplayState3D.SetupArgs

func get_id() -> Constants.GameplayState:
	return Constants.GameplayState.LEVEL_TRANSITION

func setup(args: SetupArgs) -> void:
	_args = args

func enter() -> void:
	Events.update_raycast_input.emit(false)
	await _args.control_renderer.animate_circle_wipe_async(true)
	var levels := _args.level_manager.get_remaining_levels()
	if (levels.is_empty()):
		request_state.emit(Constants.GameplayState.GAME_OVER)
		_timer.start()
		await _timer.timeout
		return
	var new_level: Constants.LevelId = levels.pick_random()
	_timer.start()
	_args.level_manager.set_current_level(new_level)
	if (not _timer.is_stopped()):
		await _timer.timeout
	request_state.emit(Constants.GameplayState.LEVEL_START)

func exit() -> void:
	pass

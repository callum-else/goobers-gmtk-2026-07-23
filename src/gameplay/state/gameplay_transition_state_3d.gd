extends GameplayState3D
class_name GameplayTransitionState3D

var _args: GameplayState3D.SetupArgs

func get_id() -> Constants.GameplayState:
	return Constants.GameplayState.LEVEL_TRANSITION

func setup(args: SetupArgs) -> void:
	_args = args

func enter() -> void:
	Events.update_raycast_input.emit(false)
	await _args.control_renderer.animate_circle_wipe_async(true)
	var spawned := _args.level_manager.try_spawn_next_level()
	var current_level := _args.level_manager.get_current_level_id()
	var level_data := _args.level_manager.get_ordered_level_data()
	await _args.control_renderer.animate_progress_async(current_level, level_data)
	if (not spawned):
		request_state.emit(Constants.GameplayState.GAME_OVER)
		return
	request_state.emit(Constants.GameplayState.LEVEL_START)

func exit() -> void:
	pass

extends GameplayState3D
class_name GameplayGameOverState3D

var _args: GameplayState3D.SetupArgs

func get_id() -> Constants.GameplayState:
	return Constants.GameplayState.GAME_OVER

func setup(args: SetupArgs) -> void:
	_args = args

func enter() -> void:
	_args.control_renderer.reset_level_anims(true)
	_args.level_manager.goto_win_level()
	await _args.control_renderer.animate_circle_wipe_async(false, 1.5)

func exit() -> void:
	pass

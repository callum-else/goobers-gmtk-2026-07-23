extends GameplayState3D
class_name GameplayConfigurationState3D

@export var goob_body_frames: Array[SpriteFrames]
@export var goob_body_colors: Array[Color]

var _args: GameplayState3D.SetupArgs

func get_id() -> Constants.GameplayState:
	return Constants.GameplayState.CONFIGURATION

func setup(args: SetupArgs) -> void:
	_args = args

func enter() -> void:
	_args.control_renderer.block_view()
	GoobState.set_body_frames(goob_body_frames)
	GoobState.set_body_colors(goob_body_colors)
	request_state.emit(Constants.GameplayState.MAIN_MENU)

func exit() -> void:
	pass

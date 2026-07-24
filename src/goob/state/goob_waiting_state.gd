extends GoobState3D
class_name GoobWaitingState3D

@export var level_start_state: Constants.GoobState

var _args: GoobState3D.SetupArgs

func get_id() -> Constants.GoobState:
	return Constants.GoobState.WAITING

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args

func enter() -> void:
	Events.on_level_start.connect(_on_level_start)
	_args.renderer.begin_idle_anim()

func exit() -> void:
	Events.on_level_start.disconnect(_on_level_start)

func _on_level_start() -> void:
	request_state.emit(level_start_state, true)

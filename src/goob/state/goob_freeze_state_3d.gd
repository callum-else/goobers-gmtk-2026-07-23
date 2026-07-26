extends GoobState3D
class_name GoobFreezeState3D

@export var freeze_ridigbody: bool
@export var freeze_animation: bool

var _args: GoobState3D.SetupArgs

func _exit_tree() -> void:
	exit()

func get_id() -> Constants.GoobState:
	return Constants.GoobState.FREEZE

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args
	Events.freeze_goobs.connect(_on_freeze_goobs)

func enter() -> void:
	if (freeze_ridigbody):
		_args.body.freeze = true
	if (freeze_animation):
		_args.renderer.freeze()

func exit() -> void:
	Events.freeze_goobs.disconnect(_on_freeze_goobs)

func _on_freeze_goobs(priority: int) -> void:
	request_state.emit(Constants.GoobState.FREEZE, priority)

extends GoobState3D
class_name GoobIdleState3D

var _args: GoobState3D.SetupArgs

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.IDLE

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args

func enter() -> void:
	_args.renderer.begin_idle_anim()

func exit() -> void:
	pass

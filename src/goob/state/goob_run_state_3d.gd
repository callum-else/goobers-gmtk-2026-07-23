extends GoobState3D
class_name GoobRunState3D

const MOVE_FORCE: float = 200.0

var _args: GoobState3D.SetupArgs
var _avoidance: GoobAvoidance3D
var _run_limiter: GoobRunLimiter3D
var _direction: Vector3

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.RUN

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args
	_avoidance = $GoobAvoidance3D
	_run_limiter = $GoobRunLimiter3D

func enter() -> void:
	if (not _run_limiter.is_outside_limits()):
		_direction = Utilities.get_random_direction()
	_args.body.freeze = false
	_args.renderer.begin_running_anim()
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	_direction = _run_limiter.limit_direction(_args.body.global_position, _direction)
	var calculated = _avoidance.apply_avoidance(_direction * MOVE_FORCE)
	_args.body.apply_central_force(calculated)

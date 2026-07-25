extends GoobState3D
class_name GoobRunState3D

const MOVE_FORCE: float = 200.0
const BOUNCE_SPREAD: float = 0.35

var _args: GoobState3D.SetupArgs
var _avoidance: GoobAvoidance3D
var _limits_listener: LimitsListener3D
var _direction: Vector3
var _outside_limits: bool = false

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.RUN

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args
	_avoidance = $GoobAvoidance3D
	_limits_listener = $LimitsListener3D
	_limits_listener.on_limits_left.connect(_on_limits_left)
	_limits_listener.on_limits_entered.connect(_on_limits_entered)

func enter() -> void:
	if (not _outside_limits):
		_direction = _get_random_direction()
	_args.body.freeze = false
	_args.renderer.begin_running_anim()
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	var calculated = _avoidance.apply_avoidance(_direction * MOVE_FORCE)
	_args.body.apply_central_force(calculated)

func _get_random_direction() -> Vector3:
	return Vector3.FORWARD.rotated(Vector3.UP, randf() * TAU)

func _on_limits_left(limits_center: Vector3) -> void:
	_outside_limits = true
	var inward = Utilities.flatten_vector(limits_center - _args.body.global_position)
	_direction = inward.normalized()

func _on_limits_entered(limits_center: Vector3) -> void:
	_outside_limits = false
	var inward = Utilities.flatten_vector(limits_center - _args.body.global_position)
	var spread = randf_range(-BOUNCE_SPREAD, BOUNCE_SPREAD)
	_direction = inward.normalized().rotated(Vector3.UP, spread)

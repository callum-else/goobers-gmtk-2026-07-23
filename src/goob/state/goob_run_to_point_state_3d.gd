extends GoobState3D
class_name GoobRunToPointState3D

const MOVE_FORCE: float = 200.0
const MIN_MOVE_VEL: float = 0.5

@export var target_pos: Vector3
@export var target_radius: float
@export var randomize_target_pos: bool

var _avoidance: GoobAvoidance3D
var _args: GoobState3D.SetupArgs
var _target_dist: float
var _target_hit: bool = true
var _is_moving: bool = false

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.RUN_TO_FIXED_POSITION

func setup(args: GoobState3D.SetupArgs) -> void:
	_avoidance = $GoobAvoidance3D
	_args = args

func enter() -> void:
	_target_hit = false
	_target_dist = (randf_range(0, target_radius) 
		if randomize_target_pos else target_radius)
	_args.body.freeze = false
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	_apply_movement()
	_apply_animation()

func _apply_movement() -> void:
	if (_target_hit):
		return
	var target_diff = Utilities.flatten_vector(target_pos - _args.body.global_position)
	var diff_len = target_diff.length()
	if (diff_len < _target_dist):
		_target_hit = true
		return
	var calculated = _avoidance.apply_avoidance(target_diff.normalized() * MOVE_FORCE)
	_args.body.apply_central_force(calculated)

func _apply_animation() -> void:
	var vel = Utilities.flatten_vector(_args.body.linear_velocity).length()
	if (_is_moving and vel < MIN_MOVE_VEL):
		_is_moving = false
		_args.renderer.begin_idle_anim()
	elif (not _is_moving and vel >= MIN_MOVE_VEL):
		_is_moving = true
		_args.renderer.begin_running_anim()

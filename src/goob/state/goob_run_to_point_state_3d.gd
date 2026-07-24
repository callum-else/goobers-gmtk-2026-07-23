extends GoobState3D
class_name GoobRunToPointState3D

const MOVE_FORCE: float = 200.0

@export var target_pos: Vector3
@export var target_radius: float
@export var randomize_target_pos: bool
@export var target_reached_state: Constants.GoobState

var _args: GoobState3D.SetupArgs
var _target_dist: float
var _target_hit: bool = true

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.RUN_TO_FIXED_POSITION

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args

func enter() -> void:
	_target_hit = false
	_target_dist = (randf_range(0, target_radius) 
		if randomize_target_pos else target_radius)
	_args.body.freeze = false
	_args.renderer.begin_running_anim()
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	if (_target_hit):
		return
	var target_diff = Utilities.flatten_vector(target_pos - _args.body.global_position)
	var diff_len = target_diff.length()
	if (diff_len < _target_dist):
		_target_hit = true
		request_state.emit(target_reached_state)
		return
	_args.body.apply_central_force(target_diff.normalized() * MOVE_FORCE)

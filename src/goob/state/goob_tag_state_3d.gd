extends GoobState3D
class_name GoobTagState3D

const MOVE_FORCE: float = 400.0

@export var min_conversion_time: float = 0.75
@export var max_conversion_time: float = 1.25
@export var tag_distance: float = 2.5
@export var tag_allow_states: Array[Constants.GoobState]

var _args: GoobState3D.SetupArgs
var _run_limiter: GoobRunLimiter3D
var _detector: GoobDetector3D
var _conversion_timer: Timer
var _target_timer: Timer
var _direction: Vector3
var _target: GoobBody3D
var _is_chasing_target: bool

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.TAGGED

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args
	_run_limiter = $GoobRunLimiter3D
	_detector = $GoobDetector3D
	_conversion_timer = $ConversionTimer
	_target_timer = $UpdateTargetTimer

func enter() -> void:
	_args.renderer.begin_panic_anim()
	_is_chasing_target = false
	_target_timer.timeout.connect(_set_target)
	_conversion_timer.wait_time = randf_range(min_conversion_time, max_conversion_time)
	if (not _run_limiter.is_outside_limits()):
		_direction = Utilities.get_random_direction()
	_conversion_timer.start()
	await _conversion_timer.timeout
	_args.renderer.set_body_color(Constants.GOOB_TAGGED_COLOR)
	_args.renderer.begin_running_anim(GoobRenderer3D.EyeMode.ANGRY)
	_target_timer.start()
	set_physics_process(true)

func exit() -> void:
	_target_timer.stop()
	_target_timer.timeout.disconnect(_set_target)
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	if (_target):
		var to_target_vector := _target.global_position - _args.body.global_position
		if (to_target_vector.length() < tag_distance):
			_target.set_current_state(Constants.GoobState.TAGGED, GoobState3D.Priority.HIGH)
			_target = null
		else:
			_direction = Utilities.flatten_vector(to_target_vector.normalized())
	else:
		_direction = _run_limiter.limit_direction(_args.body.global_position, _direction)
	_args.body.apply_central_force(_direction * MOVE_FORCE)

func _set_target() -> void:
	var closest_dist := INF
	var closest_goob: GoobBody3D
	var goobs := _detector.get_goobs_in_state(Constants.GoobState.RUN)
	for body in goobs:
		var dist := Utilities.flatten_vector(
			body.global_position - _args.body.global_position).length()
		if (dist < closest_dist):
			closest_dist = dist
			closest_goob = body
	_target = closest_goob

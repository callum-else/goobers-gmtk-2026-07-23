extends GoobState3D
class_name GoobConfusedState3D

@export var timeout_state: Constants.GoobState
@export var min_confused_timeout: float
@export var max_confuded_timeout: float

var _args: GoobState3D.SetupArgs
var _timed_out: bool 
var _timeout: float
var _calm: bool
var _calm_time: float

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.CONFUSED

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args

func enter() -> void:
	_timed_out = false
	_timeout = randf_range(min_confused_timeout, max_confuded_timeout)
	_calm = false
	_calm_time = _timeout * 0.5
	_args.renderer.begin_panic_anim()
	set_physics_process(true)

func exit() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if (_timed_out):
		return
	_timeout -= delta
	if (not _calm and _timeout < _calm_time):
		_calm = true
		_args.renderer.begin_idle_anim()
	if (_timeout < 0.0):
		request_state.emit(timeout_state)
		_timed_out = true

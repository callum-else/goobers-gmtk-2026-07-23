extends GoobState3D
class_name GoobThrownState3D

const MIN_VELOCITY_LENGTH: float = 0.2
const TIMEOUT_DURATION: float = 1

@export var on_idle_state: Constants.GoobState

var _args: GoobState3D.SetupArgs
var _is_idle: bool
var _timeout: float

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.THROWN

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args

func enter() -> void:
	_timeout = TIMEOUT_DURATION
	_is_idle = false
	_args.body.freeze = false
	set_physics_process(true)

func exit() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if (_is_idle):
		return
	if (_timeout > 0.0):
		_timeout -= delta
		return
	if (_args.body.linear_velocity.length() < MIN_VELOCITY_LENGTH):
		request_state.emit(on_idle_state)

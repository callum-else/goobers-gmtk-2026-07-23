extends GoobState3D
class_name GoobConfusedState3D

@export var timeout_state: Constants.GoobState
@export var min_confused_timeout: float
@export var max_confuded_timeout: float

var _timeout: float
var _requested: bool

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.CONFUSED

func setup(_body_3d: RigidBody3D) -> void:
	pass

func enter() -> void:
	_timeout = randf_range(min_confused_timeout, max_confuded_timeout)
	_requested = false
	set_physics_process(true)

func exit() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if (_requested):
		return
	_timeout -= delta
	if (_timeout < 0.0):
		request_state.emit(timeout_state)
		_requested = true

extends GoobState3D
class_name GoobGrabbedState3D

const GRAB_SPEED: float = 15.0
const MAX_VELOCITY_LENGTH: float = 40.0

@export var on_released_state: Constants.GoobState

var _args: GoobState3D.SetupArgs
var _on_click_listener: GoobClickedListener3D
var _is_held: bool
var _velocity: Vector3

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.GRABBED

func setup(args: GoobState3D.SetupArgs) -> void:
	_on_click_listener = $GoobClickedListener3D
	_on_click_listener.on_goob_clicked.connect(_on_goob_clicked)
	_args = args

func enter() -> void:
	_is_held = true
	_args.body.freeze = true
	_args.renderer.begin_panic_anim()
	set_physics_process(true)

func exit() -> void:
	_args.body.freeze = false
	var vel = Vector3(_velocity.x, 0, _velocity.z)
	_args.body.linear_velocity = vel.normalized() * clamp(
		vel.length(), -MAX_VELOCITY_LENGTH, MAX_VELOCITY_LENGTH)
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if (_is_held):
		var is_held = InputState.get_input_primary()
		if (not is_held):
			_on_goob_released()
			return
		var target_pos = InputState.get_mouse_world_pos(Constants.GRAB_HEIGHT)
		var body_pos = _args.body.global_position
		var lerped_pos = body_pos.lerp(
			target_pos,
			delta * GRAB_SPEED)
		_args.body.global_position = lerped_pos
		_velocity = (_velocity + ((lerped_pos - body_pos) / delta)) / 2

func _on_goob_clicked() -> void:
	_is_held = true
	request_state.emit(Constants.GoobState.GRABBED, true)

func _on_goob_released() -> void:
	_is_held = false
	request_state.emit(on_released_state, true)

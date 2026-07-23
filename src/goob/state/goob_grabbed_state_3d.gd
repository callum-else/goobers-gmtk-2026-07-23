extends GoobState3D
class_name GoobGrabbedState3D

@export var on_released_state: Constants.GoobState
@export var grab_height: float = 20
@export var move_speed: float = 2

var _body_3d: RigidBody3D
var _on_click_listener: GoobClickedListener3D
var _is_held: bool

func get_id() -> Constants.GoobState:
	return Constants.GoobState.GRABBED

func setup(body_3d: RigidBody3D) -> void:
	_on_click_listener = $GoobClickedListener3D
	_on_click_listener.on_goob_clicked.connect(_on_goob_clicked)
	_body_3d = body_3d
	set_physics_process(false)

func enter() -> void:
	_body_3d.freeze = true
	set_physics_process(true)

func exit() -> void:
	_body_3d.freeze = false
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	if (_is_held):
		var is_held = InputState.get_input_primary()
		if (not is_held):
			_on_goob_released()
			return
		var target_pos = InputState.get_mouse_world_pos(grab_height)
		_body_3d.global_position = _body_3d.global_position.lerp(
			target_pos,
			delta * move_speed)

func _on_goob_clicked() -> void:
	_is_held = true
	request_state.emit(Constants.GoobState.GRABBED)

func _on_goob_released() -> void:
	_is_held = false
	request_state.emit(on_released_state)

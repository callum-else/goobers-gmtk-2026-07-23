extends RigidBody3D
class_name GoobBody3D

@onready var _renderer: GoobRenderer3D = $GoobRenderer3D
@onready var _state_machine: GoobStateMachine3D = $GoobStateMachine3D

func setup(
	body_frames: SpriteFrames,
	body_color: Color
) -> void:
	_renderer.set_body_frames(body_frames)
	_renderer.set_body_color(body_color)
	var state_args := GoobState3D.SetupArgs.new(self, _renderer)
	_state_machine.setup(state_args)

func get_current_state() -> Constants.GoobState:
	return _state_machine.get_state_id()

func set_current_state(state: Constants.GoobState, can_change: bool) -> void:
	_state_machine.set_state(state, can_change)

func set_body_color(color: Color) -> void:
	_renderer.set_body_color(color)

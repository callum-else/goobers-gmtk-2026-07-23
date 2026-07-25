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

extends GoobState3D
class_name GoobThrownState3D

var _body_3d: RigidBody3D

func get_id() -> Constants.GoobState:
	return Constants.GoobState.THROWN

func setup(body_3d: RigidBody3D) -> void:
	_body_3d = body_3d

func enter() -> void:
	_body_3d.freeze = false

func exit() -> void:
	pass

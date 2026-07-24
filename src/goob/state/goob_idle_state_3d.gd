extends GoobState3D
class_name GoobIdleState3D

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.IDLE

func setup(_body_3d: RigidBody3D) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

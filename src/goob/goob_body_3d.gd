extends RigidBody3D
class_name GoobBody3D

@onready var _avoidance: GoobAvoidance3D = $GoobAvoidance3D

func apply_movement_force(force: Vector3) -> void:
	var calculated = _avoidance.apply_avoidance(force)
	apply_central_force(calculated)

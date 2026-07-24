extends Area3D
class_name GoobAvoidance3D

const AVOIDANCE_STRENGTH: float = 400.0
const MIN_DISTANCE: float = 1.5

func apply_avoidance(force: Vector3) -> Vector3:
	var separation := Vector3.ZERO
	for body in get_overlapping_bodies():
		var diff = Utilities.flatten_vector(global_position - body.global_position)
		var dist = maxf(diff.length(), MIN_DISTANCE)
		separation += (diff / dist) * (1.0 / dist)
	return force + separation * AVOIDANCE_STRENGTH

extends Area3D
class_name GoobDetector3D

func get_goobs_in_state(state: Constants.GoobState) -> Array[GoobBody3D]:
	var valid: Array[GoobBody3D] = []
	var overlapping := get_overlapping_bodies()
	for body in overlapping:
		if (body is GoobBody3D):
			if (body.get_current_state() != state):
				continue
			valid.append(body)
	return valid

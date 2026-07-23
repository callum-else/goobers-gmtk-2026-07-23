extends Node3D

const MIN_SCALE: float = 1
const MAX_SCALE: float = 1.8

func _physics_process(delta: float) -> void:
	# 1 is the smallest size possible for the goob, representing goob at y=0
	# scale grows linearly with height, reaching MAX_SCALE at Constants.GRAB_HEIGHT
	var pos_scale: float = clamp(
		MIN_SCALE + (global_position.y / Constants.GRAB_HEIGHT) * (MAX_SCALE - MIN_SCALE),
		MIN_SCALE, MAX_SCALE
	)
	scale = Vector3(pos_scale, pos_scale, pos_scale)

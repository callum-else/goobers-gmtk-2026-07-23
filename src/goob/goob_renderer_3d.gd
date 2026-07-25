extends Node3D
class_name GoobRenderer3D

const MIN_SCALE: float = 1
const MAX_SCALE: float = 1.8

@onready var _body_spr: AnimatedSprite3D = $BodySprite3D
@onready var _eyes_spr: AnimatedSprite3D = $EyeSprite3D

func _physics_process(_delta: float) -> void:
	var pos_scale: float = clamp(
		MIN_SCALE + (global_position.y / Constants.GRAB_HEIGHT) * (MAX_SCALE - MIN_SCALE),
		MIN_SCALE, MAX_SCALE
	)
	scale = Vector3(pos_scale, pos_scale, pos_scale)

func _get_rand_speed_offset() -> float:
	return randf_range(0.9, 1.1)

func freeze() -> void:
	_body_spr.pause()
	_eyes_spr.pause()

func begin_running_anim() -> void:
	var offset = _get_rand_speed_offset()
	_body_spr.play("run", offset)
	_eyes_spr.play("open", offset)

func begin_idle_anim() -> void:
	var offset = _get_rand_speed_offset()
	_body_spr.play("idle", offset)
	_eyes_spr.play("open", offset)

func begin_panic_anim() -> void:
	var offset = _get_rand_speed_offset()
	_body_spr.play("panic", offset)
	_eyes_spr.play("chevron", offset)

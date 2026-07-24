extends Node3D
class_name GoobRenderer3D

const MIN_SCALE: float = 1
const MAX_SCALE: float = 1.8

@onready var _body: AnimatedSprite3D = $BodySprite3D
@onready var _eyes: AnimatedSprite3D = $EyeSprite3D

func _physics_process(_delta: float) -> void:
	# 1 is the smallest size possible for the goob, representing goob at y=0
	# scale grows linearly with height, reaching MAX_SCALE at Constants.GRAB_HEIGHT
	var pos_scale: float = clamp(
		MIN_SCALE + (global_position.y / Constants.GRAB_HEIGHT) * (MAX_SCALE - MIN_SCALE),
		MIN_SCALE, MAX_SCALE
	)
	scale = Vector3(pos_scale, pos_scale, pos_scale)

func begin_running_anim() -> void:
	_body.play("run")
	_eyes.play("open")

func begin_idle_anim() -> void:
	_body.play("idle")
	_eyes.play("open")

func begin_panic_anim() -> void:
	_body.play("panic")
	_eyes.play("chevron")

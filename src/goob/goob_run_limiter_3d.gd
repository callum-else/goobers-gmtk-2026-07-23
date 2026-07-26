extends Node3D
class_name GoobRunLimiter3D

const REENTER_SPREAD: float = 0.35

@onready var _listener: LimitsListener3D = $LimitsListener3D

var _limits_center: Vector3
var _outside_limits: bool
var _has_reentered: bool

func _ready() -> void:
	_listener.on_limits_left.connect(_on_limits_left)
	_listener.on_limits_entered.connect(_on_limits_entered)

func _exit_tree() -> void:
	_listener.on_limits_left.disconnect(_on_limits_left)
	_listener.on_limits_entered.disconnect(_on_limits_entered)

func is_outside_limits() -> bool:
	return _outside_limits

func limit_direction(origin: Vector3, current_dir: Vector3) -> Vector3:
	if (_outside_limits):
		return Utilities.flatten_vector(_limits_center - origin).normalized()
	elif (not _has_reentered):
		_has_reentered = true
		var new_dir := Utilities.flatten_vector(_limits_center - origin).normalized()
		var spread = randf_range(-REENTER_SPREAD, REENTER_SPREAD)
		return new_dir.rotated(Vector3.UP, spread)
	else:
		return current_dir

func _on_limits_left(limits_center: Vector3) -> void:
	_outside_limits = true
	_has_reentered = false
	_limits_center = limits_center

func _on_limits_entered(limits_center: Vector3) -> void:
	_outside_limits = false
	_limits_center = limits_center

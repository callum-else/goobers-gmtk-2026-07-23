extends Node

var _mouse_screen_pos: Vector2
var _mouse_world_pos: Vector3
var _input_primary: bool

func set_mouse_screen_pos(pos: Vector2) -> void:
	_mouse_screen_pos = pos

func get_mouse_screen_pos() -> Vector2:
	return _mouse_screen_pos

func set_mouse_world_pos(pos: Vector3) -> void:
	_mouse_world_pos = pos

func get_mouse_world_pos(y: float) -> Vector3:
	return Vector3(_mouse_world_pos.x, y, _mouse_world_pos.z)

func set_input_primary(is_down: bool) -> void:
	_input_primary = is_down
	Events.on_input_primary.emit(_input_primary)

func get_input_primary() -> bool:
	return _input_primary

func reset() -> void:
	_mouse_screen_pos = Vector2.ZERO
	_mouse_world_pos = Vector3.ZERO
	_input_primary = false

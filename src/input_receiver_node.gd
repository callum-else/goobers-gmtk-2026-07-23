extends Node

@export var camera: Camera3D
var _viewport: Viewport
var _mouse_screen_pos: Vector2

func _ready() -> void:
	_viewport = get_viewport()

func _input(event: InputEvent) -> void:
	if (event.is_action("interact_primary")):
		var is_down: bool = event.is_action_pressed("interact_primary")
		InputState.set_input_primary(is_down)

func _physics_process(_delta: float) -> void:
	_handle_mouse_position()

func _handle_mouse_position() -> void:
	var screen_pos = _viewport.get_mouse_position()
	if (screen_pos != _mouse_screen_pos):
		_mouse_screen_pos = screen_pos
		InputState.set_mouse_screen_pos(_mouse_screen_pos)
		var world_pos = camera.project_position(_mouse_screen_pos, 0.0)
		InputState.set_mouse_world_pos(world_pos)

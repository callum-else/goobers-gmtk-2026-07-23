extends Node3D
class_name CameraToWorldRaycast3D

@export var camera: Camera3D
@export_flags_3d_physics var collision_mask: int

var _can_input: bool

func _ready() -> void:
	Events.update_raycast_input.connect(_update_raycast_input)
	Events.on_input_primary.connect(_on_input_primary)

func _update_raycast_input(enabled: bool) -> void:
	_can_input = enabled

func _on_input_primary(is_down: bool) -> void:
	if (!_can_input or !is_down):
		return
	var mouse_pos: Vector2 = InputState.get_mouse_screen_pos()
	var ray_origin: Vector3 = camera.project_ray_origin(mouse_pos)
	var params = _get_ray_query_params(
		ray_origin,
		Vector3(ray_origin.x, 0, ray_origin.z)
	)
	var result = get_world_3d().direct_space_state.intersect_ray(params)
	if (result.is_empty()):
		return
	var collider = result["collider"]
	if (collider is CameraToWorldRaycastListener3D):
		collider.on_hit()
	
func _get_ray_query_params(from: Vector3, to: Vector3) -> PhysicsRayQueryParameters3D:
	var params = PhysicsRayQueryParameters3D.new()
	params.collision_mask = collision_mask
	params.collide_with_areas = true
	params.collide_with_bodies = false
	params.from = from
	params.to = to
	return params

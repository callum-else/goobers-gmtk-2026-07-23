extends Node3D
class_name LevelProgressRenderer3D

@export var goob_renderer_scene: PackedScene
@export var offset: float = 2.0

var _renderers: Dictionary[Constants.LevelId, GoobRenderer3D] = {}

func _get_renderer(id: Constants.LevelId) -> GoobRenderer3D:
	if (not _renderers.has(id)):
		printerr("Level ID %s not mapped to a goob renderer" % str(id))
		return null
	return _renderers[id]

func _spawn_or_move_renderer(id: Constants.LevelId, offset_x: float) -> GoobRenderer3D:
	var renderer: GoobRenderer3D = _renderers.get(id)
	if (not renderer):
		renderer = goob_renderer_scene.instantiate() as GoobRenderer3D
		add_child(renderer)
		renderer.set_body_frames(GoobState.get_random_body())
		renderer.set_body_color(Constants.PALETTE_COLOR_GREY)
		_renderers[id] = renderer
	renderer.position.x = offset_x
	return renderer

func render_progress(
	current_level: Constants.LevelId, 
	level_data: Array[Types.LevelData]
) -> void:
	var half_width: float = ((level_data.size() - 1) * offset) * 0.5
	for i in level_data.size():
		var renderer := _spawn_or_move_renderer(
			level_data[i].id, 
			i * offset - half_width)
		renderer.show()
	for data in level_data:
		if (data.id == current_level):
			if (data.state == Constants.LevelState.COMPLETED):
				set_passed(data.id)
			else:
				set_failed(data.id)
			return
		match data.state:
			Constants.LevelState.NONE:
				set_idle(data.id)
			Constants.LevelState.SPAWNED:
				set_attempted(data.id)
			Constants.LevelState.COMPLETED:
				set_completed(data.id)

func hide_progress() -> void:
	for renderer in _renderers.values():
		renderer.hide()

func set_idle(id: Constants.LevelId) -> void:
	var renderer := _get_renderer(id)
	if (renderer):
		renderer.begin_idle_anim()

func set_attempted(id: Constants.LevelId) -> void:
	var renderer := _get_renderer(id)
	if (renderer):
		renderer.begin_idle_anim(GoobRenderer3D.EyeMode.ANGRY)

func set_completed(id: Constants.LevelId) -> void:
	var renderer := _get_renderer(id)
	if (renderer):
		renderer.begin_running_anim()

func set_passed(id: Constants.LevelId) -> void:
	var renderer := _get_renderer(id)
	if (renderer):
		renderer.begin_panic_anim()

func set_failed(id: Constants.LevelId) -> void:
	var renderer := _get_renderer(id)
	if (renderer):
		renderer.begin_panic_anim(GoobRenderer3D.EyeMode.ANGRY)

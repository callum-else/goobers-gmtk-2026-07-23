extends Node3D
class_name LevelManager3D

@export var win_level: PackedScene
@export var levels: Dictionary[Constants.LevelId, PackedScene]

var _current_scene: Level3D

func _change_level(scene: PackedScene) -> Node:
	if (_current_scene):
		_current_scene.queue_free()
	var level := scene.instantiate()
	add_child(level)
	return level

func get_remaining_levels() -> Array[Constants.LevelId]:
	var completed := LevelState.get_completed_levels()
	var full := levels.keys()
	return full.filter(func(key): return not completed.has(key))

func set_current_level(id: Constants.LevelId) -> void:
	if (not levels.has(id)):
		printerr("Level ID %s not mapped to scene" % str(id))
		return
	var level := _change_level(levels[id])
	_current_scene = level as Level3D

func get_current_level() -> Level3D:
	return _current_scene

func goto_win_level() -> void:
	_change_level(win_level)

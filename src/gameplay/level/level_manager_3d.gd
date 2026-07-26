extends Node3D
class_name LevelManager3D

@export var win_level: PackedScene
@export var main_menu_level: PackedScene
@export var levels: Dictionary[Constants.LevelId, PackedScene]

var _ordered_levels: Array[Types.LevelData] = []
var _next_level_idx: int = 0
var _current_level: Level3D
var _current_level_id: Constants.LevelId

func _ready() -> void:
	Events.on_level_success.connect(_on_level_success)
	for key in levels.keys():
		_ordered_levels.append(Types.LevelData.new(key))
	_ordered_levels.shuffle()

func _exit_tree() -> void:
	Events.on_level_success.disconnect(_on_level_success)

func _on_level_success(id: Constants.LevelId) -> void:
	for data in _ordered_levels:
		if (data.id == id):
			data.state = Constants.LevelState.COMPLETED

func _change_level(scene: PackedScene) -> Node:
	if (_current_level):
		_current_level.queue_free()
	var level := scene.instantiate()
	add_child(level)
	return level

func get_ordered_level_data() -> Array[Types.LevelData]:
	return _ordered_levels

func try_spawn_next_level() -> bool:
	for i in range(_ordered_levels.size()):
		var data := _ordered_levels[_next_level_idx]
		_next_level_idx = (_next_level_idx + 1) % _ordered_levels.size()
		if (data.state != Constants.LevelState.COMPLETED):
			var level := _change_level(levels[data.id])
			_current_level = level as Level3D
			_current_level_id = data.id
			if (data.state == Constants.LevelState.NONE):
				data.state = Constants.LevelState.SPAWNED
			return true
	return false

func get_current_level() -> Level3D:
	return _current_level

func get_current_level_id() -> Constants.LevelId:
	return _current_level_id

func goto_win_level() -> void:
	_change_level(win_level)

func goto_main_menu_level() -> void:
	_current_level = _change_level(main_menu_level)

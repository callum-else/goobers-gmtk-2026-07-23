extends Node

var _completed_levels: Array[Constants.LevelId] = []

func get_completed_levels() -> Array[Constants.LevelId]:
	return _completed_levels

func set_level_completed(id: Constants.LevelId) -> void:
	if (_completed_levels.count(id) != 0):
		return
	_completed_levels.append(id)

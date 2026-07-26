extends Node
class_name Types

class LevelData:
	var id: Constants.LevelId
	var state: Constants.LevelState
	func _init(level_id: Constants.LevelId) -> void:
		id = level_id
		state = Constants.LevelState.NONE

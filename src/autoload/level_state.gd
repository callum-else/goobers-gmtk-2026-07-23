extends Node

class State:
	var succeeded: bool

var _level_states: Dictionary[Constants.LevelId, State] = {}

func set_success_state(id: Constants.LevelId, success: bool) -> void:
	_level_states[id].succeeded = success

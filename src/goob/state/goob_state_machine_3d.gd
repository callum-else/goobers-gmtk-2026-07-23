extends Node3D
class_name GoobStateMachine3D

@export var starting_state: Constants.GoobState
@export var starting_priority: int = GoobState3D.Priority.DEFAULT

var _states: Dictionary[Constants.GoobState, GoobState3D] = {}
var _current_state: GoobState3D
var _current_priority: int = 0

func setup(args: GoobState3D.SetupArgs) -> void:
	for child in get_children():
		if child is GoobState3D:
			var state := child as GoobState3D
			state.setup(args)
			state.request_state.connect(set_state)
			_states[state.get_id()] = state
	set_state(starting_state, starting_priority)

func set_state(state: Constants.GoobState, priority: int) -> void:
	if (priority < _current_priority):
		return
	if _current_state:
		_current_state.exit()
	_current_state = _states[state]
	_current_state.enter()

func get_state_id() -> Constants.GoobState:
	return _current_state.get_id()

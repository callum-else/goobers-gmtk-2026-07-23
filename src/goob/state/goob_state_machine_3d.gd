extends Node3D
class_name GoobStateMachine3D

@export var body_3d: GoobBody3D
@export var renderer_3d: GoobRenderer3D

@export var starting_state: Constants.GoobState

var _states: Dictionary[Constants.GoobState, GoobState3D] = {}
var _current_state: GoobState3D
var _can_change_state: bool = true

func _ready() -> void:
	var args = GoobState3D.SetupArgs.new(
		body_3d,
		renderer_3d
	)
	for child in get_children():
		if child is GoobState3D:
			var state := child as GoobState3D
			state.setup(args)
			state.request_state.connect(set_state)
			_states[state.get_id()] = state
	set_state(starting_state, true)

func set_state(state: Constants.GoobState, can_change: bool = true) -> void:
	if (not _can_change_state):
		return
	_can_change_state = can_change
	if _current_state:
		_current_state.exit()
	_current_state = _states[state]
	_current_state.enter()

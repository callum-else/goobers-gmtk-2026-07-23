extends Node3D
class_name GameplayStateMachine3D

@export var control_renderer: ControlRendererUI
@export var level_manager: LevelManager3D
@export var starting_state: Constants.GameplayState

var _states: Dictionary[Constants.GameplayState, GameplayState3D] = {}
var _current_state: GameplayState3D

func _ready() -> void:
	var args = GameplayState3D.SetupArgs.new(
		control_renderer,
		level_manager
	)
	for child in get_children():
		if child is GameplayState3D:
			var state := child as GameplayState3D
			state.setup(args)
			state.request_state.connect(set_state)
			_states[state.get_id()] = state
	set_state(starting_state)

func set_state(state: Constants.GameplayState) -> void:
	if _current_state:
		_current_state.exit()
	_current_state = _states[state]
	_current_state.enter()

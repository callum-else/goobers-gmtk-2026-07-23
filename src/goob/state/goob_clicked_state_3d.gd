extends GoobState3D
class_name GoobClickedState3D

@export var on_clicked_state: Constants.GoobState
@export var can_transition_clicked_state: bool = true
@export var allowed_states: Array[Constants.GoobState]

var _args: GoobState3D.SetupArgs
var _on_click_listener: CameraToWorldRaycastListener3D

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.CLICKED

func setup(args: GoobState3D.SetupArgs) -> void:
	_on_click_listener = $GoobClickedListener3D
	_on_click_listener.on_hit.connect(_on_goob_clicked)
	_args = args

func enter() -> void:
	request_state.emit(on_clicked_state, can_transition_clicked_state)

func exit() -> void:
	pass

func _on_goob_clicked() -> void:
	if (not allowed_states.has(_args.body.get_current_state())):
		return
	request_state.emit(Constants.GoobState.CLICKED, true)

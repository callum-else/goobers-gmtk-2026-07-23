extends GoobState3D
class_name GoobButtonState3D

@export var button_event: Constants.GoobButtonEvent
@export var animate: bool = true

var _args: GoobState3D.SetupArgs

func _ready() -> void:
	set_physics_process(false)

func get_id() -> Constants.GoobState:
	return Constants.GoobState.BUTTON

func setup(args: GoobState3D.SetupArgs) -> void:
	_args = args

func enter() -> void:
	print ("button")
	if (animate):
		_args.renderer.begin_panic_anim()
	Events.on_goob_button.emit(button_event)

func exit() -> void:
	pass

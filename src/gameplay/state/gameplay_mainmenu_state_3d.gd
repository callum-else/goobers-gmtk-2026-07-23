extends GameplayState3D
class_name GameplayMainMenuState3D

var _args: GameplayState3D.SetupArgs

func get_id() -> Constants.GameplayState:
	return Constants.GameplayState.MAIN_MENU

func setup(args: SetupArgs) -> void:
	_args = args

func enter() -> void:
	Events.on_goob_button.connect(_on_goob_button)
	_args.control_renderer.reset_level_anims(true)
	_args.level_manager.goto_main_menu_level()
	await _args.control_renderer.animate_circle_wipe_async(false, 1.5)

func exit() -> void:
	Events.on_goob_button.disconnect(_on_goob_button)

func _on_goob_button(event: Constants.GoobButtonEvent) -> void:
	if (event != Constants.GoobButtonEvent.MAIN_MENU):
		print ("not event")
		return
	print ("event")
	Events.freeze_goobs.emit(GoobState3D.Priority.FINAL)
	request_state.emit(Constants.GameplayState.LEVEL_TRANSITION)

@abstract
extends Node3D
class_name GameplayState3D

class SetupArgs:
	var control_renderer: ControlRendererUI
	var level_manager: LevelManager3D
	func _init(
		control_renderer_ui: ControlRendererUI,
		level_manager_3d: LevelManager3D,
	) -> void:
		control_renderer = control_renderer_ui
		level_manager = level_manager_3d

@warning_ignore("unused_signal")
signal request_state(state: Constants.GameplayState)

@abstract
func get_id() -> Constants.GameplayState

@abstract
func setup(args: SetupArgs) -> void

@abstract
func enter() -> void

@abstract
func exit() -> void

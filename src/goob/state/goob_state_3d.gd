@abstract
extends Node3D
class_name GoobState3D

class SetupArgs:
	var body: GoobBody3D
	var renderer: GoobRenderer3D
	func _init(
		body_3d: GoobBody3D, 
		renderer_3d: GoobRenderer3D
	) -> void:
		body = body_3d
		renderer = renderer_3d

@warning_ignore("unused_signal")
signal request_state(state: Constants.GoobState, can_change: bool)

@abstract
func get_id() -> Constants.GoobState

@abstract
func setup(args: SetupArgs) -> void

@abstract
func enter() -> void

@abstract
func exit() -> void

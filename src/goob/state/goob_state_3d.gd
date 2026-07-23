@abstract
extends Node3D
class_name GoobState3D

@warning_ignore("unused_signal")
signal request_state(state: Constants.GoobState)

@abstract
func get_id() -> Constants.GoobState

@abstract
func setup(body_3d: RigidBody3D) -> void

@abstract
func enter() -> void

@abstract
func exit() -> void

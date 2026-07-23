extends Node3D
class_name GoobStateMachine3D

@export var body_3d: GoobBody3D
@export var starting_state: Constants.GoobState

func _ready() -> void:
	# get all children of type GoobState3D
	# for each, call setup(), subscribe signal and store in dict
	pass

func set_state(state: Constants.GoobState) -> void:
	pass 

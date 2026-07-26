extends Level3D
class_name MainMenuLevel3D

func _ready() -> void:
	Events.update_raycast_input.emit(true)

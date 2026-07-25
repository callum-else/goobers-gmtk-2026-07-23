extends Area3D
class_name LimitsArea3D

# handles detecting when a listener has left the limits and calls a method on the listener

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area3D) -> void:
	if (area is LimitsListener3D):
		area.on_limits_entered.emit(global_position)

func _on_area_exited(area: Area3D) -> void:
	if (area is LimitsListener3D):
		area.on_limits_left.emit(global_position)

extends CameraToWorldRaycastListener3D
class_name GoobClickedListener3D

signal on_goob_clicked

func on_hit() -> void:
	on_goob_clicked.emit()

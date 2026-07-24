extends Control

const MAX_TIMEOUT: float = 15.0

@onready var _border: ColorRect = $LevelTimeOutCountdownBorderRect
@onready var _label: Label = $LevelTimeOutCountdownLabel

var _timeout: float

func _ready() -> void:
	Events.on_level_start.connect(_on_level_start)
	Events.on_level_ready.connect(_on_level_ready)
	_border.hide()
	_label.hide()
	set_process(false)

func _on_level_ready() -> void:
	_border.set_instance_shader_parameter("progress", 1.0)
	_border.show()
	_label.text = str(ceili(MAX_TIMEOUT))
	_label.hide()
	_timeout = MAX_TIMEOUT

func _on_level_start() -> void:
	_label.show()
	set_process(true)

func _process(delta: float) -> void:
	_timeout -= delta
	if (_timeout <= 0.0):
		_label.text = "OUT!"
		_label.scale = Vector2.ONE
		# TODO: tween and shake the label, loop until killed
		_border.hide()
		Events.on_level_timeout.emit()
		set_process(false)
		return
	_handle_scale()
	_label.text = str(max(ceili(_timeout), 0))
	_border.set_instance_shader_parameter("progress", maxf(_timeout / MAX_TIMEOUT, 0.0))

func _handle_scale() -> void:
	var scale_factor: float = 1.0 + 0.05 * sin(_timeout * TAU)
	_label.scale = Vector2.ONE * scale_factor

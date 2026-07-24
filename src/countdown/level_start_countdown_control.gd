extends Control

const COUNTDOWN_START: float = 4.0

@onready var _label: Label = $LevelStartCountdownLabel

var _timeout: float

func _ready() -> void:
	Events.on_level_ready.connect(_on_level_ready)
	_label.hide()
	set_process(false)

func _on_level_ready() -> void:
	_label.hide()
	_timeout = COUNTDOWN_START
	_label.scale = Vector2.ONE
	set_process(true)

func _process(delta: float) -> void:
	_handle_timeout(delta)
	_handle_scale()

func _handle_timeout(delta: float) -> void:
	_timeout -= delta
	if (_timeout < -1.0):
		_label.hide()
		Events.on_level_start.emit()
		set_process(false)
		return
	if (_timeout <= 3.0 and _timeout > 0.0):
		_label.text = str(ceili(_timeout))
		_label.show()
	elif (_timeout <= 0.0):
		_label.text = "GO!"

func _handle_scale() -> void:
	var scale_factor: float = 1.0 + 0.2 * sin((_timeout + 0.5) * TAU)
	_label.scale = Vector2.ONE * scale_factor

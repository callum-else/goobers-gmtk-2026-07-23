extends Control
class_name LevelDurationCountdownControl

@onready var _border: ColorRect = $LevelDurationCountdownBorderRect
@onready var _label: Label = $LevelDurationCountdownLabel
@onready var _timer: Timer = $LevelDurationTimer

func _ready() -> void:
	disable()

func _process(_delta: float) -> void:
	var remaining := _timer.time_left
	if (remaining <= 0.0):
		_label.text = "OUT!"
		_label.scale = Vector2.ONE
		_border.hide()
		set_process(false)
		return
	_handle_scale()
	_label.text = str(max(ceili(remaining), 0))
	_border.set_instance_shader_parameter("progress", maxf(remaining / _timer.wait_time, 0.0))

func _handle_scale() -> void:
	var scale_factor: float = 1.0 + 0.05 * sin(_timer.time_left * TAU)
	_label.scale = Vector2.ONE * scale_factor

func disable() -> void:
	_border.hide()
	_label.hide()
	_timer.stop()
	set_process(false)

func enable_border() -> void:
	_border.set_instance_shader_parameter("progress", 1.0)
	_border.show()

func enable_label(text: String) -> void:
	_label.text = text
	_label.show()

func wait_for_timeout_async(duration: float) -> void:
	_timer.wait_time = duration
	_timer.start()
	set_process(true)
	await _timer.timeout

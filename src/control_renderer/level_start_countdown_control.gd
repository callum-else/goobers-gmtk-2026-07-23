extends Control
class_name LevelStartCountdownControl

const COUNTDOWN_START: float = 5.0

@onready var _label: Label = $LevelStartCountdownLabel
@onready var _timer: Timer = $LevelStartTimer

func _ready() -> void:
	disable()

func _process(_delta: float) -> void:
	_handle_timeout()
	_handle_scale()

func _handle_timeout() -> void:
	var remaining := _timer.time_left
	if (remaining <= 0.0):
		disable()
		return
	var counter_time := remaining - 1.0
	if (counter_time <= 3.0 and counter_time >= 0.0):
		_label.text = str(ceili(counter_time))
		_label.show()
	elif (counter_time <= 0.0):
		_label.text = "GO!"

func _handle_scale() -> void:
	var scale_factor: float = 1.0 + 0.2 * sin((_timer.time_left + 0.5) * TAU)
	_label.scale = Vector2.ONE * scale_factor

func disable() -> void:
	_label.hide()
	set_process(false)

func wait_for_timeout_async() -> void:
	_label.hide()
	_label.scale = Vector2.ONE
	_timer.wait_time = COUNTDOWN_START
	_timer.start()
	set_process(true)
	await _timer.timeout

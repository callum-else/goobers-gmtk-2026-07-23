extends Control
class_name LevelStartCountdownControl

const COUNTDOWN_WAIT: float = 1.0
const COUNTDOWN_LENGTH: float = 3.0
const COUNTDOWN_LINGER: float = 2

@onready var _label: Label = $LevelStartCountdownLabel
@onready var _timer: Timer = $LevelStartTimer

var _instruction: String = "GO!"

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
	var counter_time := remaining - COUNTDOWN_LINGER
	if (counter_time <= COUNTDOWN_LENGTH and counter_time >= 0.0):
		_label.text = str(ceili(counter_time))
		_label.show()
	elif (counter_time <= 0.0):
		_label.text = _instruction

func _handle_scale() -> void:
	var scale_factor: float = 1.0 + 0.2 * sin((_timer.time_left + 0.5) * TAU)
	_label.scale = Vector2.ONE * scale_factor

func disable() -> void:
	_label.hide()
	set_process(false)

func wait_for_timeout_async(instruction: String) -> void:
	_instruction = instruction
	_label.hide()
	_label.scale = Vector2.ONE
	_timer.wait_time = (
		COUNTDOWN_WAIT + COUNTDOWN_LENGTH + COUNTDOWN_LINGER
	)
	_timer.start()
	set_process(true)
	await _timer.timeout

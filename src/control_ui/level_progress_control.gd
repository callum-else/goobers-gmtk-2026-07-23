extends Control
class_name LevelProgressControl

const LEVEL_CHAR: String = "o"
const ANIMATE_IN_TIME: float = 0.5
const ANIMATE_CHARACTER_TIME: float = 0.5
const ANIMATE_OUT_TIME: float = 1.5

@onready var _label: RichTextLabel = $ProgressText
@onready var _timer: Timer = $AnimationTimer

func _ready() -> void:
	_label.hide()

func _scale_y(y: float) -> void:
	var vec := Vector2(scale.x, y)
	scale = vec

func animate_progress_async(
	current_level: Constants.LevelId,
	level_data: Array[Types.LevelData]
) -> void:
	_timer.start(ANIMATE_IN_TIME)
	await _timer.timeout
	var strings: Array[String] = []
	for data in level_data:
		var col := _color_for_state(data.state)
		var bb := ("[color=#%s]" % col.to_html(false)) + LEVEL_CHAR + "[/color]"
		if (data.id == current_level):
			bb = "[pulse freq=3.0]" + bb + "[/pulse]"
		strings.append(bb)
		_label.text = "[wave]" + "".join(strings) + "[/wave]"
		_label.show()
		_timer.start(ANIMATE_CHARACTER_TIME)
		await _timer.timeout
	_timer.start(ANIMATE_OUT_TIME)
	await _timer.timeout
	_label.hide()

func _color_for_state(state: Constants.LevelState) -> Color:
	match state:
		Constants.LevelState.COMPLETED:
			return Constants.PALETTE_COLOR_GREEN
		Constants.LevelState.SPAWNED:
			return Constants.PALETTE_COLOR_WHITE
		_:
			return Constants.PALETTE_COLOR_GREY

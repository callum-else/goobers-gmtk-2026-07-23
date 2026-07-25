extends Node

var _body_frames: Array[SpriteFrames]
var _body_colors: Array[Color]

func set_body_frames(frames: Array[SpriteFrames]) -> void:
	_body_frames = frames

func get_body_frames() -> Array[SpriteFrames]:
	return _body_frames

func get_random_body() -> SpriteFrames:
	return _body_frames.pick_random()

func set_body_colors(colors: Array[Color]) -> void:
	_body_colors = colors

func get_body_colors() -> Array[Color]:
	return _body_colors

func get_random_color() -> Color:
	return _body_colors.pick_random()

extends Node
class_name AudioNode

@onready var music_player: AudioStreamPlayer = $MusicStreamPlayer
@onready var sfx_player: AudioStreamPlayer = $SfxStreamPlayer

@export var countdown_timer_sfx: Array[AudioStream]
@export var level_music: Array[AudioStream]

var _last_level_music_index: int = -1

func _ready() -> void:
	Events.trigger_audio.connect(_on_trigger_audio)

func _on_trigger_audio(audio: Constants.Audio, play: bool) -> void:
	match audio:
		Constants.Audio.COUNTDOWN_TIMER:
			if play:
				_play_random(sfx_player, countdown_timer_sfx)
			else:
				sfx_player.stop()
		Constants.Audio.LEVEL_MUSIC:
			if play:
				_play_level_music()
			else:
				music_player.stop()

func _play_random(player: AudioStreamPlayer, streams: Array[AudioStream]) -> void:
	if streams.is_empty():
		return
	player.stream = streams[randi() % streams.size()]
	player.play()

func _play_level_music() -> void:
	if level_music.is_empty():
		return
	var index := randi() % level_music.size()
	while level_music.size() > 1 and index == _last_level_music_index:
		index = randi() % level_music.size()
	_last_level_music_index = index
	music_player.stream = level_music[index]
	music_player.play()

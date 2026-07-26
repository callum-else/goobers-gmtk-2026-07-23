extends Node
class_name AudioNode

@onready var music_player: AudioStreamPlayer = $MusicStreamPlayer
@onready var sfx_player: AudioStreamPlayer = $SfxStreamPlayer

@export var countdown_timer_sfx: Array[AudioStream]
@export var level_finish_sfx: Array[AudioStream]
@export var level_music: Array[AudioStream]

var _last_level_music_index: int = -1

func _ready() -> void:
	Events.trigger_sfx.connect(_on_trigger_sfx)
	Events.trigger_music.connect(_on_trigger_music)

func _on_trigger_sfx(audio: Constants.SFX) -> void:
	match audio:
		Constants.SFX.COUNTDOWN_TIMER:
			_play_random(sfx_player, countdown_timer_sfx)
		Constants.SFX.LEVEL_FINISH:
			_play_random(sfx_player, level_finish_sfx)

func _on_trigger_music(audio: Constants.Music) -> void:
	match audio:
		Constants.Music.LEVEL_MUSIC:
			_play_level_music()

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

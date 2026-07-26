extends Node
@warning_ignore_start("unused_signal")

signal on_input_primary(is_down: bool)
signal on_level_start()
signal on_level_timeout()
signal on_level_success(id: Constants.LevelId)
signal freeze_goobs(priority: int)
signal on_goob_button(event: Constants.GoobButtonEvent)
signal update_raycast_input(enabled: bool)
signal trigger_sfx(audio: Constants.SFX)
signal trigger_music(audio: Constants.Music)

@warning_ignore_restore("unused_signal")

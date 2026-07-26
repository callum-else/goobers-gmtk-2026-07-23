extends Node
@warning_ignore_start("unused_signal")

signal on_input_primary(is_down: bool)
signal on_level_start()
signal on_level_timeout()
signal on_level_success(id: Constants.LevelId)
signal freeze_goobs(priority: int)
signal update_raycast_input(enabled: bool)

@warning_ignore_restore("unused_signal")

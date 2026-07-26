class_name Constants

enum GoobState {
	GRABBED,
	THROWN,
	CONFUSED,
	RUN_TO_FIXED_POSITION,
	IDLE,
	WAITING,
	FREEZE,
	RUN,
	CLICKED,
	TAGGED,
	BUTTON
}

enum GoobButtonEvent {
	MAIN_MENU
}

enum GameplayState {
	CONFIGURATION,
	GAME_START,
	LEVEL_TRANSITION,
	LEVEL_START,
	GAME_OVER,
	MAIN_MENU
}

enum LevelId {
	KEEP_OUT_CIRCLE,
	NO_RUNNING,
	DONT_GET_CAUGHT
}

enum LevelState {
	NONE,
	SPAWNED,
	COMPLETED
}

enum Music {
	LEVEL_MUSIC,
}

enum SFX {
	COUNTDOWN_TIMER,
	LEVEL_FINISH
}

const GOOB_GRAB_HEIGHT: int = 5

const PALETTE_COLOR_GREY: Color = Color("a49a87ff")
const PALETTE_COLOR_WHITE: Color = Color("fdf4dcff")
const PALETTE_COLOR_GREEN: Color = Color("31cc5dff")

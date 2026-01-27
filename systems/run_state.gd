# run_state.gd
# Holds all data for a single run (persists across scenes)

class_name RunState

# Run progression
var night: int = 1
var player_alive: bool = true
var day_elapsed_seconds: float = 0.0
var night_elapsed_seconds: float = 0.0

# Player progression
var gloire: int = 0
var stats_run: Dictionary = {
	"damage": 0,
	"speed": 0,
	"crit": 0,
	"armor": 0,
	"knockback": 0
}

# Game state
var current_phase: String = "DAY"  # "DAY" or "NIGHT"
var player_position: Vector2 = Vector2.ZERO
var enemy_count_alive: int = 0
var pnj_list: Array = []  # Will hold PNJ instances
var enemies_wave: Array = []  # Will hold active enemies

# Logging (for debug)
var state_log: Array = []

func _init():
	"""Initialize RunState with default values"""
	night = 1
	player_alive = true
	gloire = 0
	current_phase = "DAY"
	state_log = []
	log_state("RunState initialized")

func log_state(message: String):
	"""Log state changes for debugging"""
	var timestamp = Time.get_ticks_msec()
	var log_entry = "[%d] %s" % [timestamp, message]
	state_log.append(log_entry)
	print("[STATE] %s" % log_entry)

func start_night():
	"""Transition to night phase"""
	current_phase = "NIGHT"
	night_elapsed_seconds = 0.0
	log_state("Night %d started" % night)

func end_night():
	"""Transition to next phase (next night or day)"""
	log_state("Night %d ended" % night)
	if night < 5:
		night += 1
		current_phase = "DAY"
	else:
		# Run complete (after night 5)
		current_phase = "END_RUN"

func player_dies():
	"""Called when player HP reaches 0"""
	player_alive = false
	log_state("Player died on night %d" % night)

func add_gloire(amount: int):
	"""Add gloire to run"""
	gloire += amount
	log_state("Gloire +%d (total: %d)" % [amount, gloire])

func get_debug_info() -> String:
	"""Return debug info about current run state"""
	return """
	[RUN STATE DEBUG]
	Night: %d / 5
	Phase: %s
	Player Alive: %s
	Gloire: %d
	Stats this run: %s
	Enemies alive: %d
	""" % [night, current_phase, player_alive, gloire, stats_run, enemy_count_alive]

# game_manager.gd
# Global game manager (autoload singleton)
# Persists across scenes, manages run state and game flow

extends Node

# Persist across scenes automatically (it's an autoload)
var run_state: RunState
var is_initialized: bool = false

func _ready():
	"""Called when game starts"""
	print("[GAME MANAGER] Starting...")
	
	if not is_initialized:
		initialize_run()
		is_initialized = true
		print("[GAME MANAGER] Run initialized and ready!")
	
	# Don't pause when scene changes (persistence)
	process_mode = Node.PROCESS_MODE_ALWAYS

func initialize_run():
	"""Initialize a new run"""
	run_state = RunState.new()
	run_state.log_state("Run started")
	print("[GAME MANAGER] RunState created")
	print(run_state.get_debug_info())

func transition_to_night():
	"""Called when player clicks 'Start Night' button"""
	if run_state.player_alive:
		run_state.start_night()
		print("[GAME MANAGER] Transitioning to Night %d" % run_state.night)
		# Scene will change to night scene (implemented in GDD-004)
		# get_tree().change_scene_to_file("res://scenes/night.tscn")

func transition_to_day():
	"""Called when night ends (auto or via code)"""
	run_state.end_night()
	print("[GAME MANAGER] Night ended, now on Night %d" % run_state.night)
	# Scene will change back to day (implemented in GDD-002)
	# get_tree().change_scene_to_file("res://scenes/day.tscn")

func end_run(final_gloire: int):
	"""Called when run ends (player dies or completes all nights)"""
	run_state.gloire = final_gloire
	run_state.player_alive = false
	run_state.log_state("Run ended with gloire: %d" % final_gloire)
	print("[GAME MANAGER] RUN ENDED!")
	print(run_state.get_debug_info())
	
	# Save gloire to persistent storage (post-MVP)
	# save_gloire()

func reset_run():
	"""Reset for new run (called from retry button)"""
	is_initialized = false
	run_state = null
	initialize_run()
	print("[GAME MANAGER] Run reset - new run started")

func get_run_state() -> RunState:
	"""Get current run state (use this anywhere)"""
	return run_state

func get_debug_status() -> String:
	"""Get full debug status"""
	if run_state:
		return run_state.get_debug_info()
	else:
		return "[ERROR] RunState not initialized!"

# Debug commands (console testing - remove before production)
func _input(event: InputEvent):
	"""Debug input commands"""
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_F1:  # F1 = Print debug
				print(get_debug_status())
			KEY_F2:  # F2 = Simulate night transition
				transition_to_night()
			KEY_F3:  # F3 = Simulate end run
				end_run(100)

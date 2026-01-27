# main.gd
# Main scene coordinator

extends Node2D

func _ready():
	"""Initialize main scene"""
	
	print("[MAIN] Main scene loaded")
	print("[MAIN] Run state: Night %d" % Game_Manager.run_state.night)
	print("[MAIN] Phase: %s" % Game_Manager.run_state.current_phase)
	
	# Verify player exists
	var player = get_node("Day/Player")
	if player:
		print("[MAIN] Player found at position: %s" % player.global_position)
	
	# Log startup
	Game_Manager.run_state.log_state("Main scene ready, Day 1 active")

extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var start_night_button: Button = $InteractiveButton/StartNightButton if has_node("InteractiveButton/StartNightButton") else null

var player_instance: CharacterBody2D = null

func _ready() -> void:
	print("=== Day Map Ready ===")
	
	spawn_player()
	initialize_npcs()
	
	if start_night_button:
		print("✅ StartNightButton found!")
		print("Button position: ", start_night_button.global_position)
		
		# Vérifier le script
		if start_night_button.has_signal("pressed"):
			start_night_button.pressed.connect(_on_start_night_pressed)
			print("✅ button_pressed signal connected!")
		else:
			print("❌ button_pressed signal NOT found!")
	else:
		print("❌ StartNightButton NOT found in scene!")

func _on_start_night_pressed() -> void:
	print("Start Night button pressed!")
	GameManager.transition_to_night()

func spawn_player() -> void:
	var player_scene = preload("res://scenes/player/player.tscn")
	player_instance = player_scene.instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)
	print("Player spawned at: ", player_spawn.global_position)

func initialize_npcs() -> void:
	if has_node("NPCContainer"):
		var npc_container = get_node("NPCContainer")
		var npcs = npc_container.get_children()
		GameManager.initialize_npcs(npcs)

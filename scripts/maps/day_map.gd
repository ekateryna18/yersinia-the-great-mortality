extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var npcs_container: Node2D = $NPCs

var player_instance: CharacterBody2D = null

func _ready() -> void:
	print("=== Day Map Ready ===")
	spawn_player()
	initialize_npcs()

func spawn_player() -> void:
	var player_scene = preload("res://scenes/player/player.tscn")
	player_instance = player_scene.instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)
	print("Player spawned at: ", player_spawn.global_position)

func initialize_npcs() -> void:
	# Récupérer tous les PNJ
	var npc_list = npcs_container.get_children()
	
	if npc_list.size() > 0:
		# Initialiser le système de traîtres via GameManager
		GameManager.initialize_npcs(npc_list)
	else:
		print("⚠️ No NPCs found in day map!")
		

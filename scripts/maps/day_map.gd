extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn

var player_instance: CharacterBody2D = null

func _ready() -> void:
	print("=== Day Map Ready ===")
	spawn_player()

func spawn_player() -> void:
	# Charger la scène du joueur
	var player_scene = preload("res://scenes/player/player.tscn")
	player_instance = player_scene.instantiate()
	
	# Positionner au spawn point
	player_instance.global_position = player_spawn.global_position
	
	# Ajouter à la scène
	add_child(player_instance)
	
	print("Player spawned at: ", player_spawn.global_position)

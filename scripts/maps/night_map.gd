extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn

var player_instance: CharacterBody2D = null

func _ready() -> void:
	print("=== Night Map Ready ===")
	spawn_player()

func spawn_player() -> void:
	var player_scene = preload("res://scenes/player/player.tscn")
	player_instance = player_scene.instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)
	print("Player spawned at: ", player_spawn.global_position)

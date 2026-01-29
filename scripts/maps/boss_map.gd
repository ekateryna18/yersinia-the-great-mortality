extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn

var player_instance: CharacterBody2D = null
var wave_manager: Node = null
var enemy_container: Node2D = null
var boss_spawned: bool = false

func _ready() -> void:
	print("=== BOSS MAP READY ===")
	print("🔥 NIGHT 5 - BOSS FIGHT! 🔥")
	
	enemy_container = Node2D.new()
	enemy_container.name = "Enemies"
	add_child(enemy_container)
	
	spawn_player()
	initialize_wave_manager()

func spawn_player() -> void:
	var player_scene = preload("res://scenes/player/player.tscn")
	player_instance = player_scene.instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)
	print("Player spawned at: ", player_spawn.global_position)

func initialize_wave_manager() -> void:
	var WaveManagerScript = preload("res://scripts/systems/wave_manager.gd")
	wave_manager = WaveManagerScript.new()
	add_child(wave_manager)
	
	# Toujours Nuit 5 pour le boss
	wave_manager.initialize(5, enemy_container, player_instance)
	
	print("Boss fight initialized!")

func _exit_tree() -> void:
	print("=== Boss Map Cleanup ===")
	
	if wave_manager and is_instance_valid(wave_manager):
		wave_manager.stop_spawning()
	
	if enemy_container and is_instance_valid(enemy_container):
		var enemies = enemy_container.get_children()
		for enemy in enemies:
			if is_instance_valid(enemy):
				enemy.queue_free()
		print("All enemies cleaned up")

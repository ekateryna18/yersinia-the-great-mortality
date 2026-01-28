extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawn

var player_instance: CharacterBody2D = null
var wave_manager: Node = null
var enemy_container: Node2D = null

func _ready() -> void:
	print("=== Night Map Ready ===")
	
	# Créer un conteneur pour les ennemis
	enemy_container = Node2D.new()
	enemy_container.name = "Enemies"
	add_child(enemy_container)
	
	# Spawner le joueur
	spawn_player()
	
	# Initialiser le Wave Manager
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
	
	var current_night = GameManager.current_run.night if GameManager.current_run else 1
	wave_manager.initialize(current_night, enemy_container, player_instance)

func _exit_tree() -> void:
	print("=== Night Map Cleanup ===")
	
	# Arrêter le spawn
	if wave_manager and is_instance_valid(wave_manager):
		wave_manager.stop_spawning()
	
	# Nettoyer tous les ennemis
	if enemy_container and is_instance_valid(enemy_container):
		var enemies = enemy_container.get_children()
		for enemy in enemies:
			if is_instance_valid(enemy):
				enemy.queue_free()
		print("All enemies cleaned up")

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
	# Créer le Wave Manager
	var WaveManagerScript = preload("res://scripts/systems/wave_manager.gd")
	wave_manager = WaveManagerScript.new()
	add_child(wave_manager)
	
	# Initialiser avec la nuit courante
	var current_night = GameManager.get_current_night()
	wave_manager.initialize(current_night, enemy_container, player_instance)

func _exit_tree() -> void:
	# Nettoyer quand on quitte la scène
	if wave_manager:
		wave_manager.stop_spawning()
		wave_manager.clear_all_enemies()

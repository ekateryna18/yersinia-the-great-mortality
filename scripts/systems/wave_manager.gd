extends Node

# ============================================
# SCENES DES ENNEMIS
# ============================================
# ← MODIFIÉ: Charger les 3 scènes différentes
var rat_normal_scene: PackedScene = preload("res://scenes/enemies/rat.tscn")
var rat_mutant_scene: PackedScene = preload("res://scenes/enemies/rat_mutant.tscn")
var rat_boss_scene: PackedScene = preload("res://scenes/enemies/rat_boss.tscn")

# Configuration par nuit
var wave_config = {
	1: { "max_enemies": 8, "spawn_delay": 5.0 },
	2: { "max_enemies": 15, "spawn_delay": 3.0 },
	3: { "max_enemies": 25, "spawn_delay": 3.0 },
	4: { "max_enemies": 35, "spawn_delay": 1.0 },
	5: { "max_enemies": 50, "spawn_delay": 1.0 }
}

var current_night: int = 1
var alive_enemies: int = 0
var max_enemies: int = 8
var spawn_delay: float = 5.0
var last_spawn_time: float = 0.0
var is_spawning: bool = false
var boss_spawned: bool = false

var enemy_container: Node2D = null
var player_ref: CharacterBody2D = null
var spawn_points: Array = []
var boss_spawn_point: Marker2D = null

func _ready() -> void:
	print("=== Wave Manager Initialized ===")

func initialize(night: int, container: Node2D, player: CharacterBody2D) -> void:
	current_night = night
	enemy_container = container
	player_ref = player
	boss_spawned = false
	
	# Charger la config de la nuit
	if wave_config.has(current_night):
		max_enemies = wave_config[current_night]["max_enemies"]
		spawn_delay = wave_config[current_night]["spawn_delay"]
	else:
		max_enemies = 50
		spawn_delay = 3.0
	
	# Récupérer les spawn points
	find_spawn_points()
	
	print("Wave Manager initialized for Night ", current_night)
	print("Max enemies: ", max_enemies, " | Spawn delay: ", spawn_delay, "s")
	print("Spawn points found: ", spawn_points.size())
	
	# Spawner le boss immédiatement en Nuit 5
	if current_night == 5:
		spawn_boss()
	
	# Démarrer le spawn normal
	is_spawning = true
	last_spawn_time = Time.get_ticks_msec() / 1000.0

func find_spawn_points() -> void:
	var map_scene = enemy_container.get_parent()
	
	print("Searching for spawn points in: ", map_scene.name)
	
	if map_scene.has_node("EnemySpawnPoints"):
		var spawn_container = map_scene.get_node("EnemySpawnPoints")
		spawn_points = spawn_container.get_children()
		print("✅ Found ", spawn_points.size(), " spawn points")
	else:
		print("⚠️ No EnemySpawnPoints found! Using fallback")
		spawn_points = []
	
	if map_scene.has_node("BossSpawnPoint"):
		boss_spawn_point = map_scene.get_node("BossSpawnPoint")
		print("✅ Boss spawn point found at: ", boss_spawn_point.global_position)
	else:
		print("⚠️ No BossSpawnPoint found in ", map_scene.name)
		boss_spawn_point = null

func _process(delta: float) -> void:
	if not is_spawning:
		return
	
	if get_tree() == null:
		return
	
	if not GameManager.is_night():
		stop_spawning()
		return
	
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if current_time - last_spawn_time >= spawn_delay:
		update_alive_count()
		
		if alive_enemies < max_enemies:
			spawn_enemy()
			last_spawn_time = current_time

func update_alive_count() -> void:
	if not is_instance_valid(self) or get_tree() == null:
		alive_enemies = 0
		return
	
	alive_enemies = get_tree().get_nodes_in_group("enemies").size()

# ============================================
# SPAWN ENEMY - MODIFIÉ
# ============================================
func spawn_enemy() -> void:
	if not enemy_container or not player_ref:
		return
	
	# Déterminer le type d'ennemi
	var enemy_type = get_enemy_type_for_night()
	
	# ← MODIFIÉ: Charger la bonne scène selon le type
	var enemy_scene: PackedScene
	var enemy_name: String
	
	match enemy_type:
		0:  # RAT_NORMAL
			enemy_scene = rat_normal_scene
			enemy_name = "Rat Normal"
		1:  # RAT_MUTANT
			enemy_scene = rat_mutant_scene
			enemy_name = "Rat Mutant"
		2:  # RAT_BOSS (ne devrait pas arriver via spawn_enemy)
			enemy_scene = rat_boss_scene
			enemy_name = "Rat Boss"
		_:
			enemy_scene = rat_normal_scene
			enemy_name = "Rat Normal"
	
	# Créer l'ennemi depuis la bonne scène
	var enemy = enemy_scene.instantiate()
	
	# Position de spawn
	var spawn_pos = get_random_spawn_position()
	enemy.global_position = spawn_pos
	
	# Ajouter à la scène
	enemy_container.add_child(enemy)
	
	alive_enemies += 1
	print(enemy_name, " spawned at ", spawn_pos, " (", alive_enemies, "/", max_enemies, ")")

func get_random_spawn_position() -> Vector2:
	if spawn_points.size() > 0:
		var random_point = spawn_points[randi() % spawn_points.size()]
		return random_point.global_position
	
	# Fallback
	if not player_ref:
		return Vector2.ZERO
	
	var spawn_distance = randf_range(300, 500)
	var spawn_angle = randf_range(0, TAU)
	
	var offset = Vector2(
		cos(spawn_angle) * spawn_distance,
		sin(spawn_angle) * spawn_distance
	)
	
	var spawn_pos = player_ref.global_position + offset
	spawn_pos = GameManager.clamp_to_bounds(spawn_pos)
	
	return spawn_pos

func get_enemy_type_for_night() -> int:
	if current_night <= 1:
		return 0  # RAT_NORMAL uniquement
	
	if current_night <= 3:
		var rand = randf()
		if rand < 0.7:
			return 0  # RAT_NORMAL (70%)
		else:
			return 1  # RAT_MUTANT (30%)
	
	#if current_night <= 5:
	var rand = randf()
	if rand < 0.5:
		return 0  # RAT_NORMAL (50%)
	else:
		return 1  # RAT_MUTANT (50%)

# ============================================
# SPAWN BOSS - MODIFIÉ
# ============================================
func spawn_boss() -> void:
	if boss_spawned or not enemy_container or not player_ref:
		return
	
	print("🔥 SPAWNING BOSS! 🔥")
	
	# ← MODIFIÉ: Utiliser la scène du boss
	var boss = rat_boss_scene.instantiate()
	
	# Position depuis BossSpawnPoint si existe
	var spawn_pos: Vector2
	if boss_spawn_point and is_instance_valid(boss_spawn_point):
		spawn_pos = boss_spawn_point.global_position
		print("✅ Boss spawning at BossSpawnPoint: ", spawn_pos)
	else:
		print("⚠️ BossSpawnPoint not found or invalid!")
		spawn_pos = player_ref.global_position + Vector2(0, -400)
		spawn_pos = GameManager.clamp_to_bounds(spawn_pos)
		print("Boss spawning at fallback: ", spawn_pos)
	
	boss.global_position = spawn_pos
	
	# Ajouter à la scène
	enemy_container.add_child(boss)
	
	boss_spawned = true
	alive_enemies += 1
	
	print("Rat Boss spawned at: ", spawn_pos)

func stop_spawning() -> void:
	is_spawning = false
	print("Wave Manager stopped spawning")

func clear_all_enemies() -> void:
	if not is_instance_valid(self) or get_tree() == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	
	alive_enemies = 0
	print("All enemies cleared")

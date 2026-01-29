extends Node

# ============================================
# WAVE MANAGER - Gestion du spawn continu
# ============================================

# Configuration par nuit
var wave_config = {
	1: { "max_enemies": 8, "spawn_delay": 5.0 },
	2: { "max_enemies": 15, "spawn_delay": 5.0 },
	3: { "max_enemies": 25, "spawn_delay": 5.0 },
	4: { "max_enemies": 35, "spawn_delay": 5.0 },
	5: { "max_enemies": 50, "spawn_delay": 5.0 }
}

# État actuel
var current_night: int = 1
var alive_enemies: int = 0
var max_enemies: int = 8
var spawn_delay: float = 5.0
var last_spawn_time: float = 0.0
var is_spawning: bool = false
var boss_spawned: bool = false
var spawn_points: Array = []  
var boss_spawn_point: Marker2D = null

# Références
var enemy_container: Node2D = null
var player_ref: CharacterBody2D = null

# Prefabs
var rat_scene: PackedScene = preload("res://scenes/enemies/rat.tscn")

func _ready() -> void:
	print("=== Wave Manager Initialized ===")

func initialize(night: int, container: Node2D, player: CharacterBody2D) -> void:
	current_night = night
	enemy_container = container
	player_ref = player
	boss_spawned = false  # ← AJOUTER
	
	# Charger la config de la nuit
	if wave_config.has(current_night):
		max_enemies = wave_config[current_night]["max_enemies"]
		spawn_delay = wave_config[current_night]["spawn_delay"]
	else:
		max_enemies = 50
		spawn_delay = 3.0
		
	find_spawn_points()
	
	print("Wave Manager initialized for Night ", current_night)
	print("Max enemies: ", max_enemies, " | Spawn delay: ", spawn_delay, "s")
	
	# Spawner le boss immédiatement en Nuit 5
	if current_night == 5:
		spawn_boss()
	
	# Démarrer le spawn normal
	is_spawning = true
	last_spawn_time = Time.get_ticks_msec() / 1000.0

func find_spawn_points() -> void:
	# Chercher le conteneur de spawn points dans la map
	var map_scene = enemy_container.get_parent()
	
	if map_scene.has_node("EnemySpawnPoints"):
		var spawn_container = map_scene.get_node("EnemySpawnPoints")
		spawn_points = spawn_container.get_children()
		print("Found ", spawn_points.size(), " spawn points")
	else:
		print("⚠️ No EnemySpawnPoints found! Using fallback")
		spawn_points = []
	
	# Chercher le spawn point du boss
	if map_scene.has_node("BossSpawnPoint"):
		boss_spawn_point = map_scene.get_node("BossSpawnPoint")
		print("Boss spawn point found at: ", boss_spawn_point.global_position)
	else:
		print("⚠️ No BossSpawnPoint found")

func _process(delta: float) -> void:
	if not is_spawning:
		return
	
	# Vérifier que le tree existe
	if get_tree() == null:
		return
	
	# Vérifier si c'est encore la nuit
	if not GameManager.is_night():
		stop_spawning()
		return
	
	# Vérifier si on doit spawner
	var current_time = Time.get_ticks_msec() / 1000.0
	
	if current_time - last_spawn_time >= spawn_delay:
		# Compter les ennemis vivants
		update_alive_count()
		
		# Spawner si en dessous du max
		if alive_enemies < max_enemies:
			spawn_enemy()
			last_spawn_time = current_time

func update_alive_count() -> void:
	# Vérifier que le tree existe encore
	if not is_instance_valid(self) or get_tree() == null:
		alive_enemies = 0
		return
	
	# Compter les ennemis vivants dans le groupe
	alive_enemies = get_tree().get_nodes_in_group("enemies").size()

func spawn_enemy() -> void:
	if not enemy_container or not player_ref:
		return
	
	# Déterminer le type d'ennemi
	var enemy_type = get_enemy_type_for_night()
	
	# Créer l'ennemi
	var enemy = rat_scene.instantiate()
	enemy.enemy_type = enemy_type
	
	# ← MODIFIÉ: Position de spawn depuis un spawn point
	var spawn_pos = get_random_spawn_position()
	enemy.global_position = spawn_pos
	
	# Ajouter à la scène
	enemy_container.add_child(enemy)
	
	alive_enemies += 1
	print("Enemy spawned at ", spawn_pos, " (", alive_enemies, "/", max_enemies, ")")

# ← FONCTION MODIFIÉE
func get_random_spawn_position() -> Vector2:
	# Si on a des spawn points, en choisir un aléatoirement
	if spawn_points.size() > 0:
		var random_point = spawn_points[randi() % spawn_points.size()]
		return random_point.global_position
	
	# Fallback: spawner autour du joueur (ancien système)
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
	# Nuits 1-2: Que des rats normaux
	if current_night <= 2:
		return 0  # RAT_NORMAL
	
	# Nuits 3-4: Mix rats normaux et mutants
	if current_night <= 4:
		var rand = randf()
		if rand < 0.7:
			return 0  # RAT_NORMAL (70%)
		else:
			return 1  # RAT_MUTANT (30%)
	
	# Nuit 5: Mix avec boss possible
	var rand = randf()
	if rand < 0.5:
		return 0  # RAT_NORMAL (50%)
	elif rand < 0.9:
		return 1  # RAT_MUTANT (40%)
	else:
		return 2  # RAT_BOSS (10%)

func stop_spawning() -> void:
	is_spawning = false
	print("Wave Manager stopped spawning")

func clear_all_enemies() -> void:
	# Vérifier que le tree existe encore
	if not is_instance_valid(self) or get_tree() == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	
	alive_enemies = 0
	print("All enemies cleared")

func spawn_boss() -> void:
	if boss_spawned or not enemy_container or not player_ref:
		return
	
	print("🔥 SPAWNING BOSS! 🔥")
	
	# Créer le boss
	var boss = rat_scene.instantiate()
	boss.enemy_type = 2  # RAT_BOSS
	
	# ← MODIFIÉ: Position depuis BossSpawnPoint si existe
	var spawn_pos: Vector2
	if boss_spawn_point:
		spawn_pos = boss_spawn_point.global_position
		print("Boss spawning at BossSpawnPoint: ", spawn_pos)
	else:
		# Fallback: devant le joueur
		spawn_pos = player_ref.global_position + Vector2(0, -400)
		spawn_pos = GameManager.clamp_to_bounds(spawn_pos)
		print("Boss spawning at fallback position: ", spawn_pos)
	
	boss.global_position = spawn_pos
	
	# Ajouter à la scène
	enemy_container.add_child(boss)
	
	boss_spawned = true
	alive_enemies += 1
	
	print("Boss spawned!")

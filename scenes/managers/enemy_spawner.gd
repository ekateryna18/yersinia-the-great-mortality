extends Node2D
## Gestionnaire du spawn d'ennemis avec pooling

class_name EnemySpawner

# ========================
# CONFIGURATION
# ========================
@export var enemy_scene: PackedScene  # Scene de l'ennemi à spawner
@export var pool_size: int = 30      # Taille du pool d'objets

# ========================
# STATE
# ========================
var is_spawning: bool = false
var spawn_timer: float = 0.0
var spawn_interval: float = 15.0
var enemies_spawned_this_night: int = 0
var max_enemies_on_screen: int = 15

# ========================
# ENEMY POOL
# ========================
var enemy_pool: Array[Enemy] = []
var active_enemies: Array[Enemy] = []

# ========================
# SPAWN LOCATIONS
# ========================
var spawn_zones: Array[Vector2] = [
	Vector2(50, 50),      # Top-left
	Vector2(1230, 50),    # Top-right
	Vector2(50, 710),     # Bottom-left
	Vector2(1230, 710)    # Bottom-right
]

# ========================
# WAVE CONFIG
# ========================
var current_difficulty: float = 1.0
var current_wave: int = 0

# ========================
# LIFECYCLE
# ========================
func _ready() -> void:
	add_to_group("enemy_spawner")
	
	# Initialiser le pool d'ennemis
	_initialize_pool()

func _initialize_pool() -> void:
	"""Créer le pool d'ennemis inactifs"""
	if not enemy_scene:
		push_error("EnemySpawner: No enemy scene assigned!")
		return
	
	for i in range(pool_size):
		var enemy = enemy_scene.instantiate()
		enemy.visible = false
		enemy.process_mode = Node.PROCESS_MODE_DISABLED
		add_child(enemy)
		enemy_pool.append(enemy)

func _process(delta: float) -> void:
	if not is_spawning:
		return
	
	spawn_timer -= delta
	
	if spawn_timer <= 0:
		_spawn_enemies()
		spawn_timer = spawn_interval

# ========================
# SPAWNING
# ========================
func start_night_spawning(difficulty: float, interval: float, max_on_screen: int) -> void:
	"""Démarrer le spawn des ennemis pour la nuit"""
	is_spawning = true
	current_difficulty = difficulty
	spawn_interval = interval
	max_enemies_on_screen = max_on_screen
	spawn_timer = 0.0  # Spawn immédiat au démarrage
	enemies_spawned_this_night = 0
	current_wave = 0

func stop_night_spawning() -> void:
	"""Arrêter le spawn des ennemis"""
	is_spawning = false
	
	# Désactiver tous les ennemis actifs
	for enemy in active_enemies:
		_deactivate_enemy(enemy)
	
	active_enemies.clear()

func _spawn_enemies() -> void:
	"""Spawner une vague d'ennemis"""
	
	# Vérifier le nombre max d'ennemis
	if active_enemies.size() >= max_enemies_on_screen:
		return
	
	current_wave += 1
	
	# Déterminer le type et nombre d'ennemis basés sur la difficulté
	var spawn_config = _get_spawn_config(current_wave, current_difficulty)
	
	for i in range(spawn_config["count"]):
		# Obtenir un ennemi du pool
		var enemy = _get_pooled_enemy()
		
		if not enemy:
			continue
		
		# Position de spawn aléatoire
		var spawn_zone = spawn_zones[randi() % spawn_zones.size()]
		var random_offset = Vector2(randf_range(-30, 30), randf_range(-30, 30))
		var spawn_pos = spawn_zone + random_offset
		
		# Configurer l'ennemi
		enemy.enemy_type = spawn_config["type"]
		enemy.apply_difficulty_scaling(current_difficulty)
		enemy.reset_for_pooling(spawn_pos, current_difficulty)
		
		# Setter le joueur comme cible
		var player = get_tree().get_first_node_in_group("player")
		if player:
			enemy.set_target(player)
		
		# Activer l'ennemi
		enemy.visible = true
		enemy.process_mode = Node.PROCESS_MODE_INHERIT
		
		active_enemies.append(enemy)
		enemies_spawned_this_night += 1

func _get_spawn_config(wave: int, difficulty: float) -> Dictionary:
	"""Déterminer le type et nombre d'ennemis à spawner"""
	
	# Nuits 1-4: Mix de Rat et Rat Mutant
	# Nuit 5: Beaucoup plus (50+), inclut Boss
	
	var rat_ratio = clamp(1.0 - (difficulty * 0.2), 0.3, 1.0)  # Moins de rats à haute difficulté
	
	var enemy_type = Enemy.EnemyType.RAT if randf() < rat_ratio else Enemy.EnemyType.RAT_MUTANT
	
	# Nombre d'ennemis par spawn (augmente avec difficulté)
	var count = int(1 + (difficulty * 0.5))
	
	return {
		"type": enemy_type,
		"count": count
	}

# ========================
# OBJECT POOLING
# ========================
func _get_pooled_enemy() -> Enemy:
	"""Obtenir un ennemi du pool inactif"""
	if enemy_pool.is_empty():
		# Si le pool est vide, créer un nouvel ennemi
		if enemy_scene:
			var new_enemy = enemy_scene.instantiate()
			add_child(new_enemy)
			return new_enemy
		return null
	
	return enemy_pool.pop_front()

func _deactivate_enemy(enemy: Enemy) -> void:
	"""Désactiver un ennemi et le retourner au pool"""
	if not enemy:
		return
	
	enemy.visible = false
	enemy.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.is_alive = true
	enemy_pool.append(enemy)

# ========================
# CALLBACKS
# ========================
func on_enemy_defeated(enemy: Enemy) -> void:
	"""Callback quand un ennemi est vaincu"""
	active_enemies.erase(enemy)
	_deactivate_enemy(enemy)

func on_enemy_escaped(enemy: Enemy) -> void:
	"""Callback quand un ennemi échappe (map)"""
	active_enemies.erase(enemy)
	_deactivate_enemy(enemy)

# ========================
# HELPERS
# ========================
func get_active_enemy_count() -> int:
	"""Nombre d'ennemis actifs"""
	return active_enemies.size()

func get_spawn_stats() -> Dictionary:
	"""Statistiques de spawn"""
	return {
		"active_enemies": active_enemies.size(),
		"pool_available": enemy_pool.size(),
		"total_spawned": enemies_spawned_this_night,
		"current_wave": current_wave,
		"difficulty": current_difficulty
	}

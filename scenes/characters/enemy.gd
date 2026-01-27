extends BaseCharacter
## Ennemis du jeu - Rats mutants

class_name Enemy

# ========================
# ENEMY TYPES
# ========================
enum EnemyType { RAT, RAT_MUTANT, RAT_BOSS }

@export var enemy_type: EnemyType = EnemyType.RAT
@export var difficulty_modifier: float = 1.0  # Multiplicateur basé sur la difficulté

# ========================
# AI CONFIG
# ========================
var target: CharacterBody2D = null  # Le joueur
var detection_range: float = 200.0
var chase_range: float = 300.0
var attack_range_enemy: float = 40.0
var attack_cooldown_enemy: float = 0.8

# ========================
# STATE
# ========================
var is_chasing: bool = false
var is_attacking: bool = false
var attack_timer: float = 0.0
var idle_timer: float = 0.0
var idle_duration: float = randf_range(1.0, 3.0)

# ========================
# REWARDS
# ========================
var glory_reward: int = 10

# ========================
# LIFECYCLE
# ========================
func _ready() -> void:
	super._ready()
	
	# Initialiser basée sur le type
	_initialize_enemy_type()
	
	add_to_group("enemies")

func _initialize_enemy_type() -> void:
	"""Initialiser les stats basées sur le type d'ennemi"""
	match enemy_type:
		EnemyType.RAT:
			_setup_rat()
		EnemyType.RAT_MUTANT:
			_setup_rat_mutant()
		EnemyType.RAT_BOSS:
			_setup_rat_boss()

# ========================
# ENEMY SETUP
# ========================
func _setup_rat() -> void:
	"""Rat basique - Nuits 1-4"""
	base_hp = 15
	base_damage = 3
	base_speed = 120.0
	base_crit_chance = 0.05
	base_knockback = 50.0
	
	attack_range_enemy = 35.0
	attack_cooldown_enemy = 1.2
	
	glory_reward = 10
	
	reset_stats()

func _setup_rat_mutant() -> void:
	"""Rat Mutant - Nuits 2-5 plus fréquent"""
	base_hp = 25
	base_damage = 6
	base_speed = 150.0
	base_crit_chance = 0.1
	base_knockback = 70.0
	
	attack_range_enemy = 40.0
	attack_cooldown_enemy = 0.9
	
	glory_reward = 25
	
	reset_stats()

func _setup_rat_boss() -> void:
	"""Rat Boss - Nuit 5 finale"""
	base_hp = 100
	base_damage = 12
	base_speed = 140.0
	base_crit_chance = 0.15
	base_knockback = 100.0
	
	attack_range_enemy = 50.0
	attack_cooldown_enemy = 0.6
	
	glory_reward = 200
	
	reset_stats()

# ========================
# AI BEHAVIOR
# ========================
func _handle_movement(delta: float) -> void:
	"""IA du mouvement : Chasser le joueur"""
	
	# Actualiser timers
	attack_timer = max(0, attack_timer - delta)
	
	# Pas de cible = ne rien faire
	if not target or not target.is_alive:
		_idle_behavior(delta)
		return
	
	var distance_to_target = global_position.distance_to(target.global_position)
	
	# Si le joueur est détecté
	if distance_to_target < chase_range:
		is_chasing = true
		
		# Se rapprocher
		var direction = (target.global_position - global_position).normalized()
		position += direction * current_speed * delta
		
		# Attaquer si en portée
		if distance_to_target < attack_range_enemy and attack_timer <= 0:
			_attack_player()
		
		# Orientation sprite
		if sprite:
			sprite.flip_h = direction.x < 0
	else:
		# Joueur trop loin = arrêter de chasser
		is_chasing = false
		_idle_behavior(delta)

func _idle_behavior(delta: float) -> void:
	"""Comportement inactif : errer aléatoirement"""
	idle_timer -= delta
	
	if idle_timer <= 0:
		# Nouveau point de destination aléatoire
		var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		position += random_direction * current_speed * 0.5 * delta
		
		idle_timer = idle_duration
		idle_duration = randf_range(1.0, 3.0)

# ========================
# ATTACK
# ========================
func _attack_player() -> void:
	"""Attaquer le joueur"""
	if not target:
		return
	
	attack_timer = attack_cooldown_enemy
	
	var dmg = calculate_damage_with_crit()
	target.take_damage(dmg)
	
	# Knockback du joueur
	var knockback_direction = (target.global_position - global_position).normalized()
	target.apply_knockback(knockback_direction, 0.8)
	
	# Animation attaque
	if animation_player and animation_player.has_animation("attack"):
		animation_player.play("attack")

# ========================
# DIFFICULTY SCALING
# ========================
func apply_difficulty_scaling(difficulty: float) -> void:
	"""Appliquer le multiplicateur de difficulté"""
	difficulty_modifier = difficulty
	
	base_hp = int(base_hp * difficulty)
	base_damage = int(base_damage * difficulty)
	base_speed = base_speed * difficulty
	base_crit_chance = clamp(base_crit_chance + (difficulty - 1.0) * 0.05, 0.0, 1.0)
	base_knockback = base_knockback * difficulty
	
	reset_stats()

# ========================
# DEATH
# ========================
func die() -> void:
	"""Mourir et récompenser le joueur"""
	super.die()
	
	# Récompenser le joueur
	if target and target.has_method("add_glory"):
		target.glory_earned += glory_reward
	
	# Notifier le GameManager (pool, compte kills, etc.)
	# TODO: get_tree().call_group("game_manager", "on_enemy_defeated", self)

func take_damage(damage: int) -> void:
	"""Recevoir des dégâts avec bonus du joueur"""
	super.take_damage(damage)

# ========================
# SPAWNING & POOLING
# ========================
func reset_for_pooling(new_position: Vector2, difficulty: float) -> void:
	"""Réinitialiser pour réutilisation du pool"""
	global_position = new_position
	
	is_alive = true
	is_chasing = false
	is_attacking = false
	
	apply_difficulty_scaling(difficulty)
	
	if animation_player and animation_player.has_animation("idle"):
		animation_player.play("idle")

# ========================
# HELPERS
# ========================
func set_target(player: CharacterBody2D) -> void:
	"""Définir le joueur comme cible"""
	target = player

func get_enemy_type_name() -> String:
	"""Obtenir le nom du type d'ennemi"""
	match enemy_type:
		EnemyType.RAT:
			return "Rat"
		EnemyType.RAT_MUTANT:
			return "Rat Mutant"
		EnemyType.RAT_BOSS:
			return "Rat Boss"
		_:
			return "Unknown"

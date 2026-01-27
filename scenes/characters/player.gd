extends BaseCharacter
## Joueur contrôlable - Scythe attack, jour/nuit cycling

class_name Player

# ========================
# STATS PERMANENTES (inter-runs)
# ========================
@export var permanent_hp_bonus: int = 0       # Améliorations gloire
@export var permanent_damage_bonus: int = 0
@export var permanent_speed_bonus: float = 0.0
@export var permanent_crit_bonus: float = 0.0
@export var permanent_knockback_bonus: float = 0.0

# ========================
# GAMEPLAY CONFIG
# ========================
@export var attack_range: float = 50.0        # Portée de la faux
@export var attack_arc: float = PI * 0.5      # 90° en radians
@export var attack_cooldown: float = 0.5      # Temps entre attaques
@export var attack_radius: float = 40.0       # Rayon hit detection

# ========================
# INPUT & ÉTAT
# ========================
var left_stick_input: Vector2 = Vector2.ZERO   # Déplacement
var right_stick_input: Vector2 = Vector2.ZERO  # Orientation attaque
var current_facing_direction: Vector2 = Vector2.RIGHT

var is_attacking: bool = false
var attack_timer: float = 0.0
var can_attack: bool = true

# ========================
# RUN STATS (reset chaque run)
# ========================
var glory_earned: int = 0
var good_points: int = 0
var bad_points: int = 0
var kills_count: int = 0
var night_survived: int = 0

# ========================
# DAY/NIGHT CYCLE
# ========================
var current_day: int = 1
var is_night: bool = false
var night_spawn_timer: float = 0.0

# ========================
# REFERENCES
# ========================
var hit_detection_area: Area2D

# ========================
# LIFECYCLE
# ========================
func _ready() -> void:
	super._ready()
	
	# Appliquer les bonus permanents
	apply_permanent_bonuses()
	
	# Créer une Area2D pour la détection des coups
	hit_detection_area = Area2D.new()
	add_child(hit_detection_area)
	
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = attack_radius
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = circle_shape
	hit_detection_area.add_child(collision_shape)

func _handle_movement(delta: float) -> void:
	"""Gérer le mouvement du joueur"""
	if not can_attack and attack_timer > 0:
		attack_timer -= delta
		if attack_timer <= 0:
			can_attack = true
	
	# Mouvement via joystick gauche
	if left_stick_input.length() > 0.1:
		velocity = left_stick_input * current_speed
		position += velocity * delta
	else:
		velocity = Vector2.ZERO
	
	# Orientation attaque via joystick droit
	if right_stick_input.length() > 0.1:
		current_facing_direction = right_stick_input.normalized()
		_update_sprite_direction()
	
	# Attaquer si joystick droit activé
	if right_stick_input.length() > 0.5 and can_attack:
		attack()

# ========================
# ATTACK SYSTEM
# ========================
func attack() -> void:
	"""Attaquer avec la faux (zone 90°)"""
	can_attack = false
	attack_timer = attack_cooldown
	is_attacking = true
	
	if animation_player and animation_player.has_animation("attack"):
		animation_player.play("attack")
	
	# Détecter ennemis dans la zone d'attaque
	var enemies_hit = _detect_enemies_in_arc()
	
	for enemy in enemies_hit:
		if enemy and enemy.has_method("take_damage"):
			var dmg = calculate_damage_with_crit()
			enemy.take_damage(dmg)
			
			# Appliquer knockback
			var knockback_dir = (enemy.global_position - global_position).normalized()
			enemy.apply_knockback(knockback_dir, 1.0)
			
			kills_count += 1

func _detect_enemies_in_arc() -> Array:
	"""Détecte les ennemis dans un arc de 90° devant le joueur"""
	var enemies_in_range = []
	
	# Requête physique en arc
	var query = PhysicsShapeQueryParameters2D.new()
	var circle = CircleShape2D.new()
	circle.radius = attack_range
	query.shape = circle
	query.transform = global_transform
	
	var result = get_world_2d().direct_space_state.intersect_shape(query)
	
	for hit in result:
		var collider = hit["collider"]
		
		# Vérifier si c'est un ennemi
		if collider.is_in_group("enemies"):
			# Vérifier l'angle (90° arc)
			var to_enemy = (collider.global_position - global_position).normalized()
			var angle_diff = current_facing_direction.angle_to(to_enemy)
			
			if abs(angle_diff) <= attack_arc * 0.5:
				enemies_in_range.append(collider)
	
	return enemies_in_range

# ========================
# DAY/NIGHT SYSTEM
# ========================
func start_night() -> void:
	"""Commencer la nuit (désactiver PNJ, activer ennemis)"""
	is_night = true
	night_survived = current_day
	night_spawn_timer = 0.0
	
	if animation_player and animation_player.has_animation("night_transition"):
		animation_player.play("night_transition")
	
	# Changer l'ambiance (sera géré par le manager)
	get_tree().call_group("pnj", "hide")
	get_tree().call_group("enemies", "show")

func end_night() -> void:
	"""Terminer la nuit, passer au jour suivant"""
	is_night = false
	current_day += 1
	
	if animation_player and animation_player.has_animation("day_transition"):
		animation_player.play("day_transition")
	
	# Réapparaître les PNJ
	get_tree().call_group("pnj", "show")
	get_tree().call_group("enemies", "hide")

func survive_night() -> void:
	"""Survivre une nuit = gain de gloire"""
	glory_earned += 50 + (current_day * 10)  # Bonus basé sur le jour

# ========================
# PERMANENT BONUSES
# ========================
func apply_permanent_bonuses() -> void:
	"""Appliquer les bonus permanents de la progression"""
	base_hp += permanent_hp_bonus
	base_damage += permanent_damage_bonus
	base_speed += permanent_speed_bonus
	base_crit_chance += permanent_crit_bonus
	base_knockback += permanent_knockback_bonus
	
	reset_stats()

func add_permanent_bonus(bonus_type: String, amount: float) -> void:
	"""Ajouter un bonus permanent (gloire → stats)"""
	match bonus_type:
		"hp":
			permanent_hp_bonus += int(amount)
		"damage":
			permanent_damage_bonus += int(amount)
		"speed":
			permanent_speed_bonus += amount
		"crit":
			permanent_crit_bonus += amount
		"knockback":
			permanent_knockback_bonus += amount

# ========================
# INPUT HANDLING (Mobile Joysticks)
# ========================
func set_left_stick(input: Vector2) -> void:
	"""Joystick gauche (déplacement)"""
	left_stick_input = input.normalized()

func set_right_stick(input: Vector2) -> void:
	"""Joystick droit (orientation attaque)"""
	right_stick_input = input.normalized()

# ========================
# VISUAL
# ========================
func _update_sprite_direction() -> void:
	"""Mettre à jour l'orientation du sprite"""
	if sprite and current_facing_direction.x != 0:
		sprite.flip_h = current_facing_direction.x < 0

# ========================
# DEATH & RUN RESET
# ========================
func die() -> void:
	super.die()
	
	# Arrêter la run
	get_tree().paused = true
	# Le manager gérera le game over et la continuation

func reset_run_stats() -> void:
	"""Réinitialiser les stats de la run (mais pas les permanentes)"""
	glory_earned = 0
	good_points = 0
	bad_points = 0
	kills_count = 0
	night_survived = 0
	current_day = 1
	is_night = false
	is_alive = true
	
	reset_stats()

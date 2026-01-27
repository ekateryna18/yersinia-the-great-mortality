extends CharacterBody2D
## Base class pour tous les personnages (Joueur, PNJ, Ennemis)

class_name BaseCharacter

# ========================
# STATS ÉVOLUTIVES
# ========================
@export var base_hp: int = 100
@export var base_damage: int = 10
@export var base_speed: float = 150.0
@export var base_crit_chance: float = 0.1  # 10%
@export var base_knockback: float = 100.0

var current_hp: int
var current_damage: int
var current_speed: float
var current_crit_chance: float
var current_knockback: float

# ========================
# ÉTAT
# ========================
var is_alive: bool = true
var is_stunned: bool = false
var stun_timer: float = 0.0
var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_decay: float = 0.95  # Decay factor per frame

# ========================
# RÉFÉRENCES
# ========================
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer if has_node("AnimationPlayer") else null

# ========================
# LIFECYCLE
# ========================
func _ready() -> void:
	# Initialiser les stats courantes
	reset_stats()
	
	if animation_player:
		animation_player.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	if not is_alive:
		return
	
	# Update stun
	if is_stunned:
		stun_timer -= delta
		if stun_timer <= 0:
			is_stunned = false
	
	# Update knockback
	if knockback_velocity.length() > 0.5:
		position += knockback_velocity * delta
		knockback_velocity *= knockback_decay
	else:
		knockback_velocity = Vector2.ZERO
	
	# Appel custom movement (override par subclasses)
	_handle_movement(delta)

# ========================
# STATS MANAGEMENT
# ========================
func reset_stats() -> void:
	"""Initialiser les stats courantes à partir des valeurs de base"""
	current_hp = base_hp
	current_damage = base_damage
	current_speed = base_speed
	current_crit_chance = base_crit_chance
	current_knockback = base_knockback

func apply_stat_modifier(stat: String, value: float) -> void:
	"""Appliquer un modificateur temporaire à une stat"""
	match stat:
		"damage":
			current_damage = int(base_damage * (1.0 + value))
		"speed":
			current_speed = base_speed * (1.0 + value)
		"crit_chance":
			current_crit_chance = clamp(base_crit_chance + value, 0.0, 1.0)
		"knockback":
			current_knockback = base_knockback * (1.0 + value)
		"hp":
			current_hp = int(base_hp * (1.0 + value))

func take_damage(damage: int) -> void:
	"""Recevoir des dégâts"""
	if not is_alive:
		return
	
	current_hp = max(0, current_hp - damage)
	
	# Trigger hurt animation
	if animation_player and animation_player.has_animation("hurt"):
		animation_player.play("hurt")
	
	if current_hp <= 0:
		die()

func apply_knockback(direction: Vector2, force: float = 1.0) -> void:
	"""Appliquer un knockback"""
	knockback_velocity = direction.normalized() * current_knockback * force

func stun(duration: float = 0.5) -> void:
	"""Étourdir le personnage"""
	is_stunned = true
	stun_timer = duration

func die() -> void:
	"""Mourir"""
	is_alive = false
	
	if animation_player and animation_player.has_animation("die"):
		animation_player.play("die")
	else:
		# Fallback : disparaître
		queue_free()

# ========================
# VIRTUAL METHODS (pour override)
# ========================
func _handle_movement(_delta: float) -> void:
	"""À implémenter par les subclasses"""
	pass

func _on_animation_finished(_anim_name: String) -> void:
	"""Callback quand une animation se termine"""
	if _anim_name == "die" and not is_alive:
		queue_free()

# ========================
# HELPERS
# ========================
func calculate_damage_with_crit(base_dmg: int = -1) -> int:
	"""Calculer les dégâts avec chance de crit (x2)"""
	if base_dmg == -1:
		base_dmg = current_damage
	
	if randf() < current_crit_chance:
		return base_dmg * 2
	return base_dmg

func is_dead() -> bool:
	return not is_alive

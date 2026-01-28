extends CharacterBody2D

# Stats du joueur
@export var speed: float = 300.0
@export var max_health: float = 100.0
@export var damage: float = 10.0
@export var armor: float = 0.0
@export var attack_cooldown: float = 0.2  # Attaque toutes les 0.5 secondes

var current_health: float
var is_frozen: bool = false
var last_attack_time: float = 0.0

# Références
@onready var attack_area: Area2D = $AttackArea

func _ready() -> void:
	current_health = max_health
	add_to_group("player")
	print("Player ready - HP: %d/%d | Damage: %d" % [current_health, max_health, damage])

func _physics_process(delta: float) -> void:
	# Si le joueur est gelé, ne pas bouger
	if is_frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	# Récupérer l'input (ZQSD ou flèches)
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	# Normaliser pour éviter mouvement diagonal plus rapide
	input_vector = input_vector.normalized()
	
	# Appliquer le mouvement
	velocity = input_vector * speed
	
	# Déplacer le personnage
	move_and_slide()
	
	# Limiter à la map
	if GameManager.is_within_bounds(global_position) == false:
		global_position = GameManager.clamp_to_bounds(global_position)

func _process(delta: float) -> void:
	# Auto-attack en continu
	auto_attack()

func auto_attack() -> void:
	# Vérifier le cooldown
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_attack_time < attack_cooldown:
		return
	
	# Vérifier qu'on est en nuit (pas d'attaque en jour)
	if not GameManager.is_night():
		return
	
	# Trouver tous les ennemis dans la zone d'attaque
	if not attack_area:
		return
	
	var enemies_in_range = attack_area.get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		# Attaquer le premier ennemi trouvé
		for enemy in enemies_in_range:
			if enemy.is_in_group("enemies"):
				if enemy.has_method("take_damage"):
					enemy.take_damage(damage)
					last_attack_time = current_time
					print("Player attacked enemy for ", damage, " damage")
					# Feedback visuel simple
					flash_attack()
					break  # Attaquer un seul ennemi à la fois

func flash_attack() -> void:
	# Flash du sprite
	if has_node("Sprite2D2"):
		var sprite = get_node("Sprite2D2")
		sprite.modulate = Color.YELLOW
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
	
	# Afficher l'effet d'attaque (si existe)
	if has_node("AttackEffect"):
		var effect = get_node("AttackEffect")
		effect.visible = true
		await get_tree().create_timer(0.15).timeout
		effect.visible = false

func freeze() -> void:
	is_frozen = true
	velocity = Vector2.ZERO
	print("Player FROZEN")

func unfreeze() -> void:
	is_frozen = false
	print("Player UNFROZEN")

func take_damage(amount: float) -> void:
	var actual_damage = max(0, amount - armor)
	current_health -= actual_damage
	print("Player took %d damage (%.1f blocked by armor)" % [actual_damage, armor])
	
	if current_health <= 0:
		die()

func heal(amount: float) -> void:
	current_health = min(max_health, current_health + amount)
	print("Player healed for %d HP" % amount)

func die() -> void:
	print("Player died!")
	
	# Désactiver immédiatement le joueur
	set_physics_process(false)
	set_process(false)
	set_process_input(false)
	visible = false
	
	# Notifier le GameManager immédiatement
	GameManager.on_player_death()

func get_health_percent() -> float:
	return current_health / max_health

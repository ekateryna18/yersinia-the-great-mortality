extends CharacterBody2D

# Stats du joueur
@export var speed: float = 300.0
@export var max_health: float = 100.0
@export var damage: float = 10.0
@export var armor: float = 0.0

var current_health: float

func _ready() -> void:
	current_health = max_health
	add_to_group("player")  # ← AJOUTER CETTE LIGNE
	print("Player ready - HP: %d/%d" % [current_health, max_health])

func _physics_process(delta: float) -> void:
	# Récupérer l'input (ZQSD ou flèches)
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	# Normaliser pour éviter mouvement diagonal plus rapide
	input_vector = input_vector.normalized()
	
	# Appliquer le mouvement
	velocity = input_vector * speed
	
	# Déplacer le personnage (gère automatiquement les collisions)
	move_and_slide()  # ← Cette fonction gère les collisions automatiquement
	
	# Limiter à la map
	if GameManager.is_within_bounds(global_position) == false:
		global_position = GameManager.clamp_to_bounds(global_position)
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
	set_process_input(false)
	visible = false
	
	# Notifier le GameManager immédiatement
	GameManager.on_player_death()

# Getters pour le HUD
func get_health_percent() -> float:
	return current_health / max_health

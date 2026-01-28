extends CharacterBody2D

# Stats du joueur
@export var speed: float = 300.0
@export var max_health: float = 100.0

var current_health: float

func _ready() -> void:
	current_health = max_health

func _physics_process(delta: float) -> void:
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
	
	# Limiter à la map (optionnel)
	if GameManager.is_within_bounds(global_position) == false:
		global_position = GameManager.clamp_to_bounds(global_position)

func take_damage(amount: float) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

func die() -> void:
	print("Player died!")
	# TODO: Game Over logic
	queue_free()

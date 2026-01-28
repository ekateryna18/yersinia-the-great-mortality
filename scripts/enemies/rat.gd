extends CharacterBody2D

# Types d'ennemis
enum EnemyType {
	RAT_NORMAL,
	RAT_MUTANT,
	RAT_BOSS
}

# Stats de l'ennemi
@export var enemy_type: EnemyType = EnemyType.RAT_NORMAL
@export var max_health: float = 20.0
@export var speed: float = 150.0
@export var damage: float = 10.0
@export var contact_damage_cooldown: float = 1.0

var current_health: float
var player_ref: CharacterBody2D = null
var last_contact_damage_time: float = 0.0

# Références
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	current_health = max_health
	
	# Ajouter au groupe enemies
	add_to_group("enemies")
	
	# Trouver le joueur automatiquement
	find_player()
	
	# Configurer l'apparence selon le type
	set_sprite_color()
	
	print("Enemy spawned: ", EnemyType.keys()[enemy_type], " HP:", current_health)

func find_player() -> void:
	# Chercher le joueur dans le groupe
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_ref = players[0]
		print("Enemy found player automatically")

func set_sprite_color() -> void:
	match enemy_type:
		EnemyType.RAT_NORMAL:
			sprite.modulate = Color.RED
			speed = 150.0
			max_health = 20.0
		EnemyType.RAT_MUTANT:
			sprite.modulate = Color.DARK_RED
			speed = 200.0
			max_health = 40.0
		EnemyType.RAT_BOSS:
			sprite.modulate = Color.PURPLE
			sprite.scale = Vector2(2, 2)
			speed = 100.0
			max_health = 200.0
	
	current_health = max_health

func _physics_process(delta: float) -> void:
	# Si on n'a pas de référence au joueur, le chercher
	if player_ref == null or not is_instance_valid(player_ref):
		find_player()
	
	# Poursuivre le joueur
	if player_ref and is_instance_valid(player_ref):
		chase_player()
	
	# Déplacer l'ennemi
	move_and_slide()
	
	# Vérifier collision avec le joueur
	check_player_collision()
	
	# Empêcher de sortir de la map
	clamp_to_map_bounds()

func chase_player() -> void:
	# Calculer la direction vers le joueur
	var direction = (player_ref.global_position - global_position).normalized()
	
	# Appliquer la vitesse
	velocity = direction * speed

func check_player_collision() -> void:
	# Vérifier si on touche le joueur
	for i in get_slide_collision_count():
		var collision_info = get_slide_collision(i)
		var collider = collision_info.get_collider()
		
		if collider and collider.is_in_group("player"):
			# Infliger des dégâts au joueur (avec cooldown)
			var current_time = Time.get_ticks_msec() / 1000.0
			if current_time - last_contact_damage_time >= contact_damage_cooldown:
				if collider.has_method("take_damage"):
					collider.take_damage(damage)
					last_contact_damage_time = current_time
					print("Rat dealt ", damage, " damage to player")

func take_damage(amount: float) -> void:
	current_health -= amount
	print("Enemy took ", amount, " damage. HP: ", current_health, "/", max_health)
	
	# Flash rouge quand touché (feedback visuel simple)
	sprite.modulate = Color.WHITE
	await get_tree().create_timer(0.1).timeout
	set_sprite_color()
	
	if current_health <= 0:
		die()

func die() -> void:
	print("Enemy died!")
	
	# Notifier le WaveManager du kill
	if GameManager.current_run:
		GameManager.current_run.stats_run["kills"] = GameManager.current_run.stats_run.get("kills", 0) + 1
	
	queue_free()

func clamp_to_map_bounds() -> void:
	if not GameManager.is_within_bounds(global_position):
		global_position = GameManager.clamp_to_bounds(global_position)

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
@export var attack_rate: float = 1.0
@export var knockback_force: float = 200.0  # ← NOUVEAU
@export var stun_duration: float = 0.3  # ← NOUVEAU (temps de stun en secondes)

var current_health: float
var player_ref: CharacterBody2D = null
var last_attack_time: float = 0.0
var is_stunned: bool = false  # ← NOUVEAU

# Références
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var attack_area: Area2D = $AttackArea

func _ready() -> void:
	current_health = max_health
	add_to_group("enemies")
	find_player()
	set_sprite_color()
	print("Enemy spawned: ", EnemyType.keys()[enemy_type], " HP:", current_health)

func find_player() -> void:
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
			damage = 10.0
			attack_rate = 1.0
			knockback_force = 200.0
			stun_duration = 0.3
		EnemyType.RAT_MUTANT:
			sprite.modulate = Color.DARK_RED
			speed = 200.0
			max_health = 40.0
			damage = 15.0
			attack_rate = 0.8
			knockback_force = 150.0  # Plus lourd, moins de knockback
			stun_duration = 0.2  # Récupère plus vite
		EnemyType.RAT_BOSS:
			sprite.modulate = Color.PURPLE
			sprite.scale = Vector2(2, 2)
			speed = 100.0
			max_health = 200.0
			damage = 25.0
			attack_rate = 0.5
			knockback_force = 50.0  # Très lourd, presque pas de knockback
			stun_duration = 0.1  # Récupère très vite
	
	current_health = max_health

func _physics_process(delta: float) -> void:
	if player_ref == null or not is_instance_valid(player_ref):
		find_player()
	
	# Si stunné, ne pas poursuivre le joueur
	if not is_stunned:
		if player_ref and is_instance_valid(player_ref):
			chase_player()
	
	# Toujours déplacer (pour appliquer le knockback)
	move_and_slide()
	
	clamp_to_map_bounds()
	check_despawn_distance()

func _process(delta: float) -> void:
	# Ne pas attaquer si stunné
	if not is_stunned:
		attack_player()

func chase_player() -> void:
	var direction = (player_ref.global_position - global_position).normalized()
	velocity = direction * speed

func attack_player() -> void:
	if not player_ref or not is_instance_valid(player_ref):
		return
	
	if not attack_area:
		return
	
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_attack_time < attack_rate:
		return
	
	var bodies_in_range = attack_area.get_overlapping_bodies()
	
	for body in bodies_in_range:
		if body.is_in_group("player"):
			if body.has_method("take_damage"):
				body.take_damage(damage)
				last_attack_time = current_time
				print(EnemyType.keys()[enemy_type], " attacked player for ", damage, " damage")
				flash_attack()
				break

func flash_attack() -> void:
	sprite.modulate = Color.WHITE
	await get_tree().create_timer(0.1).timeout
	set_sprite_color()

# ============================================
# KNOCKBACK ET DAMAGE
# ============================================
func take_damage(amount: float) -> void:
	current_health -= amount
	print("Enemy took ", amount, " damage. HP: ", current_health, "/", max_health)
	
	# Appliquer le knockback
	apply_knockback()
	
	# Stun l'ennemi (sans await bloquant)
	start_stun()
	
	# Flash visuel (sans bloquer)
	start_damage_flash()
	
	# Vérifier la mort APRÈS les effets
	if current_health <= 0:
		die()

func apply_knockback() -> void:
	if not player_ref or not is_instance_valid(player_ref):
		return
	
	# Calculer la direction opposée au joueur
	var knockback_direction = (global_position - player_ref.global_position).normalized()
	
	# Appliquer la force de knockback
	velocity = knockback_direction * knockback_force

func start_stun() -> void:
	if is_stunned:
		return  # Déjà stunné, ne pas reset le timer
	
	is_stunned = true
	print("Enemy stunned for ", stun_duration, "s")
	
	# Créer un timer pour le unstun
	get_tree().create_timer(stun_duration).timeout.connect(end_stun)

func end_stun() -> void:
	is_stunned = false

func start_damage_flash() -> void:
	# Sauvegarder la couleur actuelle
	var original_color = sprite.modulate
	
	# Flash blanc
	sprite.modulate = Color.WHITE
	
	# Restaurer après 0.1s
	get_tree().create_timer(0.1).timeout.connect(func():
		if is_instance_valid(self):
			sprite.modulate = original_color
	)

# ============================================
# AUTRES FONCTIONS
# ============================================
func die() -> void:
	print("Enemy died!")
	
	if GameManager.current_run:
		GameManager.current_run.stats_run["kills"] = GameManager.current_run.stats_run.get("kills", 0) + 1
	
	queue_free()

func clamp_to_map_bounds() -> void:
	if not GameManager.is_within_bounds(global_position):
		global_position = GameManager.clamp_to_bounds(global_position)

func check_despawn_distance() -> void:
	if not player_ref or not is_instance_valid(player_ref):
		return
	
	var distance = global_position.distance_to(player_ref.global_position)
	if distance > 1000:
		print("Enemy despawned (too far from player)")
		queue_free()

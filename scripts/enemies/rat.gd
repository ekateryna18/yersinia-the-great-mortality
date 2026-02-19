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

# Direction pour l'animation
var current_direction: Vector2 = Vector2.DOWN

# Bob walking effect (plus subtil que le player)
var walk_timer: float = 0.0
var walk_speed: float = 12.0  # Vitesse du balancement
var walk_bob_y: float = 3.0   # Balancement vertical (plus petit que player)
var walk_tilt: float = 0.05   # Inclinaison (plus subtile que player)

# Références
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var attack_area: Area2D = $AttackArea

func _ready() -> void:
	current_health = max_health
	add_to_group("enemies")
	find_player()
	set_stats_by_type()

	# Animation par défaut
	if animated_sprite:
		animated_sprite.play("idle_S")

	print("Enemy spawned: ", EnemyType.keys()[enemy_type], " HP:", current_health)

func find_player() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_ref = players[0]
		print("Enemy found player automatically")

func set_stats_by_type() -> void:
	match enemy_type:
		EnemyType.RAT_NORMAL:
			speed = 150.0
			max_health = 20.0
			damage = 10.0
			attack_rate = 1.0
			knockback_force = 200.0
			stun_duration = 0.3
		EnemyType.RAT_MUTANT:
			speed = 200.0
			max_health = 40.0
			damage = 15.0
			attack_rate = 0.8
			knockback_force = 150.0  # Plus lourd, moins de knockback
			stun_duration = 0.2  # Récupère plus vite
		EnemyType.RAT_BOSS:
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

	# Mettre à jour l'animation basée sur la vélocité
	update_animation(velocity if velocity.length() > 10 else Vector2.ZERO)

	# Effet de bobbing quand le rat marche
	animate_walking(velocity, delta)

	clamp_to_map_bounds()
	check_despawn_distance()

func _process(delta: float) -> void:
	# Ne pas attaquer si stunné
	if not is_stunned:
		attack_player()

func chase_player() -> void:
	var direction = (player_ref.global_position - global_position).normalized()
	current_direction = direction
	velocity = direction * speed

# ─══════════════════════════════════════════════════════════════════
# ─── ANIMATION SYSTEM (8 DIRECTIONS) ───
# ─══════════════════════════════════════════════════════════════════

func update_animation(movement: Vector2) -> void:
	if not animated_sprite:
		return

	# Nom de l'animation
	var animation_name: String = "idle_"

	# Direction à utiliser (mouvement actuel ou dernière direction connue)
	var direction_to_use = movement if movement.length() > 0.1 else current_direction

	# Calculer l'angle
	var angle = direction_to_use.angle()

	# ─── DÉTERMINER LA DIRECTION (8 AXES) ───
	# -PI à PI → 8 secteurs de 45° (PI/4)

	if angle >= -PI/8 and angle < PI/8:
		animation_name += "E"  # → Droite
	elif angle >= PI/8 and angle < 3*PI/8:
		animation_name += "SE"  # ↘ Bas-Droite
	elif angle >= 3*PI/8 and angle < 5*PI/8:
		animation_name += "S"  # ↓ Bas
	elif angle >= 5*PI/8 and angle < 7*PI/8:
		animation_name += "SW"  # ↙ Bas-Gauche
	elif angle >= 7*PI/8 or angle < -7*PI/8:
		animation_name += "W"  # ← Gauche
	elif angle >= -7*PI/8 and angle < -5*PI/8:
		animation_name += "NW"  # ↖ Haut-Gauche
	elif angle >= -5*PI/8 and angle < -3*PI/8:
		animation_name += "N"  # ↑ Haut
	elif angle >= -3*PI/8 and angle < -PI/8:
		animation_name += "NE"  # ↗ Haut-Droite

	# Jouer l'animation si elle existe
	if animated_sprite.sprite_frames.has_animation(animation_name):
		if animated_sprite.animation != animation_name:
			animated_sprite.play(animation_name)
	else:
		# Fallback sur idle_S si l'animation n'existe pas
		if animated_sprite.sprite_frames.has_animation("idle_S"):
			if animated_sprite.animation != "idle_S":
				animated_sprite.play("idle_S")

func animate_walking(movement: Vector2, delta: float) -> void:
	if not animated_sprite:
		return

	var is_moving = movement.length() > 10

	if is_moving:
		walk_timer += delta * walk_speed

		# ── BALANCEMENT VERTICAL (haut/bas) ── Plus subtil que le player
		var bob_offset = sin(walk_timer) * (walk_bob_y * 0.1)
		animated_sprite.offset.y = bob_offset

		# ── INCLINAISON (gauche/droite) ── Très subtile
		var tilt_angle = cos(walk_timer) * walk_tilt
		animated_sprite.rotation = tilt_angle

		# ── SQUASH & STRETCH ── Très léger pour les rats
		var base_scale = 0.1  # Ajuste selon ton scale de base
		var squash = base_scale * (1.0 + (sin(walk_timer * 2) * 0.03))  # 3% au lieu de 5%
		var stretch = base_scale * (1.0 - (sin(walk_timer * 2) * 0.03))
		animated_sprite.scale = Vector2(squash, stretch)

	else:
		# ── RETOUR À LA NORMALE ──
		animated_sprite.offset.y = lerp(animated_sprite.offset.y, 0.0, delta * 10.0)
		animated_sprite.rotation = lerp(animated_sprite.rotation, 0.0, delta * 10.0)

		# Retour au scale de base
		var base_scale = Vector2(0.1, 0.1)  # Ajuste selon ton scale de base
		animated_sprite.scale = lerp(animated_sprite.scale, base_scale, delta * 10.0)

		walk_timer = 0.0

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
	if animated_sprite:
		animated_sprite.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		if is_instance_valid(animated_sprite):
			animated_sprite.modulate = Color.WHITE

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
	if not animated_sprite:
		return

	# Flash blanc (plus visible que la couleur originale)
	animated_sprite.modulate = Color.WHITE * 2

	# Restaurer après 0.1s
	get_tree().create_timer(0.1).timeout.connect(func():
		if is_instance_valid(self) and animated_sprite:
			animated_sprite.modulate = Color.WHITE
	)

# ============================================
# AUTRES FONCTIONS
# ============================================
func die() -> void:
	print("Enemy died!")
	
	if GameManager.current_run:
		GameManager.current_run.stats_run["kills"] = GameManager.current_run.stats_run.get("kills", 0) + 1
	GameManager.register_enemy_kill(enemy_type)
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

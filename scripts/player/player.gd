extends CharacterBody2D

@export var speed: float = 400.0
@export var max_health: float = 100.0
@export var damage: float = 10.0
@export var armor: float = 0.0
@export var attack_cooldown: float = 0.5

var current_health: float
var is_frozen: bool = false
var last_attack_time: float = 0.0

var walk_timer: float = 0.0
var walk_speed: float = 15.0  # Plus élevé = plus rapide
var walk_bob_y: float = 5.0   # Balancement vertical (haut/bas)
var walk_tilt: float = 0.1    # Inclinaison (rotation légère)

# Direction actuelle (pour l'animation)
var current_direction: Vector2 = Vector2.DOWN
var last_direction: Vector2 = Vector2.DOWN

# Mobile controls
var joystick_input: Vector2 = Vector2.ZERO
var joystick: Node = null

#bob walking 
var bob_timer: float = 0.0
var bob_speed: float = 10.0  # Vitesse du balancement
var bob_amount: float = 2.0  # Amplitude du balancement

@onready var attack_area: Area2D = $AttackArea
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	current_health = max_health
	add_to_group("player")
	connect_to_joystick()
	
	# Animation par défaut
	if animated_sprite:
		animated_sprite.play("idle_S")
	
	print("Player ready - HP: %d/%d | Damage: %d" % [current_health, max_health, damage])

func connect_to_joystick() -> void:
	await get_tree().process_frame
	
	var hud = get_tree().root.get_node_or_null("Main/HUD")
	if hud and hud.has_node("MovementJoystick"):
		joystick = hud.get_node("MovementJoystick")
		
		if joystick.has_signal("analogic_changed"):
			joystick.analogic_changed.connect(_on_joystick_moved)
			print("✅ Virtual Joystick connected")
		else:
			print("⚠️ Signal analogic_changed not found")
	else:
		print("⚠️ Virtual Joystick not found")

func _on_joystick_moved(value: Vector2, distance: float, angle: float, angle_clockwise: float, angle_not_clockwise: float) -> void:
	joystick_input = value

func _physics_process(delta: float) -> void:
	if is_frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var input_vector := Vector2.ZERO
	
	# Input clavier
	var keyboard_input := Vector2.ZERO
	keyboard_input.x = Input.get_axis("ui_left", "ui_right")
	keyboard_input.y = Input.get_axis("ui_up", "ui_down")
	
	# Combiner inputs
	if joystick_input.length() > 0.1:
		input_vector = joystick_input
	else:
		input_vector = keyboard_input
	
	# Normaliser
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()
	
	# Mettre à jour la direction pour l'animation
	if input_vector.length() > 0.1:
		current_direction = input_vector
		last_direction = input_vector
	
	# Appliquer mouvement
	velocity = input_vector * speed
	move_and_slide()
	
	# Mettre à jour l'animation
	update_animation(input_vector)
	
		# Animation de bobbing si en mouvement
	#if velocity.length() > 10:
		#bob_timer += delta * bob_speed
		#animated_sprite.offset.y = sin(bob_timer) * bob_amount
	#else:
		## Reset progressif
		#animated_sprite.offset.y = lerp(animated_sprite.offset.y, 0.0, delta * 5.0)
		#bob_timer = 0.0
	animate_walking(input_vector, delta)
	
	
	# Limiter à la map
	if not GameManager.is_within_bounds(global_position):
		global_position = GameManager.clamp_to_bounds(global_position)
		
func animate_walking(movement: Vector2, delta: float) -> void:
	if not animated_sprite:
		return
	
	var is_moving = movement.length() > 0.1
	
	if is_moving:
		walk_timer += delta * walk_speed
		
		# ── BALANCEMENT VERTICAL (haut/bas) ──
		# Réduit proportionnellement au scale
		var bob_offset = sin(walk_timer) * (walk_bob_y * 0.1)  # ← Multiplié par 0.1
		animated_sprite.offset.y = bob_offset
		
		# ── INCLINAISON (gauche/droite) ──
		var tilt_angle = cos(walk_timer) * walk_tilt
		animated_sprite.rotation = tilt_angle
		
		# ── SQUASH & STRETCH ──
		# Applique sur le scale de BASE (0.1)
		var base_scale = 0.1  # ← TON SCALE DE BASE
		var squash = base_scale * (1.0 + (sin(walk_timer * 2) * 0.05))
		var stretch = base_scale * (1.0 - (sin(walk_timer * 2) * 0.05))
		animated_sprite.scale = Vector2(squash, stretch)
		
	else:
		# ── RETOUR À LA NORMALE ──
		animated_sprite.offset.y = lerp(animated_sprite.offset.y, 0.0, delta * 10.0)
		animated_sprite.rotation = lerp(animated_sprite.rotation, 0.0, delta * 10.0)
		
		# Retour au scale de base (0.1)
		var base_scale = Vector2(0.1, 0.1)  # ← TON SCALE DE BASE
		animated_sprite.scale = lerp(animated_sprite.scale, base_scale, delta * 10.0)
		
		walk_timer = 0.0
		
func update_animation(movement: Vector2) -> void:
	if not animated_sprite:
		return
	
	# Déterminer l'animation selon la direction
	var animation_name: String = "idle_"
	
	# Si le joueur bouge
	if movement.length() > 0.1:
		# Déterminer la direction (8 directions)
		var angle = movement.angle()
		
		# Convertir l'angle en direction (8 directions)
		# -PI à PI → 8 secteurs de 45° (PI/4)
		if angle >= -PI/8 and angle < PI/8:
			animation_name += "E"  # Droite
		elif angle >= PI/8 and angle < 3*PI/8:
			animation_name += "SE"  # Bas-Droite
		elif angle >= 3*PI/8 and angle < 5*PI/8:
			animation_name += "S"  # Bas
		elif angle >= 5*PI/8 and angle < 7*PI/8:
			animation_name += "SW"  # Bas-Gauche
		elif angle >= 7*PI/8 or angle < -7*PI/8:
			animation_name += "W"  # Gauche
		elif angle >= -7*PI/8 and angle < -5*PI/8:
			animation_name += "NW"  # Haut-Gauche
		elif angle >= -5*PI/8 and angle < -3*PI/8:
			animation_name += "N"  # Haut
		elif angle >= -3*PI/8 and angle < -PI/8:
			animation_name += "NE"  # Haut-Droite
	else:
		# Idle: utiliser la dernière direction
		var angle = last_direction.angle()
		
		if angle >= -PI/8 and angle < PI/8:
			animation_name += "E"
		elif angle >= PI/8 and angle < 3*PI/8:
			animation_name += "SE"
		elif angle >= 3*PI/8 and angle < 5*PI/8:
			animation_name += "S"
		elif angle >= 5*PI/8 and angle < 7*PI/8:
			animation_name += "SW"
		elif angle >= 7*PI/8 or angle < -7*PI/8:
			animation_name += "W"
		elif angle >= -7*PI/8 and angle < -5*PI/8:
			animation_name += "NW"
		elif angle >= -5*PI/8 and angle < -3*PI/8:
			animation_name += "N"
		elif angle >= -3*PI/8 and angle < -PI/8:
			animation_name += "NE"
	
	# Jouer l'animation si elle existe
	if animated_sprite.sprite_frames.has_animation(animation_name):
		if animated_sprite.animation != animation_name:
			animated_sprite.play(animation_name)
	else:
		print("⚠️ Animation not found: ", animation_name)

func _process(delta: float) -> void:
	auto_attack()

func auto_attack() -> void:
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_attack_time < attack_cooldown:
		return
	
	if not GameManager.is_night():
		return
	
	if not attack_area:
		return
	
	var enemies_in_range = attack_area.get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		for enemy in enemies_in_range:
			if enemy.is_in_group("enemies"):
				if enemy.has_method("take_damage"):
					enemy.take_damage(damage)
					last_attack_time = current_time
					flash_attack()
					break

func flash_attack() -> void:
	if animated_sprite:
		animated_sprite.modulate = Color.YELLOW
		await get_tree().create_timer(0.1).timeout
		if is_instance_valid(animated_sprite):
			animated_sprite.modulate = Color.WHITE

func freeze() -> void:
	is_frozen = true

func unfreeze() -> void:
	is_frozen = false

func take_damage(amount: float) -> void:
	var actual_damage = max(0, amount - armor)
	current_health -= actual_damage
	
	if current_health <= 0:
		die()

func heal(amount: float) -> void:
	current_health = min(max_health, current_health + amount)

func die() -> void:
	set_physics_process(false)
	set_process(false)
	set_process_input(false)
	visible = false
	GameManager.on_player_death()

func get_health_percent() -> float:
	return current_health / max_health

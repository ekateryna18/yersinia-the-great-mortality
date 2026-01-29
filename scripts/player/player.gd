extends CharacterBody2D

@export var speed: float = 300.0
@export var max_health: float = 100.0
@export var damage: float = 10.0
@export var armor: float = 0.0
@export var attack_cooldown: float = 0.5

var current_health: float
var is_frozen: bool = false
var last_attack_time: float = 0.0

# Mobile controls
var joystick_input: Vector2 = Vector2.ZERO
var joystick: Node = null

@onready var attack_area: Area2D = $AttackArea

func _ready() -> void:
	current_health = max_health
	add_to_group("player")
	connect_to_joystick()
	print("Player ready - HP: %d/%d | Damage: %d" % [current_health, max_health, damage])

func connect_to_joystick() -> void:
	await get_tree().process_frame
	
	var hud = get_tree().root.get_node_or_null("Main/HUD")
	if hud and hud.has_node("MovementJoystick"):
		joystick = hud.get_node("MovementJoystick")
		
		# ✅ Connecter au signal analogic_changed
		if joystick.has_signal("analogic_changed"):
			joystick.analogic_changed.connect(_on_joystick_moved)
			print("✅ Virtual Joystick connected (analogic_changed)")
		else:
			print("⚠️ Signal analogic_changed not found")
	else:
		print("⚠️ Virtual Joystick not found")

# Callback du joystick
func _on_joystick_moved(value: Vector2, distance: float, angle: float, angle_clockwise: float, angle_not_clockwise: float) -> void:
	# value est la direction du joystick (Vector2 normalisé)
	joystick_input = value

func _physics_process(delta: float) -> void:
	if is_frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var input_vector := Vector2.ZERO
	
	# Input clavier (pour tester sur PC)
	var keyboard_input := Vector2.ZERO
	keyboard_input.x = Input.get_axis("ui_left", "ui_right")
	keyboard_input.y = Input.get_axis("ui_up", "ui_down")
	
	# Combiner inputs (joystick prioritaire si actif)
	if joystick_input.length() > 0.1:
		input_vector = joystick_input
	else:
		input_vector = keyboard_input
	
	# Normaliser
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()
	
	# Appliquer mouvement
	velocity = input_vector * speed
	move_and_slide()
	
	# Limiter à la map
	if not GameManager.is_within_bounds(global_position):
		global_position = GameManager.clamp_to_bounds(global_position)

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
	if has_node("Sprite2D"):
		var sprite = get_node("Sprite2D")
		sprite.modulate = Color.YELLOW
		await get_tree().create_timer(0.1).timeout
		if is_instance_valid(sprite):
			sprite.modulate = Color.WHITE
	
	if has_node("AttackEffect"):
		var effect = get_node("AttackEffect")
		effect.visible = true
		await get_tree().create_timer(0.15).timeout
		if is_instance_valid(effect):
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
	set_physics_process(false)
	set_process(false)
	set_process_input(false)
	visible = false
	GameManager.on_player_death()

func get_health_percent() -> float:
	return current_health / max_health

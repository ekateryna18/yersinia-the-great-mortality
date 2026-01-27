# player_controller.gd
# Player movement and state management

extends CharacterBody2D

const SPEED = 150.0  # Pixels per second
const ATTACK_RANGE = 50.0

var current_hp: int = 100
var max_hp: int = 100

# Input tracking
var input_vector: Vector2 = Vector2.ZERO

func _ready():
	"""Initialize player"""
	
	# Store initial position as run state
	Game_Manager.run_state.player_position = global_position
	
	# Debug output
	print("[PLAYER] Spawned at position: %s" % global_position)
	print("[PLAYER] HP: %d/%d" % [current_hp, max_hp])

func _physics_process(delta):
	"""Handle movement each frame"""
	# Get input (mobile joystick or keyboard)
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Calculate velocity
	velocity = input_vector.normalized() * SPEED
	
	# Apply physics movement
	move_and_slide()
	
	# Update run state position
	Game_Manager.run_state.player_position = global_position

func take_damage(damage: int):
	"""Player takes damage"""
	current_hp -= damage
	print("[PLAYER] Damage taken: %d (HP: %d/%d)" % [damage, current_hp, max_hp])
	
	# Visual feedback (to add in GDD-004)
	
	# Check death
	if current_hp <= 0:
		die()

func die():
	"""Player dies"""
	print("[PLAYER] DEAD!")
	Game_Manager.run_state.player_dies()
	# Trigger Game Over screen (to implement in GDD-004)
	# visible = false

func heal(amount: int):
	"""Player heals"""
	current_hp = min(current_hp + amount, max_hp)
	print("[PLAYER] Healed: %d (HP: %d/%d)" % [amount, current_hp, max_hp])

func get_position_for_attack() -> Vector2:
	"""Get player center position for attack zone calculation"""
	return global_position

func get_debug_info() -> String:
	"""Debug info"""
	return "[PLAYER] HP: %d/%d | Pos: %s" % [current_hp, max_hp, global_position]

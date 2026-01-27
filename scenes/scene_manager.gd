# scenes/scene_manager.gd
# GDD-001: Simple scene setup - Main scene + Player only
# Everything else will be added later

extends Node2D

var player: CharacterBody2D

func _ready() -> void:
	"""Initialize basic game scene"""
	print("===== SCENE MANAGER _ready() CALLED =====")
	print("[SCENE] GDD-001 - Initializing...")
	print("[SCENE] Scene tree root: %s" % get_tree().root)
	print("[SCENE] Current node: %s" % name)
	
	# Create main scene structure
	create_main_scene()
	
	print("[SCENE] Initialization complete")
	print("===== SCENE MANAGER _ready() FINISHED =====")

func create_main_scene() -> void:
	"""Create main gameplay area"""
	print("[SCENE] Creating main scene...")
	
	# Create background
	var background = ColorRect.new()
	background.name = "Background"
	background.color = Color(0.15, 0.25, 0.1, 1)
	background.anchor_left = 0.0
	background.anchor_top = 0.0
	background.anchor_right = 1.0
	background.anchor_bottom = 1.0
	add_child(background)
	print("[SCENE] Background added")
	
	# Create player
	player = CharacterBody2D.new()
	player.name = "Player"
	player.position = Vector2(640, 360)
	print("[SCENE] Player node created at %s" % player.position)
	
	# Add collision shape
	var collision = CollisionShape2D.new()
	var capsule = CapsuleShape2D.new()
	capsule.radius = 8.0
	capsule.height = 24.0
	collision.shape = capsule
	player.add_child(collision)
	print("[SCENE] Collision added to player")
	
	# Add sprite (blue placeholder)
	var sprite = Sprite2D.new()
	sprite.modulate = Color(0.2, 0.8, 1, 1)
	sprite.scale = Vector2(2, 2)
	player.add_child(sprite)
	print("[SCENE] Sprite added to player")
	
	# Add script to player
	var script = load("res://systems/player_controller.gd")
	if script:
		player.set_script(script)
		print("[SCENE] Script loaded and attached")
	else:
		print("[SCENE] ERROR: Could not load player_controller.gd")
	
	add_child(player)
	print("[SCENE] Player added to scene")
	print("[SCENE] Player final position: %s" % player.position)
	print("[SCENE] Main scene created")


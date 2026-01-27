extends Node2D

func _ready() -> void:
	print("[SCENE] Initializing...")
	
	# Background
	var bg = ColorRect.new()
	bg.color = Color(0.15, 0.25, 0.1, 1)
	bg.anchor_left = 0
	bg.anchor_top = 0
	bg.anchor_right = 1
	bg.anchor_bottom = 1
	add_child(bg)
	print("[SCENE] Background created")
	
	# Player - no scripts, just visual
	var player = CharacterBody2D.new()
	player.name = "Player"
	player.position = Vector2(640, 360)
	
	var col = CollisionShape2D.new()
	var shape = CapsuleShape2D.new()
	shape.radius = 8
	shape.height = 24
	col.shape = shape
	player.add_child(col)
	
	var spr = Sprite2D.new()
	spr.modulate = Color.CYAN
	spr.scale = Vector2(2, 2)
	player.add_child(spr)
	
	add_child(player)
	print("[SCENE] Player created at (640, 360)")
	print("[SCENE] Ready!")

func _physics_process(delta: float) -> void:
	# Simple movement on the player
	var player = get_node("Player")
	if player:
		var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		player.velocity = input_vector.normalized() * 150.0
		player.move_and_slide()

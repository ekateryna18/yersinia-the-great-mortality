extends Area2D

## Signal émis quand le bouton est pressé
signal button_pressed

## Texte du bouton
@export var button_text: String = "Interact"

## Le bouton doit-il être visible sur la map?
@export var show_marker: bool = true

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var ui_button: Button = $StartNightButton

var player_in_range: bool = false
var player_ref: CharacterBody2D = null

func _ready() -> void:
	# Connecter les signaux de détection
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Créer le bouton UI
	#create_ui_button()
	
	
	print("Interactive Button ready at: ", global_position)

func create_ui_button() -> void:
	# Créer un bouton dans le HUD
	var hud = get_tree().root.get_node_or_null("Main/HUD")
	if not hud:
		print("⚠️ HUD not found!")
		return
	
	# Créer le bouton
	ui_button = Button.new()
	ui_button.text = button_text
	ui_button.custom_minimum_size = Vector2(120, 50)
	
	# Style du bouton
	ui_button.add_theme_font_size_override("font_size", 18)
	
	# Positionner au centre bas (ou ajuster selon besoin)
	ui_button.position = Vector2(
		get_viewport().size.x / 2 - 60,  # Centré horizontalement
		get_viewport().size.y - 100       # 100px du bas
	)
	
	# Cacher par défaut
	ui_button.visible = false
	
	# Connecter le signal pressed
	ui_button.pressed.connect(_on_ui_button_pressed)
	
	# Ajouter au HUD
	hud.add_child(ui_button)
	
	print("UI Button created")

func _process(_delta: float) -> void:
	# Mettre à jour la visibilité du bouton
	if ui_button:
		ui_button.visible = player_in_range

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player_ref = body
		print("Player entered button zone")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		player_ref = null
		print("Player exited button zone")

func _on_ui_button_pressed() -> void:
	print("Interactive button pressed!")
	button_pressed.emit()

func _exit_tree() -> void:
	# Nettoyer le bouton UI quand la scène est détruite
	if ui_button and is_instance_valid(ui_button):
		ui_button.queue_free()

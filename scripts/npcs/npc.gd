extends Area2D

enum NPCType {
	MERCHANT,
	BLACKSMITH,
	WIZARD,
	SICK,
	GENERIC_1,
	GENERIC_2,
	GENERIC_3
}

const NPC_SPRITES = {
	#NPCType.MERCHANT: "res://assets/sprites/npcs/merchant.png",
	NPCType.BLACKSMITH: "res://assets/sprites/npcs/blacksmith.png",
	NPCType.WIZARD: "res://assets/sprites/npcs/wizard.png",
	#NPCType.SICK: "res://assets/sprites/npcs/sick.png",
	#NPCType.GENERIC_1: "res://assets/sprites/npcs/villager.png",
	#NPCType.GENERIC_2: "res://assets/sprites/npcs/villager.png",
	#NPCType.GENERIC_3: "res://assets/sprites/npcs/villager.png",
}

@export var npc_type: NPCType = NPCType.MERCHANT
@export var npc_name: String = "PNJ"
@export var is_traitor: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var talk_button: Button = $TalkButton
@onready var interact_area: Area2D = $InteractArea

var player_in_range: bool = false
var player_ref: CharacterBody2D = null
var dialogue_data: Dictionary = {}

func _ready() -> void:
	label.text = npc_name
	if interact_area:
		interact_area.body_entered.connect(_on_interact_area_entered)
		interact_area.body_exited.connect(_on_interact_area_exited)
	
	load_sprite()
	load_dialogue_data()
	
	if talk_button:
		talk_button.visible = false
		talk_button.pressed.connect(_on_talk_button_pressed)
	
	print("NPC ready: ", npc_name, " (Type: ", NPCType.keys()[npc_type], ")")

func load_dialogue_data() -> void:
	# Charger le dialogue depuis le dictionnaire
	var NPCDialogues = preload("res://scripts/npcs/npc_dialogues.gd")
	
	var type_string = NPCType.keys()[npc_type]
	if type_string.begins_with("GENERIC"):
		type_string = "GENERIC"
	
	dialogue_data = NPCDialogues.get_dialogue(type_string)

func _on_interact_area_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player_ref = body
		print(npc_name, " - Joueur entre dans la zone d'interaction")

func _on_interact_area_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		player_ref = null
		print(npc_name, " - Joueur sort de la zone d'interaction")

func set_fallback_color() -> void:
	match npc_type:
		NPCType.MERCHANT:
			sprite.modulate = Color.YELLOW
		NPCType.BLACKSMITH:
			sprite.modulate = Color.ORANGE
		NPCType.WIZARD:
			sprite.modulate = Color.PURPLE
		NPCType.SICK:
			sprite.modulate = Color.GREEN
		_:
			sprite.modulate = Color.CYAN

func _process(_delta: float) -> void:
	# Afficher le bouton si joueur à portée ET en jour
	if talk_button:
		talk_button.visible = player_in_range and GameManager.is_day()
	
func _on_talk_button_pressed() -> void:
	# Ouvrir le dialogue via le DialogLayer dans le HUD
	var hud = get_tree().root.get_node_or_null("Main/HUD")
	if hud and hud.has_node("DialogLayer"):
		var dialog_layer = hud.get_node("DialogLayer")
		dialog_layer.open_dialogue(dialogue_data, self)

func interact() -> void:
	print("=== INTERACTION avec ", npc_name, " ===")
	_on_talk_button_pressed()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player_ref = body
		print(npc_name, " - Joueur à portée")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		player_ref = null
		print(npc_name, " - Joueur hors de portée")

func load_sprite() -> void:
	if NPC_SPRITES.has(npc_type):
		var sprite_path = NPC_SPRITES[npc_type]
		
		if ResourceLoader.exists(sprite_path):
			var texture = load(sprite_path)
			sprite.texture = texture
			
			# Échelle selon le type
			match npc_type:
				NPCType.MERCHANT:
					sprite.scale = Vector2(0.6, 0.6)  # Si 144x233
				NPCType.BLACKSMITH:
					sprite.scale = Vector2(0.7, 0.7)  # Si plus petit
				NPCType.WIZARD:
					sprite.scale = Vector2(0.6, 0.6)  # Si plus grand
				_:
					sprite.scale = Vector2(0.5, 0.5)  # Par défaut
			
			print("Sprite loaded: ", sprite_path)
		else:
			print("⚠️ Sprite not found: ", sprite_path)
			set_fallback_color()
	else:
		set_fallback_color()

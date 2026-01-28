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

@export var npc_type: NPCType = NPCType.MERCHANT
@export var npc_name: String = "PNJ"
@export var is_traitor: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interaction_icon: Sprite2D = $InteractionIcon  # ← NOUVEAU

var player_in_range: bool = false
var player_ref: CharacterBody2D = null

func _ready() -> void:
	label.text = npc_name
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	set_sprite_color()
	
	# Cacher l'icône au début
	if interaction_icon:
		interaction_icon.visible = false
	
	print("NPC ready: ", npc_name, " (Type: ", NPCType.keys()[npc_type], ")")

func set_sprite_color() -> void:
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
	# Afficher l'icône si joueur à portée ET en jour
	if interaction_icon:
		interaction_icon.visible = player_in_range and GameManager.is_day()

func _input(event: InputEvent) -> void:
	# Interaction uniquement en JOUR
	if player_in_range and GameManager.is_day() and event.is_action_pressed("ui_accept"):
		interact()

func interact() -> void:
	print("=== INTERACTION avec ", npc_name, " ===")
	print("Type: ", NPCType.keys()[npc_type])
	print("Est traître: ", is_traitor)
	
	# TODO: Ouvrir dialogue UI (sera fait par ton collègue)

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

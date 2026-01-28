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

# Dictionnaire des sprites par type
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
@onready var interaction_icon: Sprite2D = $InteractionIcon

var player_in_range: bool = false
var player_ref: CharacterBody2D = null

func _ready() -> void:
	label.text = npc_name
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Charger le sprite selon le type
	load_sprite()
	
	if interaction_icon:
		interaction_icon.visible = false
	
	print("NPC ready: ", npc_name, " (Type: ", NPCType.keys()[npc_type], ")")

func load_sprite() -> void:
	if NPC_SPRITES.has(npc_type):
		var sprite_path = NPC_SPRITES[npc_type]
		
		if ResourceLoader.exists(sprite_path):
			var texture = load(sprite_path)
			sprite.texture = texture
			
			# Échelle selon le type
			match npc_type:
				NPCType.MERCHANT:
					sprite.scale = Vector2(0.4, 0.4)  # Si 144x233
				NPCType.BLACKSMITH:
					sprite.scale = Vector2(0.5, 0.5)  # Si plus petit
				NPCType.WIZARD:
					sprite.scale = Vector2(0.4, 0.4)  # Si plus grand
				_:
					sprite.scale = Vector2(0.2, 0.2)  # Par défaut
			
			print("Sprite loaded: ", sprite_path)
		else:
			print("⚠️ Sprite not found: ", sprite_path)
			set_fallback_color()
	else:
		set_fallback_color()

func set_fallback_color() -> void:
	# Couleurs de fallback si pas de sprite
	match npc_type:
		#NPCType.MERCHANT:
			#sprite.modulate = Color.YELLOW
		NPCType.BLACKSMITH:
			sprite.modulate = Color.ORANGE
		NPCType.WIZARD:
			sprite.modulate = Color.PURPLE
		#NPCType.SICK:
			#sprite.modulate = Color.GREEN
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
		

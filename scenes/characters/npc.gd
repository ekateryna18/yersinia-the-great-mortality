extends BaseCharacter
## PNJ de base - Non-combattants (Marchand, Forgeron, Magicien, etc.)

class_name NPC

# ========================
# PNJ CONFIG
# ========================
enum NPCType { MERCHANT, BLACKSMITH, WIZARD, GENERIC, SICK, MOUSE_HELPER }

@export var npc_type: NPCType = NPCType.MERCHANT
@export var npc_name: String = "Unknown"
@export var dialogue_key: String = ""  # Clé pour les dialogues (localization)

# ========================
# TRAITOR SYSTEM
# ========================
var is_traitor: bool = false
var is_defeated: bool = false
var is_sick: bool = false

# ========================
# SERVICES PNJ
# ========================
var current_price_modifier: float = 1.0  # Multiplicateur de prix
var has_been_attacked_innocently: bool = false

# ========================
# COMMERCE
# ========================
var inventory: Array[String] = []
var available_upgrades: Array[Dictionary] = []

# ========================
# RIDDLES (Énigmes traître)
# ========================
var riddle_question: String = ""
var riddle_answer: String = ""
var riddle_attempts: int = 0

# ========================
# STATE
# ========================
var interaction_range: float = 60.0
var is_player_nearby: bool = false

# ========================
# LIFECYCLE
# ========================
func _ready() -> void:
	super._ready()
	
	# PNJ ne sont pas combattants par défaut
	base_hp = 50  # Peu de vie
	base_damage = 0  # Pas de dégâts
	reset_stats()
	
	# Initialiser les services basés sur le type
	_initialize_npc_type()
	
	add_to_group("pnj")

func _initialize_npc_type() -> void:
	"""Initialiser les propriétés basées sur le type PNJ"""
	match npc_type:
		NPCType.MERCHANT:
			npc_name = "Merchant"
			dialogue_key = "npc_merchant"
			_setup_merchant()
		
		NPCType.BLACKSMITH:
			npc_name = "Blacksmith"
			dialogue_key = "npc_blacksmith"
			_setup_blacksmith()
		
		NPCType.WIZARD:
			npc_name = "Wizard / Magician"
			dialogue_key = "npc_wizard"
			_setup_wizard()
		
		NPCType.SICK:
			npc_name = "Sick NPC"
			dialogue_key = "npc_sick"
			is_sick = true
			_setup_sick()
		
		NPCType.GENERIC:
			npc_name = "Wanderer"
			dialogue_key = "npc_generic"
		
		NPCType.MOUSE_HELPER:
			npc_name = "White Mouse"
			dialogue_key = "npc_mouse"
			_setup_mouse()

# ========================
# PNJ SETUP FUNCTIONS
# ========================
func _setup_merchant() -> void:
	"""Marchand : Vend potions et consommables"""
	inventory = [
		"potion_health",      # Soin
		"potion_speed",       # Vitesse +20%
		"potion_strength",    # Force +20%
		"potion_knockback"    # Knockback +30%
	]
	
	available_upgrades = [
		{"item": "potion_health", "cost": 50, "effect": {"heal": 30}},
		{"item": "potion_speed", "cost": 60, "effect": {"speed_boost": 0.2}},
		{"item": "potion_strength", "cost": 75, "effect": {"damage_boost": 0.2}},
		{"item": "potion_knockback", "cost": 50, "effect": {"knockback_boost": 0.3}}
	]

func _setup_blacksmith() -> void:
	"""Forgeron : Améliore dégâts et armure"""
	available_upgrades = [
		{"upgrade": "scythe_damage", "cost": 80, "level": 1, "effect": {"damage": 5}},
		{"upgrade": "scythe_damage", "cost": 160, "level": 2, "effect": {"damage": 10}},
		{"upgrade": "scythe_knockback", "cost": 70, "level": 1, "effect": {"knockback": 20}},
		{"upgrade": "scythe_knockback", "cost": 140, "level": 2, "effect": {"knockback": 40}}
	]

func _setup_wizard() -> void:
	"""Magicien : Améliore stats permanentes avec bons/mauvais points"""
	available_upgrades = [
		{"stat": "hp", "cost_good": 30, "cost_bad": 20, "effect": 5},
		{"stat": "damage", "cost_good": 35, "cost_bad": 25, "effect": 3},
		{"stat": "speed", "cost_good": 40, "cost_bad": 30, "effect": 0.05},
		{"stat": "crit", "cost_good": 50, "cost_bad": 35, "effect": 0.05},
	]

func _setup_sick() -> void:
	"""PNJ malade : Peut être soigné pour bonus spécial"""
	base_hp = 20  # Très peu de vie
	current_hp = 20
	
	available_upgrades = [
		{"action": "heal_sick", "effect": {"glory": 100, "all_prices": -0.1}}
	]

func _setup_mouse() -> void:
	"""Souris blanche : Aide à récupérer des coffres"""
	base_hp = 5
	current_hp = 5
	
	available_upgrades = [
		{"action": "follow", "effect": {"treasure_finder": true}}
	]

# ========================
# INTERACTION
# ========================
func interact_with_player(player: Player) -> void:
	"""Interaction avec le joueur"""
	if is_defeated or has_been_attacked_innocently:
		return
	
	# Ouvrir le dialogue
	_show_dialogue(player)

func _show_dialogue(player: Player) -> void:
	"""Afficher le dialogue du PNJ"""
	# TODO: Intégrer avec le système de dialogue (gestion par le no-codeur)
	print(f"[{npc_name}] Dialogue: {dialogue_key}")

# ========================
# TRAITOR SYSTEM
# ========================
func set_as_traitor() -> void:
	"""Marquer ce PNJ comme traître"""
	is_traitor = true
	_generate_traitor_riddle()

func _generate_traitor_riddle() -> void:
	"""Générer une énigme pour le traître"""
	# TODO: Intégrer avec le système d'énigmes
	riddle_question = "What is my secret?"
	riddle_answer = "traitor"

func answer_riddle(answer: String) -> bool:
	"""Répondre à une énigme"""
	riddle_attempts += 1
	
	if answer.to_lower() == riddle_answer.to_lower():
		return true  # Bonne réponse
	else:
		return false  # Mauvaise réponse

func reveal_traitors() -> Array[String]:
	"""Révéler les traîtres (pour les énigmes)"""
	if is_traitor:
		# Si c'est un traître : retourner 2 noms aléatoires
		return ["Unknown", "Stranger"]
	else:
		# Si c'est honnête : retourner les vrais traîtres
		# TODO: Obtenir depuis GameManager
		return []

# ========================
# COMBAT (Si attaqué)
# ========================
func take_damage(damage: int) -> void:
	"""Être attaqué"""
	if is_defeated:
		return
	
	super.take_damage(damage)
	
	# Si le joueur attaque un PNJ innocent
	if not is_traitor:
		has_been_attacked_innocently = true
		# Effets: Perte de service, prix augmente pour autres PNJ
		on_innocently_attacked()

func on_innocently_attacked() -> void:
	"""Conséquences d'une attaque innocente"""
	current_price_modifier += 0.2  # Prix +20%
	
	# Notifier le GameManager
	# TODO: get_tree().call_group("game_manager", "on_innocent_pnj_attacked", self)

func die() -> void:
	"""Mourir"""
	super.die()
	is_defeated = true
	
	if is_traitor:
		# Traître vaincu = ne pas spawn en Nuit 5
		# TODO: Notifier GameManager
		pass
	else:
		# PNJ innocent tué = perte de services
		on_innocently_attacked()

# ========================
# HEALING (Pour PNJ malade)
# ========================
func heal_sick() -> void:
	"""Soigner le PNJ malade"""
	if not is_sick:
		return
	
	is_sick = false
	current_hp = base_hp
	
	# Bonus au joueur
	# TODO: Bonus spécial (glory + price reduction)

# ========================
# PRICING
# ========================
func get_item_price(item: String) -> int:
	"""Obtenir le prix d'un item"""
	var base_price = 50  # Prix de base
	return int(base_price * current_price_modifier)

func get_upgrade_cost(upgrade_index: int) -> int:
	"""Obtenir le coût d'une amélioration"""
	if upgrade_index < available_upgrades.size():
		var cost = available_upgrades[upgrade_index].get("cost", 50)
		return int(cost * current_price_modifier)
	return 999

# ========================
# HELPERS
# ========================
func is_available() -> bool:
	"""Est-ce que ce PNJ est disponible pour interaction?"""
	return not is_defeated and not has_been_attacked_innocently

func get_service_description() -> String:
	"""Description du service du PNJ"""
	match npc_type:
		NPCType.MERCHANT:
			return "Sells potions and consumables"
		NPCType.BLACKSMITH:
			return "Upgrades scythe damage and knockback"
		NPCType.WIZARD:
			return "Upgrades permanent stats with glory"
		NPCType.SICK:
			return "Needs healing for special bonus"
		NPCType.MOUSE_HELPER:
			return "Helps find treasure chests"
		_:
			return "Wanderer"

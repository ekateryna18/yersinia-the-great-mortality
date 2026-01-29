extends Node

# Dictionnaire des dialogues par type de NPC
const DIALOGUES = {
	"MERCHANT": {
		"intro": "Bonjour voyageur ! J'ai des potions qui pourraient t'aider...",
		"question": "Combien coûte une potion de soin ?",
		"answers": ["10 pièces", "20 pièces", "30 pièces", "50 pièces"],
		"correct_index": 1,
		"good_answer": "Exact ! Tu es observateur. Les traîtres sont le Forgeron et le Malade.",
		"bad_answer": "Non, c'est 20 pièces. Je ne peux pas t'aider davantage."
	},
	
	"BLACKSMITH": {
		"intro": "Je forge les meilleures armes de la région...",
		"question": "Quel métal est le plus résistant ?",
		"answers": ["Fer", "Acier", "Bronze", "Or"],
		"correct_index": 1,
		"good_answer": "Bien joué ! Les traîtres sont le Marchand et le Magicien.",
		"bad_answer": "Faux. C'est l'acier. Va-t'en."
	},
	
	"WIZARD": {
		"intro": "Les arcanes révèlent bien des secrets...",
		"question": "Combien d'éléments magiques existe-t-il ?",
		"answers": ["3", "4", "5", "6"],
		"correct_index": 1,
		"good_answer": "Impressionnant ! Les traîtres sont le Villageois 1 et le Malade.",
		"bad_answer": "Incorrect. Il y en a 4. Je ne peux rien te dire."
	},
	
	"SICK": {
		"intro": "*tousse* Je suis malade... mais j'ai des informations...",
		"question": "Quelle plante soigne la fièvre ?",
		"answers": ["Rose", "Sauge", "Tulipe", "Orchidée"],
		"correct_index": 1,
		"good_answer": "Tu connais les plantes ! Les traîtres sont le Magicien et Villageois 2.",
		"bad_answer": "Non, c'est la sauge. Laisse-moi."
	},
	
	"GENERIC": {
		"intro": "Je suis un simple villageois... mais j'observe beaucoup.",
		"question": "Combien de maisons y a-t-il au village ?",
		"answers": ["5", "7", "9", "12"],
		"correct_index": 2,
		"good_answer": "Bien compté ! Les traîtres sont le Forgeron et le Magicien.",
		"bad_answer": "Faux. Il y en a 9. Je ne te dirai rien."
	}
}

# Fonction pour obtenir le dialogue d'un NPC
static func get_dialogue(npc_type: String) -> Dictionary:
	if DIALOGUES.has(npc_type):
		return DIALOGUES[npc_type]
	else:
		return DIALOGUES["GENERIC"]

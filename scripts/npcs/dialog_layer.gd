extends CanvasLayer

var stage: String = "intro"
var current_npc: Node = null
var dialogue_data: Dictionary = {}

@onready var dialog_box: Panel = $DialogBox
@onready var dialog_label: Label = $DialogBox/DialogLabel
@onready var close_button: Button = $DialogBox/CloseButton
@onready var choix_devinette: Button = $ChoixDevinetteButton
@onready var choix_attaquer: Button = $ChoixAttaquerButton
@onready var reponse1: Button = $Reponse1Button
@onready var reponse2: Button = $Reponse2Button
@onready var reponse3: Button = $Reponse3Button
@onready var reponse4: Button = $Reponse4Button

func _ready() -> void:
	dialog_box.visible = false
	
	# Connecter les boutons
	close_button.pressed.connect(_on_close_button_pressed)
	choix_devinette.pressed.connect(_on_choix_devinette_pressed)
	choix_attaquer.pressed.connect(_on_choix_attaquer_pressed)
	
	reponse1.pressed.connect(func(): _on_answer_pressed(0))
	reponse2.pressed.connect(func(): _on_answer_pressed(1))
	reponse3.pressed.connect(func(): _on_answer_pressed(2))
	reponse4.pressed.connect(func(): _on_answer_pressed(3))
	
	_set_choice_visible(false)
	_set_answers_visible(false)

func open_dialogue(data: Dictionary, npc: Node) -> void:
	dialogue_data = data
	current_npc = npc
	stage = "choice"
	
	dialog_box.visible = true
	dialog_label.text = dialogue_data.get("intro", "...")
	
	_set_choice_visible(true)
	_set_answers_visible(false)

func _on_close_button_pressed() -> void:
	_close_dialog()

func _on_choix_devinette_pressed() -> void:
	stage = "question"
	dialog_label.text = dialogue_data.get("question", "")
	
	var answers = dialogue_data.get("answers", [])
	reponse1.text = answers[0] if answers.size() > 0 else ""
	reponse2.text = answers[1] if answers.size() > 1 else ""
	reponse3.text = answers[2] if answers.size() > 2 else ""
	reponse4.text = answers[3] if answers.size() > 3 else ""
	
	_set_choice_visible(false)
	_set_answers_visible(true)

func _on_choix_attaquer_pressed() -> void:
	stage = "result"
	dialog_label.text = "Tu m'attaques ? Très bien, préparons-nous au combat..."
	_set_choice_visible(false)
	_set_answers_visible(false)
	
	# TODO: Système de combat avec le NPC
	if current_npc:
		print("Combat avec ", current_npc.npc_name)

func _on_answer_pressed(index: int) -> void:
	if stage != "question":
		return
	
	stage = "result"
	var correct_index = dialogue_data.get("correct_index", -1)
	
	if index == correct_index:
		dialog_label.text = dialogue_data.get("good_answer", "Bonne réponse !")
	else:
		dialog_label.text = dialogue_data.get("bad_answer", "Mauvaise réponse.")
	
	_set_answers_visible(false)

func _close_dialog() -> void:
	stage = "intro"
	dialog_box.visible = false
	_set_choice_visible(false)
	_set_answers_visible(false)
	current_npc = null

func _set_choice_visible(visible: bool) -> void:
	choix_devinette.visible = visible
	choix_attaquer.visible = visible

func _set_answers_visible(visible: bool) -> void:
	reponse1.visible = visible
	reponse2.visible = visible
	reponse3.visible = visible
	reponse4.visible = visible

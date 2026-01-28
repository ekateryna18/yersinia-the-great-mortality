extends CanvasLayer

var stage: String = "intro"  # "intro", "choice", "question", "result"

var intro_text := "Bonjour, je m'appelle Aline. Je garde un secret important..."
var question_text := "Quel est le plus grand océan du monde ?"
var answers := [
	"Océan Atlantique",
	"Océan Pacifique", # bonne
	"Océan Indien",
	"Océan Arctique"
]
var correct_answer_index := 1

var good_answer_text := "Bravo, bonne réponse ! Les traîtres sont Hugo et Nora."
var bad_answer_text := "La bonne réponse était l'océan Pacifique. Je ne peux pas t'aider."
var attack_text := "Tu m'attaques ? Très bien, préparons-nous au combat..."

func _ready() -> void:
	$DialogBox.visible = false

	# Bouton pour démarrer la discussion
	$TalkButton.pressed.connect(_on_talk_button_pressed)

	# Bouton pour fermer la discussion
	$DialogBox/CloseButton.text = "Fermer"
	$DialogBox/CloseButton.pressed.connect(_on_close_button_pressed)

	# Boutons de choix
	$ChoixDevinetteButton.text = "Devinette"
	$ChoixAttaquerButton.text = "Combat"

	$ChoixDevinetteButton.pressed.connect(_on_choix_devinette_pressed)
	$ChoixAttaquerButton.pressed.connect(_on_choix_attaquer_pressed)

	# Boutons de réponses
	$Reponse1Button.pressed.connect(func(): _on_answer_pressed(0))
	$Reponse2Button.pressed.connect(func(): _on_answer_pressed(1))
	$Reponse3Button.pressed.connect(func(): _on_answer_pressed(2))
	$Reponse4Button.pressed.connect(func(): _on_answer_pressed(3))

	_set_choice_visible(false)
	_set_answers_visible(false)

func _on_talk_button_pressed() -> void:
	if stage == "intro":
		_open_intro()
	else:
		_close_dialog()

func _open_intro() -> void:
	stage = "choice"
	$DialogBox.visible = true
	$DialogBox/DialogLabel.text = intro_text
	$TalkButton.visible = false   # cacher "Parler" pendant la discussion
	_set_choice_visible(true)
	_set_answers_visible(false)

func _on_close_button_pressed() -> void:
	_close_dialog()

func _on_choix_devinette_pressed() -> void:
	stage = "question"
	$DialogBox/DialogLabel.text = question_text

	$Reponse1Button.text = answers[0]
	$Reponse2Button.text = answers[1]
	$Reponse3Button.text = answers[2]
	$Reponse4Button.text = answers[3]

	_set_choice_visible(false)
	_set_answers_visible(true)

func _on_choix_attaquer_pressed() -> void:
	stage = "result"
	$DialogBox/DialogLabel.text = attack_text
	_set_choice_visible(false)
	_set_answers_visible(false)

	# Ici les devs branchent le combat :
	# get_tree().change_scene_to_file("res://scenes/combat.tscn")
	# ou émettre un signal vers leur système de combat.

func _on_answer_pressed(index: int) -> void:
	if stage != "question":
		return

	stage = "result"

	if index == correct_answer_index:
		$DialogBox/DialogLabel.text = good_answer_text
	else:
		$DialogBox/DialogLabel.text = bad_answer_text

	_set_answers_visible(false)

func _close_dialog() -> void:
	stage = "intro"
	$DialogBox.visible = false
	$TalkButton.visible = true    # réafficher le bouton "Parler"
	_set_choice_visible(false)
	_set_answers_visible(false)

func _set_choice_visible(visible: bool) -> void:
	$ChoixDevinetteButton.visible = visible
	$ChoixAttaquerButton.visible = visible

func _set_answers_visible(visible: bool) -> void:
	$Reponse1Button.visible = visible
	$Reponse2Button.visible = visible
	$Reponse3Button.visible = visible
	$Reponse4Button.visible = visible

extends CanvasLayer

var is_open: bool = false

func _ready() -> void:
	$DialogBox.visible = false
	$TalkButton.pressed.connect(_on_talk_button_pressed)

func _on_talk_button_pressed() -> void:
	if is_open:
		$DialogBox.visible = false
		is_open = false
	else:
		$DialogBox.visible = true
		is_open = true

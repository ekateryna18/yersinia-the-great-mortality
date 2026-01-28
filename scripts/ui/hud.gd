extends CanvasLayer

@onready var phase_label: Label = $VBoxContainer/PhaseLabel
@onready var timer_label: Label = $VBoxContainer/TimerLabel
@onready var player_stats_label: Label = $VBoxContainer/PlayerStatsLabel
@onready var debug_button: Button = $VBoxContainer/DebugButton
@onready var start_night_button: Button = $StartNightButton  # ← NOUVEAU

var player: CharacterBody2D = null

func _ready() -> void:
	# Connecter aux signaux du GameManager
	GameManager.phase_changed.connect(_on_phase_changed)
	GameManager.night_changed.connect(_on_night_changed)
	
	# Connecter les boutons
	debug_button.pressed.connect(_on_debug_button_pressed)
	start_night_button.pressed.connect(_on_start_night_button_pressed)  # ← NOUVEAU
	
	# Premier affichage
	update_display()

func _process(_delta: float) -> void:
	if player == null or not is_instance_valid(player):
		find_player()
	
	update_display()

func find_player() -> void:
	if GameManager.current_map_scene:
		player = GameManager.current_map_scene.get_node_or_null("Player")

func update_display() -> void:
	if GameManager.current_run == null:
		phase_label.text = "Pas de run actif"
		timer_label.text = ""
		player_stats_label.text = ""
		start_night_button.visible = false
		return
	
	# === PHASE ET NUIT ===
	var phase_text = "JOUR" if GameManager.is_day() else "NUIT"
	var night = GameManager.current_run.night
	phase_label.text = "%s %d" % [phase_text, night]
	
	# === TIMER ===
	if GameManager.is_night():
		var time_remaining = GameManager.get_night_time_remaining()
		var minutes = int(time_remaining) / 60
		var seconds = int(time_remaining) % 60
		timer_label.text = "Temps: %d:%02d" % [minutes, seconds]
		timer_label.visible = true
	else:
		var time_elapsed = GameManager.get_day_time_elapsed()
		var minutes = int(time_elapsed) / 60
		var seconds = int(time_elapsed) % 60
		timer_label.text = "Jour - %d:%02d" % [minutes, seconds]
		timer_label.visible = true
	
	# === STATS JOUEUR ===
	if player and is_instance_valid(player):
		var hp = int(player.current_health)
		var max_hp = int(player.max_health)
		var hp_percent = player.get_health_percent() * 100
		
		player_stats_label.text = "HP: %d/%d (%.0f%%)" % [hp, max_hp, hp_percent]
		
		if hp_percent > 60:
			player_stats_label.add_theme_color_override("font_color", Color.GREEN)
		elif hp_percent > 30:
			player_stats_label.add_theme_color_override("font_color", Color.YELLOW)
		else:
			player_stats_label.add_theme_color_override("font_color", Color.RED)
	else:
		player_stats_label.text = "HP: -- / --"
	
	# === BOUTON START NIGHT ===
	# Visible uniquement en JOUR
	start_night_button.visible = GameManager.is_day()

func _on_phase_changed(_new_phase) -> void:
	update_display()
	
	if GameManager.is_night():
		print(">>> LA NUIT COMMENCE! Survivez 2min30! <<<")

func _on_night_changed(_night_number: int) -> void:
	update_display()
	print(">>> Nouveau jour! <<<")

func _on_debug_button_pressed() -> void:
	if GameManager.is_day():
		GameManager.transition_to_night()
	else:
		GameManager.transition_to_day()

func _on_start_night_button_pressed() -> void:
	# Démarrer la nuit uniquement si on est en JOUR
	if GameManager.is_day():
		print(">>> Joueur démarre la nuit manuellement! <<<")
		GameManager.transition_to_night()

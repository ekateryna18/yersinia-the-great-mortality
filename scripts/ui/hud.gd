extends CanvasLayer

@onready var phase_label: Label = $VBoxContainer/PhaseLabel
@onready var timer_label: Label = $VBoxContainer/TimerLabel
@onready var player_stats_label: Label = $VBoxContainer/PlayerStatsLabel
@onready var debug_button: Button = $VBoxContainer/DebugButton
#@onready var start_night_button: Button = $StartNightButton  # ← NOUVEAU
@onready var enemy_count_label: Label = $VBoxContainer/EnemyCountLabel
@onready var transition_label: Label = $ScreenTemplate/TransitionLabel
@onready var night_label: Label = $ScreenTemplate/Nuit
@onready var transition_overlay: TextureRect = $ScreenTemplate/TransitionOverlay 
@onready var screen_template: Control = $ScreenTemplate 

var player: CharacterBody2D = null

func _ready() -> void:
	# Connecter aux signaux du GameManager
	GameManager.phase_changed.connect(_on_phase_changed)
	GameManager.night_changed.connect(_on_night_changed)
	GameManager.player_died.connect(_on_player_died)
	GameManager.run_completed.connect(_on_run_completed)
	
	# Connecter les boutons
	debug_button.pressed.connect(_on_debug_button_pressed)
	#start_night_button.pressed.connect(_on_start_night_button_pressed)
	
	# Cacher la transition au début
	if screen_template:
		screen_template.visible = false
		
	#if transition_label:
		#transition_label.visible = false
	#if transition_overlay:
		#transition_overlay.visible = false
	
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
		#start_night_button.visible = false
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
		#timer_label.text = "Jour - %d:%02d" % [minutes, seconds]
		timer_label.visible = false
	
	# === STATS JOUEUR ===
	if player and is_instance_valid(player):
		var hp = int(player.current_health)
		var max_hp = int(player.max_health)
		var hp_percent = player.get_health_percent() * 100
		var dmg = int(player.damage)  # ← NOUVEAU
		
		player_stats_label.text = "HP: %d/%d | DMG: %d" % [hp, max_hp, dmg]  # ← MODIFIÉ
		
		if hp_percent > 60:
			player_stats_label.add_theme_color_override("font_color", Color.GREEN)
		elif hp_percent > 30:
			player_stats_label.add_theme_color_override("font_color", Color.YELLOW)
		else:
			player_stats_label.add_theme_color_override("font_color", Color.RED)
	else:
		player_stats_label.text = "HP: -- / -- | DMG: --"
	# === COMPTEUR ENNEMIS ===
	if GameManager.is_night():
		var enemies = get_tree().get_nodes_in_group("enemies")
		var enemy_count = enemies.size()
		
		var kills = 0
		var kills_normal = 0
		var kills_mutant = 0
		var boss_killed = false
		
		if GameManager.current_run:
			var stats = GameManager.current_run.stats_run
			kills = stats.get("kills", 0)
			kills_normal = stats.get("kills_normal", 0)
			kills_mutant = stats.get("kills_mutant", 0)
			boss_killed = stats.get("boss_killed", false)
		
		enemy_count_label.text = "Ennemis: %d | Kills: %d (N:%d M:%d) | Boss: %s" % [
			enemy_count,
			kills,
			kills_normal,
			kills_mutant,
			"OK" if boss_killed else "--"
		]
		enemy_count_label.visible = true
	else:
		enemy_count_label.visible = false
	#print(enemy_count_label)
	# === BOUTON START NIGHT ===
	# Visible uniquement en JOUR
	#start_night_button.visible = GameManager.is_day()

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

#func _on_start_night_button_pressed() -> void:
	## Démarrer la nuit uniquement si on est en JOUR
	#if GameManager.is_day():
		#print(">>> Joueur démarre la nuit manuellement! <<<")
		#GameManager.transition_to_night()

# ============================================
# VICTOIRE / DÉFAITE
# ============================================
func _on_player_died() -> void:
	var current_night = GameManager.current_run.night if GameManager.current_run else 0
	
	if current_night == 5:
		show_defeat_night5()
	else:
		show_game_over()

func _on_run_completed() -> void:
	show_victory()

func show_victory() -> void:
	print("HUD: Showing victory screen")
	if screen_template:
		screen_template.visible = true
	# Activer l'overlay noir
	#if transition_overlay:
		#transition_overlay.visible = true
	if night_label:
		night_label.text = "NUIT %d" % GameManager.current_run.night
	# Afficher le texte de victoire
	#if transition_label:
		#var total_gloire = 0
		#if GameManager.current_run:
			#total_gloire = GameManager.current_run.gloire
		#
		#transition_label.text = "🎉 VICTOIRE! 🎉\n\nVous avez survécu aux 5 nuits!\nGloire totale: %d" % total_gloire
		#transition_label.add_theme_color_override("font_color", Color.GOLD)
		##transition_label.visible = true
		#print(GameManager.current_run.stats_run)
	
	# Attendre 3 secondes
	await get_tree().create_timer(5.0).timeout
	
	# Cacher la transition
	hide_transition()

func show_defeat_night5() -> void:
	print("HUD: Showing defeat screen (Night 5)")
	if screen_template:
		screen_template.visible = true
	if night_label:
		night_label.text = "NUIT %d" % GameManager.current_run.night
	
	# Activer l'overlay noir
	#if transition_overlay:
		#transition_overlay.visible = true
	
	# Afficher le texte de défaite
	#if transition_label:
		#transition_label.text = "💀 DÉFAITE 💀\n\nVous n'avez pas survécu à la Nuit 5...\nRetour au Jour 5"
		#transition_label.add_theme_color_override("font_color", Color.RED)
		#transition_label.visible = true
	print(GameManager.current_run.stats_run)
	
	
	# Attendre 2 secondes
	await get_tree().create_timer(5.0).timeout
	
	# Cacher la transition
	hide_transition()

func show_game_over() -> void:
	print("HUD: Showing game over screen")
	if screen_template:
		screen_template.visible = true
	# Activer l'overlay noir
	#if transition_overlay:
		#transition_overlay.visible = true
	if night_label:
		night_label.text = "NUIT %d" % GameManager.current_run.night
	
	# Afficher le texte de game over
	#if transition_label:
		#var current_night = GameManager.current_run.night if GameManager.current_run else 0
		#transition_label.text = "💀 GAME OVER 💀\n\nMort durant Nuit %d\nRedémarrage..." % current_night
		#transition_label.add_theme_color_override("font_color", Color.RED)
		#transition_label.visible = true
	
	# Attendre 2 secondes
	await get_tree().create_timer(5.0).timeout
	
	# Cacher la transition
	hide_transition()

func hide_transition() -> void:
	if screen_template:
		screen_template.visible = false
	#if transition_overlay:
		#transition_overlay.visible = false
	#if transition_label:
		#transition_label.visible = false

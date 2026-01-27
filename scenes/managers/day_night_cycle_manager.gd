extends Node
## Gestionnaire du cycle jour/nuit et spawn des ennemis

class_name DayNightCycleManager

# ========================
# CONFIG
# ========================
@export var day_duration: float = 60.0      # Durée du jour en secondes
@export var night_duration: float = 90.0    # Durée de la nuit en secondes (45-90 sec GDD)
@export var total_nights: int = 5           # 5 nuits pour finir

# ========================
# DIFFICULTY CURVE
# ========================
@export var difficulty_curve: Array[float] = [
	1.0,   # Nuit 1: 1x
	1.2,   # Nuit 2: 1.2x
	1.4,   # Nuit 3: 1.4x
	1.6,   # Nuit 4: 1.6x
	1.8    # Nuit 5: 1.8x (Boss)
]

# ========================
# STATE
# ========================
var player: Player
var is_day: bool = true
var current_night: int = 0  # 1-5
var cycle_timer: float = 0.0
var time_remaining: float = 0.0

# ========================
# REFERENCES
# ========================
var spawner: EnemySpawner
var ui_manager: UIManager

# ========================
# SPAWN CONFIG
# ========================
@export var spawn_interval: float = 15.0    # Spawn tous les 15 secondes (tune avec difficulté)
@export var enemies_per_spawn: int = 1      # Ennemis par spawn
@export var max_enemies_on_screen: int = 15

var spawn_locations: Array[Vector2] = [
	Vector2(50, 50),
	Vector2(1230, 50),
	Vector2(50, 710),
	Vector2(1230, 710)
]

# ========================
# LIFECYCLE
# ========================
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	spawner = get_tree().get_first_node_in_group("enemy_spawner")
	ui_manager = get_tree().get_first_node_in_group("ui_manager")
	
	# Commencer par le jour
	is_day = true
	current_night = 0
	cycle_timer = 0.0
	time_remaining = day_duration
	
	add_to_group("game_manager")
	add_to_group("day_night_manager")

func _process(delta: float) -> void:
	if not player or player.is_dead():
		return
	
	cycle_timer += delta
	time_remaining -= delta
	
	# Jour
	if is_day:
		_handle_day_cycle(delta)
	# Nuit
	else:
		_handle_night_cycle(delta)
	
	# Update UI
	if ui_manager:
		ui_manager.update_time_display(int(time_remaining), is_day)

# ========================
# DAY CYCLE
# ========================
func _handle_day_cycle(delta: float) -> void:
	"""Gérer le cycle du jour"""
	if time_remaining <= 0:
		# Jour terminé → Nuit
		start_night()
	
	# Comportement jour : PNJ visibles, pas d'ennemis

func start_night() -> void:
	"""Commencer la nuit"""
	is_day = false
	current_night += 1
	
	# Vérifier si c'est la fin du jeu
	if current_night > total_nights:
		end_game_victory()
		return
	
	# Reset timers
	cycle_timer = 0.0
	time_remaining = night_duration
	
	# Activer le joueur pour la nuit
	player.start_night()
	
	# Commencer le spawn d'ennemis
	if spawner:
		var difficulty = difficulty_curve[current_night - 1]
		spawner.start_night_spawning(difficulty, spawn_interval, max_enemies_on_screen)
	
	# Update UI
	if ui_manager:
		ui_manager.show_night_transition(current_night)

# ========================
# NIGHT CYCLE
# ========================
func _handle_night_cycle(delta: float) -> void:
	"""Gérer le cycle de la nuit"""
	if time_remaining <= 0:
		# Nuit terminée → Jour suivant (ou Game Over)
		end_night()
	
	# Ennemis spawn continuellement

func end_night() -> void:
	"""Terminer la nuit"""
	is_day = true
	
	# Arrêter spawn d'ennemis
	if spawner:
		spawner.stop_night_spawning()
	
	# Joueur survit
	player.survive_night()
	
	# Vérifier victoire
	if current_night >= total_nights:
		end_game_victory()
		return
	
	# Jour suivant
	player.end_night()
	
	# Reset timer jour
	cycle_timer = 0.0
	time_remaining = day_duration
	
	# Update UI
	if ui_manager:
		ui_manager.show_day_transition(player.current_day)

# ========================
# GAME END
# ========================
func end_game_victory() -> void:
	"""Victoire : 5 nuits survécues"""
	print(f"🎉 VICTOIRE! Gloire gagnée: {player.glory_earned}")
	
	# Sauvegarder la progression
	_save_run_results()
	
	# Retour menu
	get_tree().paused = true
	if ui_manager:
		ui_manager.show_victory_screen(player)

func on_player_defeated() -> void:
	"""Défaite : joueur tué"""
	print(f"💀 DÉFAITE! Gloire: {player.glory_earned}")
	
	# Sauvegarder les résultats
	_save_run_results()
	
	# Écran de game over
	if ui_manager:
		ui_manager.show_game_over_screen(player)

# ========================
# RUN RESULTS
# ========================
func _save_run_results() -> void:
	"""Sauvegarder les résultats de la run"""
	var results = {
		"glory": player.glory_earned,
		"good_points": player.good_points,
		"bad_points": player.bad_points,
		"kills": player.kills_count,
		"nights_survived": player.night_survived
	}
	
	print(f"Run Results: {results}")
	# TODO: Intégrer avec SaveManager

# ========================
# HELPERS
# ========================
func get_current_difficulty() -> float:
	"""Obtenir le multiplicateur de difficulté actuel"""
	if current_night > 0 and current_night <= difficulty_curve.size():
		return difficulty_curve[current_night - 1]
	return 1.0

func get_progress() -> float:
	"""Obtenir la progression du cycle (0.0 à 1.0)"""
	var total_time = day_duration if is_day else night_duration
	return 1.0 - (time_remaining / total_time)

func get_cycle_info() -> Dictionary:
	"""Obtenir les infos du cycle pour l'UI"""
	return {
		"is_day": is_day,
		"current_night": current_night,
		"total_nights": total_nights,
		"time_remaining": time_remaining,
		"difficulty": get_current_difficulty(),
		"progress": get_progress()
	}

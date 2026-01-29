extends Node

# ============================================
# GAME MANAGER - Gestion globale du jeu
# ============================================
#Reférence à la scène map actuelle
var current_map_scene: Node = null
# In GameManager.gd (top-level)
enum EnemyType { RAT_NORMAL, RAT_MUTANT, RAT_BOSS }

# Limites de la map
#const MAP_BOUNDS := Rect2(-1000, -1000, 2000, 2000)
const MAP_BOUNDS := Rect2(-2040, -1587, 4079, 3174)
# Durée de la nuit en secondes
#const NIGHT_DURATION: float = 150.0  # 2 minutes 30 secondes
const NIGHT_DURATION: float = 50.0  # 2 minutes 30 secondes
var player_ref: CharacterBody2D = null 
var is_transitioning: bool = false
var victory_in_progress: bool = false 
# ============================================
# RUN STATE - État de la session courante
# ============================================
class RunState:
	var night: int = 1
	var player_alive: bool = true
	var gloire: int = 0
	var stats_run: Dictionary = {}
	var pnj_list: Array = []
	var enemies_wave: Array = []
	var day_elapsed_sec: float = 0.0
	var night_elapsed_sec: float = 0.0

# Instance du state actuel
var current_run: RunState = null

# ============================================
# GAME PHASE - Jour/Nuit
# ============================================
enum GamePhase { DAY, NIGHT }
var current_phase: GamePhase = GamePhase.DAY

# ============================================
# SIGNALS - Événements importants
# ============================================
signal phase_changed(new_phase: GamePhase)
signal night_changed(night_number: int)
signal player_died()  # ← Vérifier qu'il existe
signal run_completed()  # ← Vérifier qu'il existe

# ============================================
# LIFECYCLE
# ============================================
func _ready() -> void:
	print("=== Game Manager Initialized ===")
	# Démarrer automatiquement un nouveau run
	start_new_run()

func _process(delta: float) -> void:
	if current_run == null:
		return
	
	# Ne pas traiter si on est en transition
	if is_transitioning or victory_in_progress:
		return
	
	# Timer du jour/nuit
	if current_phase == GamePhase.DAY:
		current_run.day_elapsed_sec += delta
	elif current_phase == GamePhase.NIGHT:
		current_run.night_elapsed_sec += delta
		
		# Check si la nuit est terminée (2min30)
		# IMPORTANT: Ne vérifier QU'UNE SEULE FOIS
		if current_run.night_elapsed_sec >= NIGHT_DURATION:
			# Marquer qu'on est en transition pour éviter de re-entrer
			is_transitioning = true
			end_night()
			
# ============================================
# RUN MANAGEMENT
# ============================================
func start_new_run() -> void:
	print("=== Starting New Run ===")
	current_run = RunState.new()
	current_run.night = 1
	current_run.player_alive = true
	current_run.gloire = 0
	current_run.stats_run = { "kills": 0 }  # ← AJOUTER l'initialisation des stats
	current_run.pnj_list = []
	current_run.enemies_wave = []
	current_run.day_elapsed_sec = 0.0
	current_run.night_elapsed_sec = 0.0
	current_run.stats_run = {
		"kills": 0,
		"kills_normal": 0,
		"kills_mutant": 0,
		"boss_killed": false,
	}
	
	# Démarrer en Jour 1
	set_phase(GamePhase.DAY)
	
	print("Run initialized: Night ", current_run.night)

func initialize_npcs(npc_nodes: Array) -> void:
	print("=== Initializing NPCs ===")
	
	# Sauvegarder la référence aux PNJ
	current_run.pnj_list = npc_nodes
	
	# Choisir 2 traîtres aléatoires
	var traitor_indices = []
	while traitor_indices.size() < 2:
		var random_index = randi() % npc_nodes.size()
		if random_index not in traitor_indices:
			traitor_indices.append(random_index)
	
	# Marquer les traîtres
	for i in range(npc_nodes.size()):
		var npc = npc_nodes[i]
		if i in traitor_indices:
			npc.is_traitor = true
			print("⚠️ ", npc.npc_name, " est un TRAÎTRE!")
		else:
			npc.is_traitor = false
			print("✅ ", npc.npc_name, " est innocent")
# ============================================
# PHASE MANAGEMENT
# ============================================
func set_phase(new_phase: GamePhase) -> void:
	#if current_phase == new_phase and not is_transitioning:
		#print("⚠️ Already in phase ", new_phase, ", ignoring...")
		#return
	current_phase = new_phase
	
	if new_phase == GamePhase.DAY:
		print("--- DAY ", current_run.night, " STARTED ---")
		current_run.day_elapsed_sec = 0.0
		load_day_map()  # ← AJOUTER cette ligne
	elif new_phase == GamePhase.NIGHT:
		print("--- NIGHT ", current_run.night, " STARTED ---")
		current_run.night_elapsed_sec = 0.0
		if current_run.night == 5:
			load_boss_map()
		else:
			load_night_map()
	
	phase_changed.emit(new_phase)

func transition_to_night() -> void:
	if current_phase == GamePhase.DAY:
		set_phase(GamePhase.NIGHT)

func transition_to_day() -> void:
	if current_phase != GamePhase.NIGHT:
		return
	
	current_run.night += 1
	
	# Vérifier qu'on ne dépasse pas Nuit 5
	if current_run.night > 5:
		print("⚠️ ERROR: Trying to go beyond Night 5!")
		victory_run()  # Forcer la victoire
		return
	
	set_phase(GamePhase.DAY)
	night_changed.emit(current_run.night)

func end_night() -> void:
	if current_phase != GamePhase.NIGHT:
		is_transitioning = false
		return
	
	print("=== NIGHT ", current_run.night, " ENDED ===")
	
	# Afficher les stats de la nuit
	display_night_stats()
	
	# Cas spécial: Nuit 5 complétée = VICTOIRE!
	if current_run.night == 5:
		await victory_run()
	else:
		# Nuits 1-4: Passer au jour suivant normalement
		transition_to_day()
	
	# Reset le flag après la transition
	is_transitioning = false

func victory_run() -> void:
	# Empêcher les appels multiples
	if victory_in_progress:
		print("⚠️ Victory already in progress, ignoring...")
		return
	
	victory_in_progress = true
	
	print("🎉🎉🎉 VICTOIRE! Run complété! 🎉🎉🎉")
	print("Vous avez survécu aux 5 nuits!")
	print("Gloire totale gagnée: ", current_run.gloire)
	
	run_completed.emit()
	
	var permanent_gloire = current_run.gloire
	var permanent_stats = current_run.stats_run.duplicate()
	
	await get_tree().create_timer(3.0).timeout
	
	start_new_run_with_progression(permanent_gloire)
	
	victory_in_progress = false
	
func start_new_run_with_progression(previous_gloire: int) -> void:
	print("=== Starting New Run (avec progression) ===")
	
	current_run = RunState.new()
	current_run.night = 1
	current_run.player_alive = true
	current_run.gloire = previous_gloire  # ← Garder la gloire!
	current_run.stats_run = { "kills": 0 }
	current_run.pnj_list = []
	current_run.enemies_wave = []
	current_run.day_elapsed_sec = 0.0
	current_run.night_elapsed_sec = 0.0
	current_run.stats_run = {
		"kills": 0,
		"kills_normal": 0,
		"kills_mutant": 0,
		"boss_killed": false,
	}
	
	# Démarrer en Jour 1
	set_phase(GamePhase.DAY)
	
	print("Run initialized: Night ", current_run.night)
	print("Gloire conservée: ", current_run.gloire)

func display_night_stats() -> void:
	print("--- NIGHT ", current_run.night, " STATS ---")
	
	var kills = current_run.stats_run.get("kills", 0)
	var time_survived = current_run.night_elapsed_sec
	var minutes = int(time_survived) / 60
	var seconds = int(time_survived) % 60
	
	current_run.stats_run["kills"] = 0
	current_run.stats_run["kills_normal"] = 0
	current_run.stats_run["kills_mutant"] = 0
	current_run.stats_run["boss_killed"] = false
	
	print("Kills: ", kills)
	print("Time survived: %d:%02d" % [minutes, seconds])
	print("Gloire earned: ", kills * 10)  # 10 gloire par kill
	
	# Ajouter la gloire
	current_run.gloire += kills * 10
	
	# Reset les stats de run pour la prochaine nuit
	current_run.stats_run["kills"] = 0
	
	print("Total Gloire: ", current_run.gloire)
	print("-------------------------")
# ============================================
# UTILITY
# ============================================
func is_within_bounds(position: Vector2) -> bool:
	return MAP_BOUNDS.has_point(position)

func clamp_to_bounds(position: Vector2) -> Vector2:
	return Vector2(
		clamp(position.x, MAP_BOUNDS.position.x, MAP_BOUNDS.end.x),
		clamp(position.y, MAP_BOUNDS.position.y, MAP_BOUNDS.end.y)
	)

func is_day() -> bool:
	return current_phase == GamePhase.DAY

func is_night() -> bool:
	return current_phase == GamePhase.NIGHT
# ============================================
# SCENE MANAGEMENT
# ============================================
func load_day_map() -> void:
	print("Loading Day Map...")
	change_scene("res://scenes/maps/day_map.tscn")

func load_night_map() -> void:
	print("Loading Night Map...")
	change_scene("res://scenes/maps/night_map.tscn")

func load_boss_map() -> void:
	print("Loading Boss Map...")
	change_scene("res://scenes/maps/boss_map.tscn")
	
func change_scene(scene_path: String) -> void:
	print("=== Changing Scene ===")
	print("From: ", current_map_scene.name if current_map_scene else "None")
	print("To: ", scene_path)
	
	# Geler le joueur avant transition (si existe)
	if player_ref and is_instance_valid(player_ref):
		player_ref.freeze()
	
	# Nettoyer l'ancienne scène si elle existe
	if current_map_scene:
		print("Cleaning up old scene...")
		current_map_scene.queue_free()
		await current_map_scene.tree_exited
		print("Old scene cleaned")
	
	# Charger la nouvelle scène
	var new_scene = load(scene_path)
	current_map_scene = new_scene.instantiate()
	
	# Ajouter à Main
	var main_node = get_tree().root.get_node("Main")
	main_node.add_child(current_map_scene)
	main_node.move_child(current_map_scene, 0)
	
	print("New scene loaded: ", scene_path)
	
	# Attendre un court délai puis dégeler le joueur (SANS reconnect)
	await get_tree().create_timer(0.3).timeout
	
	# Appeler directement la fonction (pas de signal)
	find_and_unfreeze_player()
	
func find_and_unfreeze_player() -> void:
	# Chercher le joueur dans la nouvelle scène
	if current_map_scene:
		player_ref = current_map_scene.get_node_or_null("Player")
		if player_ref and is_instance_valid(player_ref):
			player_ref.unfreeze()
			print("Player found and unfrozen")
		else:
			print("⚠️ Player not found in scene")

# ============================================
# GETTERS
# ============================================
func get_night_time_remaining() -> float:
	if current_run == null or current_phase != GamePhase.NIGHT:
		return 0.0
	return max(0.0, NIGHT_DURATION - current_run.night_elapsed_sec)

func get_night_time_elapsed() -> float:
	if current_run == null:
		return 0.0
	return current_run.night_elapsed_sec

func get_day_time_elapsed() -> float:
	if current_run == null:
		return 0.0
	return current_run.day_elapsed_sec

#==========================================
# PLAYER MANAGEMENT
# ============================================
func on_player_death() -> void:
	if current_run == null:
		return
	
	print("=== PLAYER DIED ===")
	current_run.player_alive = false
	
	player_died.emit()  # Signal pour le HUD
	
	var current_night = current_run.night
	
	if current_night == 5:
		print("💀 Défaite durant Nuit 5!")
		print("Retour au Jour 5...")
		
		# Attendre l'écran de transition (2 secondes)
		#await get_tree().create_timer(2.0).timeout
		
		# Retourner au JOUR 5 (pas recommencer)
		#current_run.player_alive = true
		#current_run.stats_run["kills"] = 0
		#set_phase(GamePhase.DAY)
		start_new_run()
		
	else:
		print("💀 Mort durant Nuit ", current_night)
		print("Game Over - Restarting run in 2 seconds...")
		
		# Attendre l'écran de transition
		#await get_tree().create_timer(2.0).timeout
		
		# Game Over complet - Nouveau run
		start_new_run()
	
	# ============================================
# GETTERS
# ============================================
func get_current_night() -> int:
	if current_run:
		return current_run.night
	return 1  # Par défaut nuit 1
	
func register_enemy_kill(enemy_type: int) -> void:
	if current_run == null:
		return
	
	current_run.stats_run["kills"] += 1
	
	match enemy_type:
		EnemyType.RAT_NORMAL:
			current_run.stats_run["kills_normal"] += 1
		EnemyType.RAT_MUTANT:
			current_run.stats_run["kills_mutant"] += 1
		EnemyType.RAT_BOSS:
			current_run.stats_run["boss_killed"] = true
			print("Boss killed!")
	
	# Optionnel: debug
	print(
		"Kills total: ", current_run.stats_run["kills"],
		" | Normal: ", current_run.stats_run["kills_normal"],
		" | Mutant: ", current_run.stats_run["kills_mutant"],
		" | Boss: ", current_run.stats_run["boss_killed"]
	)

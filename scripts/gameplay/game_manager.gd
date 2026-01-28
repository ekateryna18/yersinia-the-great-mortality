extends Node

# ============================================
# GAME MANAGER - Gestion globale du jeu
# ============================================
#Reférence à la scène map actuelle
var current_map_scene: Node = null
# Limites de la map
const MAP_BOUNDS := Rect2(-1000, -1000, 2000, 2000)
# Durée de la nuit en secondes
#const NIGHT_DURATION: float = 150.0  # 2 minutes 30 secondes
const NIGHT_DURATION: float = 30.0  # 2 minutes 30 secondes

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
# SIGNALS
# ============================================
signal phase_changed(new_phase: GamePhase)
signal night_changed(night_number: int)

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
	
	# Timer du jour/nuit
	if current_phase == GamePhase.DAY:
		current_run.day_elapsed_sec += delta
	elif current_phase == GamePhase.NIGHT:
		current_run.night_elapsed_sec += delta
		
		# Check si la nuit est terminée (2min30)
		if current_run.night_elapsed_sec >= NIGHT_DURATION:
			end_night()  # ← Changer de transition_to_day() à end_night()

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
	current_phase = new_phase
	
	if new_phase == GamePhase.DAY:
		print("--- DAY ", current_run.night, " STARTED ---")
		current_run.day_elapsed_sec = 0.0
		load_day_map()  # ← AJOUTER cette ligne
	elif new_phase == GamePhase.NIGHT:
		print("--- NIGHT ", current_run.night, " STARTED ---")
		current_run.night_elapsed_sec = 0.0
		load_night_map()  # ← AJOUTER cette ligne
	
	phase_changed.emit(new_phase)

func transition_to_night() -> void:
	if current_phase == GamePhase.DAY:
		set_phase(GamePhase.NIGHT)

func transition_to_day() -> void:
	if current_phase == GamePhase.NIGHT:
		current_run.night += 1
		
		# Check si run terminé (5 nuits max)
		if current_run.night > 5:
			print("=== RUN COMPLETED! ===")
			return
		
		set_phase(GamePhase.DAY)
		night_changed.emit(current_run.night)

func end_night() -> void:
	if current_phase != GamePhase.NIGHT:
		return
	
	print("=== NIGHT ", current_run.night, " ENDED ===")
	
	# Afficher les stats de la nuit
	display_night_stats()
	
	# Passer au jour suivant
	transition_to_day()

func display_night_stats() -> void:
	print("--- NIGHT ", current_run.night, " STATS ---")
	
	var kills = current_run.stats_run.get("kills", 0)
	var time_survived = current_run.night_elapsed_sec
	var minutes = int(time_survived) / 60
	var seconds = int(time_survived) % 60
	
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

func change_scene(scene_path: String) -> void:
	# Nettoyer l'ancienne scène si elle existe
	if current_map_scene:
		current_map_scene.queue_free()
		await current_map_scene.tree_exited
	
	# Charger la nouvelle scène
	var new_scene = load(scene_path)
	current_map_scene = new_scene.instantiate()
	
	# Ajouter à Main (en premier pour être derrière le HUD)
	var main_node = get_tree().root.get_node("Main")
	main_node.add_child(current_map_scene)
	main_node.move_child(current_map_scene, 0)  # Mettre en premier
	
	print("Scene loaded: ", scene_path)
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
	
	# Transition immédiate vers nouveau run
	print("Restarting run in 1 second...")
	await get_tree().create_timer(1.0).timeout
	start_new_run()
	
	# ============================================
# GETTERS
# ============================================
func get_current_night() -> int:
	if current_run:
		return current_run.night
	return 1  # Par défaut nuit 1

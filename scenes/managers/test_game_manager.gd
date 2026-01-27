extends Node2D
## Gestionnaire de scène de test - Joueur vs Ennemi
## Pour tester la mécanique de combat avec auto-attaque (mobile)

class_name TestGameManager

@onready var player: Player = $Player
@onready var enemy = $Enemy
@onready var debug_label: Label = $DebugLabel
@onready var test_ui: Label = $TestGameManager/TestUI

var is_running: bool = true

# ========================
# AUTO-ATTACK CONFIG (Mobile optimisé)
# ========================
var player_attack_timer: float = 0.0
var enemy_attack_timer: float = 0.0

func _ready() -> void:
	print("✅ TEST SCENE LOADED - Joueur vs Ennemi")
	print("📍 Player Position: ", player.global_position)
	print("📍 Enemy Position: ", enemy.global_position)
	print("🎮 CONTRÔLES (MOBILE):")
	print("   - Stick gauche = Mouvement")
	print("   - Auto-attaque chaque 0.5s (réduit avec stats)")
	print("   - SPACE/Tap = Attaque manuelle")
	print("   - ESC = Quitter")
	
	if not player:
		push_error("❌ Player not found!")
	if not enemy:
		push_error("❌ Enemy not found!")

func _process(delta: float) -> void:
	if not is_running:
		return
	
	# Gestion des entrées
	handle_player_input()
	
	# Auto-attaque joueur (delay réduit par les stats)
	update_player_auto_attack(delta)
	
	# Auto-attaque ennemi (basée sur sa vitesse et difficulté)
	update_enemy_auto_attack(delta)
	
	# Update des infos de debug
	update_debug_display()
	
	# Vérifier victoire/défaite
	check_battle_state()

func handle_player_input() -> void:
	# Mouvement WASD (simule analog stick gauche)
	var input_dir := Input.get_vector("ui_left", "ui_down", "ui_right", "ui_up")
	player.set_left_stick(input_dir)
	
	# Attaque manuelle - bonus en appuyant sur SPACE
	if Input.is_action_just_pressed("ui_accept"):
		# Attaquer vers l'ennemi
		var attack_dir = (enemy.global_position - player.global_position).normalized()
		player.set_right_stick(attack_dir)
		player_attack_timer = 0.0  # Reset timer pour attaque immédiate
		print("🗡️  ATTAQUE MANUELLE du joueur")
	
	# Quitter
	if Input.is_action_just_pressed("ui_cancel"):
		print("⏹️  Test terminé")
		is_running = false
		get_tree().quit()

func update_player_auto_attack(delta: float) -> void:
	"""Auto-attaque du joueur - delay basé sur son attack_cooldown"""
	player_attack_timer += delta
	
	# Le cooldown est réduit par les stats (base: 0.5s)
	var attack_delay = player.attack_cooldown
	
	if player_attack_timer >= attack_delay:
		player_attack_timer = 0.0
		
		# Vérifier si l'ennemi est en portée
		var distance = player.global_position.distance_to(enemy.global_position)
		if distance < player.attack_range + 50:  # +50 pour la portée de hit
			var attack_dir = (enemy.global_position - player.global_position).normalized()
			player.set_right_stick(attack_dir)

func update_enemy_auto_attack(delta: float) -> void:
	"""Auto-attaque de l'ennemi - delay basé sur sa détection"""
	enemy_attack_timer += delta
	
	# Delay d'attaque ennemi: plus bas = plus agressif
	var attack_delay = 0.8 / max(0.5, enemy.speed / 100.0)  # Scalé sur la vitesse
	
	if enemy_attack_timer >= attack_delay:
		enemy_attack_timer = 0.0
		
		# Vérifier si le joueur est en portée
		var distance = player.global_position.distance_to(enemy.global_position)
		if distance < 100:  # Portée d'attaque ennemi
			# Attaquer le joueur
			var damage = enemy.calculate_damage_with_crit()
			player.take_damage(damage)
			print("⚔️  Ennemi inflige ", damage, " dégâts")

func update_debug_display() -> void:
	"""Met à jour l'affichage des stats en temps réel"""
	if not player or not enemy:
		return
	
	var distance = player.global_position.distance_to(enemy.global_position)
	
	# Construction du texte (format correct pour Godot 4.6)
	var text = "🎮 TEST BATTLE DEBUG\n"
	text += "═════════════════════════════════════════════════════\n"
	text += "👤 JOUEUR:\n"
	text += "  HP: " + str(player.current_hp) + "/" + str(player.max_hp)
	text += " | Dmg: " + str(player.damage)
	text += " | Spd: " + str(player.speed) + " | Crit: " + str(int(player.crit_chance * 100)) + "%\n"
	text += "  Pos: (" + str(int(player.global_position.x)) + ", " + str(int(player.global_position.y)) + ")"
	text += " | Kills: " + str(player.kills_count) + " | Glory: " + str(player.glory_earned) + "\n"
	text += "  Attaque: " + str(snappedf(player_attack_timer, 0.01)) + "s / " + str(snappedf(player.attack_cooldown, 0.01)) + "s\n"
	
	text += "\n⚔️  ENNEMI (Rat):\n"
	text += "  HP: " + str(enemy.current_hp) + "/" + str(enemy.max_hp)
	text += " | Dmg: " + str(enemy.damage) + " | Spd: " + str(enemy.speed) + "\n"
	text += "  Pos: (" + str(int(enemy.global_position.x)) + ", " + str(int(enemy.global_position.y)) + ")\n"
	text += "  Attaque: " + str(snappedf(enemy_attack_timer, 0.01)) + "s\n"
	
	text += "\n📏 Distance: " + str(snappedf(distance, 0.1)) + " px\n"
	
	if distance < 100:
		text += "🔴 COMBAT ENGAGÉ! (< 100px)\n"
	elif distance < 200:
		text += "🟠 Proche (< 200px)\n"
	else:
		text += "🟢 Hors de portée\n"
	
	text += "\n⌨️  CONTRÔLES: WASD(move) SPACE(bonus atk) ESC(quit)"
	
	debug_label.text = text

func check_battle_state() -> void:
	"""Vérifie si la bataille est terminée"""
	if not is_running:
		return
	
	if player.current_hp <= 0:
		print("💀 GAME OVER - Joueur vaincu!")
		debug_label.text = "💀 DÉFAITE!\nLe joueur a été vaincu par le Rat\nRespawn en 3s..."
		is_running = false
		await get_tree().create_timer(3.0).timeout
		get_tree().reload_current_scene()
	
	if enemy.current_hp <= 0:
		print("🎉 VICTOIRE - Ennemi vaincu!")
		var glory_text = "🎉 VICTOIRE!\nLe Rat a été vaincu\nGloire gagnée: " + str(player.glory_earned) + "\n\nRespawn en 3s..."
		debug_label.text = glory_text
		is_running = false
		await get_tree().create_timer(3.0).timeout
		respawn_enemy()

func respawn_enemy() -> void:
	"""Respawn un nouvel ennemi pour une nouvelle vague de test"""
	print("🔄 Nouvel ennemi spawné")
	is_running = true
	player_attack_timer = 0.0
	enemy_attack_timer = 0.0
	
	# Réinitialiser l'ennemi
	enemy.current_hp = enemy.max_hp
	enemy.global_position = Vector2(900, 400)
	enemy.velocity = Vector2.ZERO
	
	# Réinitialiser le joueur (optionnel, pour garder les dégâts)
	# player.current_hp = player.max_hp
	
	print("✅ Ennemi réapparu avec " + str(enemy.current_hp) + " HP")

func _input(event: InputEvent) -> void:
	"""Snapshot des stats au clic gauche"""
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var distance = player.global_position.distance_to(enemy.global_position)
		print("─────────────────────────────────────────────")
		print("📊 SNAPSHOT:")
		print("Distance: " + str(snappedf(distance, 0.1)))
		print("Player: HP=" + str(player.current_hp) + ", Pos=" + str(player.global_position))
		print("Enemy:  HP=" + str(enemy.current_hp) + ", Pos=" + str(enemy.global_position))
		print("─────────────────────────────────────────────")

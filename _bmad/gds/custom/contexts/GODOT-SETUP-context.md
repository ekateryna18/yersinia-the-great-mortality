# GODOT SETUP - Godot 4.2 LTS Architecture & Setup Guide

## 🛠️ SETUP INITIAL GODOT 4.2 LTS

### Project Structure Recommandée

```
yersinia-game/
├── scenes/
│   ├── main/
│   │   ├── game_manager.tscn      # Orchestrateur game loop
│   │   └── day_night_manager.tscn # Gestion cycle jour/nuit
│   ├── player/
│   │   ├── player.tscn            # Joueur + attaque
│   │   └── player.gd              # Comportement
│   ├── enemies/
│   │   ├── rat.tscn
│   │   ├── rat_mutant.tscn
│   │   ├── rat_boss.tscn
│   │   └── enemy_ai.gd            # IA commune
│   ├── npcs/
│   │   ├── npc_base.tscn          # Classe de base
│   │   ├── npc_merchant.tscn
│   │   ├── npc_blacksmith.tscn
│   │   ├── npc_wizard.tscn
│   │   └── npc_system.gd          # Gestionnaire PNJ
│   ├── ui/
│   │   ├── hud.tscn               # Combat HUD
│   │   ├── day_menu.tscn          # Menu jour
│   │   ├── dialogue_box.tscn      # Dialogues
│   │   ├── shop_ui.tscn           # Interface commerce
│   │   └── end_screen.tscn        # Fin run
│   └── maps/
│       ├── town_day.tscn          # Ville jour
│       └── outside_night.tscn     # Extérieur nuit
├── scripts/
│   ├── core/
│   │   ├── game_manager.gd        # Orchestrateur principal
│   │   ├── progression_system.gd  # Gloire + stats permanentes
│   │   └── save_system.gd         # Persistance
│   ├── gameplay/
│   │   ├── player.gd
│   │   ├── enemy_ai.gd
│   │   ├── wave_system.gd         # Spawn vagues
│   │   └── combat_system.gd       # Collision + dégâts
│   ├── npcs/
│   │   ├── npc_system.gd
│   │   ├── dialogue_system.gd
│   │   ├── traitor_system.gd      # Génération traîtres
│   │   └── riddle_system.gd       # Énigmes
│   └── ui/
│       ├── menu_manager.gd
│       ├── shop_manager.gd
│       └── hud_manager.gd
├── assets/
│   ├── sprites/
│   │   ├── player/
│   │   ├── enemies/
│   │   ├── npcs/
│   │   └── ui/
│   ├── tilesets/
│   │   ├── town_day.tres
│   │   └── outside_night.tres
│   ├── sounds/ (future MVP++)
│   └── fonts/
│       └── main_font.tres
└── project.godot
```

## 🎮 SCENES CLÉS

### GameManager.gd (Orchestrateur Principal)

```gdscript
extends Node

# States
enum GameState { MENU, DAY, NIGHT, RUN_END }
var current_state = GameState.MENU

# References
@onready var player = $Player
@onready var day_night_manager = $DayNightManager
@onready var npc_system = $NPCSystem
@onready var wave_system = $WaveSystem
@onready var ui_manager = $UIManager

# Run data
var current_run_data = {
    night: 0,
    enemies_killed: 0,
    glory_earned: 0,
    traitors_killed: 0
}

func _ready():
    initialize_run()

func initialize_run():
    current_state = GameState.DAY
    current_run_data.night = 1
    day_night_manager.start_day()
    npc_system.generate_traitors()
    ui_manager.update_night_counter(1)

func _process(delta):
    match current_state:
        GameState.DAY:
            handle_day_logic(delta)
        GameState.NIGHT:
            handle_night_logic(delta)
```

### Player.gd (Joueur)

```gdscript
extends CharacterBody2D

# Movement
@export var speed = 200
var direction = Vector2.ZERO

# Attack
@export var attack_damage = 10
@export var attack_range = 50
var attacking = false
var attack_cooldown = 0

# Stats
var max_hp = 100
var current_hp = 100
var critical_chance = 0.1
var knockback_power = 100

func _process(delta):
    # Input joysticks (mobile)
    handle_movement_input()
    handle_attack_input()
    update_attack_cooldown(delta)

func handle_movement_input():
    # Virtual joystick left (déplacement)
    var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    if input_vector:
        direction = input_vector.normalized()
        velocity = direction * speed
        move_and_slide()

func handle_attack_input():
    # Virtual joystick right (orientation attaque)
    var attack_dir = Input.get_vector("attack_left", "attack_right", "attack_up", "attack_down")
    if attack_dir and attack_cooldown <= 0:
        perform_attack(attack_dir)
        attack_cooldown = 0.5  # 500ms cooldown

func perform_attack(direction: Vector2):
    # Attaque zone 90° devant joueur
    attacking = true
    # TODO: Animation scythe
    
    # Détection ennemis dans zone
    var attack_area = get_attack_area(direction)
    for enemy in attack_area:
        deal_damage(enemy, attack_damage)
        apply_knockback(enemy, direction, knockback_power)
```

### EnemyAI.gd (IA Ennemie)

```gdscript
extends CharacterBody2D

# References
@onready var player = get_tree().get_first_node_in_group("player")

# Stats
@export var max_hp = 30
@export var current_hp = 30
@export var speed = 100
@export var damage = 5
@export var attack_range = 30
@export var detection_range = 200

# State
var current_state = "idle"  # idle, chase, attack

func _process(delta):
    if player == null:
        return
    
    var distance_to_player = global_position.distance_to(player.global_position)
    
    if distance_to_player < attack_range:
        attack_player()
    elif distance_to_player < detection_range:
        chase_player(delta)
    else:
        idle()

func chase_player(delta):
    current_state = "chase"
    var direction = (player.global_position - global_position).normalized()
    velocity = direction * speed
    move_and_slide()

func attack_player():
    current_state = "attack"
    # TODO: Animation attaque
    player.take_damage(damage)

func take_damage(amount: int):
    current_hp -= amount
    if current_hp <= 0:
        die()

func die():
    queue_free()
    emit_signal("enemy_died")
```

### WaveSystem.gd (Système de Vagues)

```gdscript
extends Node

@export var wave_spawn_scene = preload("res://scenes/enemies/rat.tscn")
@onready var spawn_points = $SpawnPoints

var current_night = 1
var enemies_per_wave = 3
var spawn_interval = 30.0  # secondes
var time_until_next_spawn = 0

func _process(delta):
    if GameManager.current_state != GameManager.GameState.NIGHT:
        return
    
    time_until_next_spawn -= delta
    if time_until_next_spawn <= 0:
        spawn_wave()
        time_until_next_spawn = spawn_interval

func spawn_wave():
    var wave_size = calculate_wave_size(current_night)
    for i in range(wave_size):
        var spawn_point = spawn_points.get_child(randi() % spawn_points.get_child_count())
        var enemy = wave_spawn_scene.instantiate()
        enemy.global_position = spawn_point.global_position
        add_child(enemy)

func calculate_wave_size(night: int) -> int:
    var base_sizes = [3, 5, 8, 12, 20]
    return base_sizes[min(night - 1, 4)]
```

### NPCSystem.gd (Gestion PNJ + Traîtres)

```gdscript
extends Node

var all_npcs = []  # Charge depuis scenes
var traitors = []
var honest_npcs = []

func _ready():
    load_all_npcs()

func load_all_npcs():
    # Charge les 7 PNJ + Souris Blanche
    for npc_scene in [
        "res://scenes/npcs/npc_merchant.tscn",
        "res://scenes/npcs/npc_blacksmith.tscn",
        # ... etc
    ]:
        var npc = load(npc_scene).instantiate()
        all_npcs.append(npc)

func generate_traitors():
    # Shuffle et pick 6 PNJ
    var selected = all_npcs.duplicate()
    selected.shuffle()
    selected = selected.slice(0, 6)
    
    # Désigner 2 traîtres
    selected.shuffle()
    traitors = selected.slice(0, 2)
    honest_npcs = selected.slice(2)

func answer_riddle(npc, answer: String) -> Array:
    var correct_names = []
    for traitor in traitors:
        correct_names.append(traitor.name)
    
    if npc in traitors:
        # Traître = mensonge (2 noms aléatoires)
        var false_names = []
        for npc2 in all_npcs:
            if npc2 not in traitors:
                false_names.append(npc2.name)
        false_names.shuffle()
        return false_names.slice(0, 2)
    else:
        # Honnête = vérité
        if answer == "correct":  # TODO: Vérifier réponse réelle
            return correct_names
        else:
            return ["[Réponse attendue]"]
```

## 📊 GAMEPLAY LOOP PSEUDOCODE

```gdscript
# Main game loop (dans GameManager)

while running:
    match game_state:
        "MENU":
            show_main_menu()
            
        "DAY":
            # Jour: Exploration + PNJ
            while not player_clicks_start_night:
                handle_day_interactions()
                update_ui()
            
            game_state = "NIGHT"
            
        "NIGHT":
            # Nuit: Combat + survie
            night_timer = 90 seconds
            while night_timer > 0 and player_alive:
                spawn_waves()
                handle_combat()
                night_timer -= delta
            
            current_night += 1
            
            if current_night > 5:
                game_state = "RUN_END"
            elif player_alive:
                game_state = "DAY"
            else:
                game_state = "DEATH"
                
        "RUN_END":
            calculate_glory()
            persist_permanent_stats()
            show_end_screen()
            game_state = "MENU"
```

## ⚙️ GODOT SETTINGS (project.godot)

```ini
[application]
config/name="Yersinia: The Great Mortality"
config/icon="res://assets/icon.svg"

[rendering]
textures/vram_compression/import_etc2_astc=true
quality/driver/driver_name="OpenGL3"

[input_devices/pointing]
# Touch déjà supporté natif

[physics_2d]
# Garder par défaut pour compatibilité mobile

[debug]
gdscript/warnings/return_value_discarded=false
```

## 📱 MOBILE EXPORT SETTINGS

### Android
```
- Minimum SDK: 21
- Target SDK: 33+
- Orientation: Portrait
- Permissions: INTERNET, WRITE_EXTERNAL_STORAGE
```

### iOS
```
- Minimum version: 12.0+
- Device orientations: Portrait only
- Capability: Game Center (optionnel future)
```

## 🎯 PERFORMANCE TARGETS

- **FPS:** 30 stable (min), 60 idéal
- **Memory:** <200 MB
- **Load time:** <5 sec
- **Profiler to use:** Godot built-in debugger

## ✅ CHECKLIST GODOT SETUP

- [ ] Project créé et versionnée
- [ ] Dossier structure créée
- [ ] GameManager orchestrateur compilable
- [ ] Player déplacement OK
- [ ] Ennemi basique avec IA
- [ ] Vagues spawn automatique
- [ ] Jour/Nuit cycle fonctionne
- [ ] PNJ système chargeable
- [ ] Mobile build exportable
- [ ] Touch inputs mappés

---

**Godot 4.2 LTS = stabilité production + features suffisantes pour MVP.**

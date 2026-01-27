# 📋 YERSINIA INSTANCES - Configuration Spécifique des Objets

**Date:** 2026-01-27  
**Status:** ✅ Prêt pour création scenes Godot  
**Guide d'utilisation:** Référence pour créer chaque instance

---

## 👤 JOUEUR

### Stats Configuration
```gdscript
# À assigner dans l'éditeur Godot
base_hp = 100
base_damage = 10
base_speed = 150.0
base_crit_chance = 0.1
base_knockback = 100.0

# Bonus permanents (sauvegardés inter-runs)
permanent_hp_bonus = 0         # Commence à 0, augmente via Wizard
permanent_damage_bonus = 0
permanent_speed_bonus = 0.0
permanent_crit_bonus = 0.0
permanent_knockback_bonus = 0.0
```

### Attaque Configuration
```gdscript
attack_range = 50.0           # Portée faux
attack_arc = PI * 0.5         # 90° d'arc
attack_cooldown = 0.5         # 0.5 sec entre attaques
attack_radius = 40.0          # Rayon hit detection
```

### Instance Godot
```
PlayerScene.tscn
├── CharacterBody2D (Player script)
│   ├── Sprite2D (joueur spritesheet)
│   ├── CollisionShape2D (hitbox)
│   ├── AnimationPlayer
│   │   ├── Anim: idle (loop)
│   │   ├── Anim: walk (loop)
│   │   ├── Anim: attack (oneshot)
│   │   ├── Anim: hurt (oneshot)
│   │   └── Anim: die (oneshot)
│   ├── Area2D (hit_detection_area)
│   │   └── CollisionShape2D (CircleShape2D r=40)
│   └── [Joystick UI nodes - voir UIManager]
```

---

## 🧑‍🤝‍🧑 PNJ INSTANCES

### 1. MARCHAND (Merchant)
```gdscript
# Configuration
npc_type = NPC.NPCType.MERCHANT
npc_name = "Merchant"
dialogue_key = "npc_merchant"
base_hp = 50

# Items vendus
inventory = ["potion_health", "potion_speed", "potion_strength", "potion_knockback"]

# Prix base
potion_health_cost = 50
potion_speed_cost = 60
potion_strength_cost = 75
potion_knockback_cost = 50
```

### 2. FORGERON (Blacksmith)
```gdscript
# Configuration
npc_type = NPC.NPCType.BLACKSMITH
npc_name = "Blacksmith"
dialogue_key = "npc_blacksmith"
base_hp = 50

# Améliorations faux
scythe_damage_cost = [80, 160]      # Level 1, 2
scythe_knockback_cost = [70, 140]
```

### 3. MAGICIEN (Wizard)
```gdscript
# Configuration
npc_type = NPC.NPCType.WIZARD
npc_name = "Wizard"
dialogue_key = "npc_wizard"
base_hp = 40  # Fragilité

# Coût stats permanentes (bons points vs mauvais points)
hp_cost_good = 30        # Good points
hp_cost_bad = 20         # Bad points
damage_cost_good = 35
damage_cost_bad = 25
speed_cost_good = 40
speed_cost_bad = 30
crit_cost_good = 50
crit_cost_bad = 35
```

### 4. PNJ MALADE (Sick)
```gdscript
# Configuration
npc_type = NPC.NPCType.SICK
npc_name = "Sick NPC"
dialogue_key = "npc_sick"
is_sick = true
base_hp = 20  # Très fragile

# Bonus si soigné
heal_bonus_glory = 100
heal_bonus_price_reduction = -0.1  # -10% prix tous PNJ
```

### 5. PNJ GÉNÉRIQUES (Generic)
```gdscript
# Configuration variable
npc_type = NPC.NPCType.GENERIC
npc_name = "Wanderer"  # Peut varier
dialogue_key = "npc_generic"
base_hp = 50

# Pour variété du jeu
# Peut être honnête ou traître
```

### 6. SOURIS BLANCHE (Mouse Helper)
```gdscript
# Configuration
npc_type = NPC.NPCType.MOUSE_HELPER
npc_name = "White Mouse"
dialogue_key = "npc_mouse"
base_hp = 5  # Très fragile

# Fonction spéciale
treasure_finder = true
```

### Instance Godot (PNJ)
```
NPCScene.tscn (Template)
├── CharacterBody2D (NPC script)
│   ├── Sprite2D (portrait PNJ)
│   ├── CollisionShape2D (hitbox)
│   ├── AnimationPlayer
│   │   ├── Anim: idle (loop)
│   │   └── Anim: hurt (oneshot)
│   └── Area2D (interaction_area)
│       └── CollisionShape2D (CircleShape2D r=60)
```

---

## 👹 ENNEMI INSTANCES

### RAT (Basique)
```gdscript
# Configuration
enemy_type = Enemy.EnemyType.RAT
base_hp = 15
base_damage = 3
base_speed = 120.0
base_crit_chance = 0.05
base_knockback = 50.0

# IA
detection_range = 200.0
chase_range = 300.0
attack_range_enemy = 35.0
attack_cooldown_enemy = 1.2

# Récompense
glory_reward = 10
```

### RAT MUTANT (Moyen)
```gdscript
# Configuration
enemy_type = Enemy.EnemyType.RAT_MUTANT
base_hp = 25
base_damage = 6
base_speed = 150.0
base_crit_chance = 0.1
base_knockback = 70.0

# IA
detection_range = 200.0
chase_range = 300.0
attack_range_enemy = 40.0
attack_cooldown_enemy = 0.9

# Récompense
glory_reward = 25
```

### RAT BOSS (Nuit 5)
```gdscript
# Configuration
enemy_type = Enemy.EnemyType.RAT_BOSS
base_hp = 100
base_damage = 12
base_speed = 140.0
base_crit_chance = 0.15
base_knockback = 100.0

# IA
detection_range = 250.0    # Plus de détection
chase_range = 350.0        # Plus agressif
attack_range_enemy = 50.0
attack_cooldown_enemy = 0.6  # Plus rapide

# Récompense
glory_reward = 200         # Énorme récompense
```

### Instance Godot (Ennemi)
```
EnemyScene.tscn (Prefab poolable)
├── CharacterBody2D (Enemy script)
│   ├── Sprite2D (rat spritesheet)
│   ├── CollisionShape2D (hitbox)
│   ├── AnimationPlayer
│   │   ├── Anim: idle (loop)
│   │   ├── Anim: chase (loop)
│   │   ├── Anim: attack (oneshot)
│   │   ├── Anim: hurt (oneshot)
│   │   └── Anim: die (oneshot)
│   └── Area2D (detection_area)
│       └── CollisionShape2D (CircleShape2D r=200)
```

---

## 🔄 CYCLE JOUR/NUIT CONFIGURATION

### DayNightCycleManager
```gdscript
day_duration = 60.0        # 60 sec jour
night_duration = 90.0      # 90 sec nuit (GDD: 45-90)
total_nights = 5           # 5 nuits pour gagner

# Courbe difficulté
difficulty_curve = [1.0, 1.2, 1.4, 1.6, 1.8]

spawn_interval = 15.0      # Spawn tous les 15 sec (tune)
enemies_per_spawn = 1      # 1 ennemi par spawn
max_enemies_on_screen = 15 # Max 15 ennemis à la fois

# Zones de spawn
spawn_locations = [
    Vector2(50, 50),       # Top-left
    Vector2(1230, 50),     # Top-right
    Vector2(50, 710),      # Bottom-left
    Vector2(1230, 710)     # Bottom-right
]
```

### EnemySpawner Configuration
```gdscript
enemy_scene = preload("res://scenes/enemies/enemy.tscn")
pool_size = 30             # 30 ennemis en pool

# Zones identiques au manager
spawn_zones = [
    Vector2(50, 50),
    Vector2(1230, 50),
    Vector2(50, 710),
    Vector2(1230, 710)
]
```

---

## 📊 DIFFICULTY SCALING DÉTAIL

### Nuit 1 (x1.0)
```
Rat:       HP=15,  DMG=3,  SPD=120,  CRIT=5%,   KB=50
Mutant:    HP=25,  DMG=6,  SPD=150,  CRIT=10%,  KB=70
Spawn:     ~1 ennemi/15sec = ~6 ennemis/90sec
Estimé:    ~4-6 ennemis actifs
```

### Nuit 2 (x1.2)
```
Rat:       HP=18,  DMG=3.6, SPD=144,  CRIT=7%,   KB=60
Mutant:    HP=30,  DMG=7.2, SPD=180,  CRIT=12%,  KB=84
Spawn:     ~1.1 ennemis/15sec
Estimé:    ~6-8 ennemis actifs
```

### Nuit 3 (x1.4)
```
Rat:       HP=21,  DMG=4.2, SPD=168,  CRIT=9%,   KB=70
Mutant:    HP=35,  DMG=8.4, SPD=210,  CRIT=14%,  KB=98
Spawn:     ~1.2 ennemis/15sec
Estimé:    ~8-10 ennemis actifs
```

### Nuit 4 (x1.6)
```
Rat:       HP=24,  DMG=4.8, SPD=192,  CRIT=11%,  KB=80
Mutant:    HP=40,  DMG=9.6, SPD=240,  CRIT=16%,  KB=112
Spawn:     ~1.3 ennemis/15sec
Estimé:    ~10-12 ennemis actifs
```

### Nuit 5 (x1.8) - BOSS
```
Rat:       HP=27,  DMG=5.4, SPD=216,  CRIT=13%,  KB=90
Mutant:    HP=45,  DMG=10.8,SPD=270,  CRIT=18%,  KB=126
Boss:      HP=180, DMG=21.6,SPD=252,  CRIT=27%,  KB=180
Spawn:     ~1.4 ennemis/15sec (mais beaucoup plus)
Estimé:    ~15+ ennemis actifs + 1 Boss
```

---

## 💰 ECONOMY REFERENCE

### Glory Gains (Per Run)
```
Kill Rat:          +10 glory
Kill Rat Mutant:   +25 glory
Kill Rat Boss:     +200 glory
Survive Night:     +50 + (night * 10)
  Night 1: +60
  Night 2: +70
  Night 3: +80
  Night 4: +90
  Night 5: +100 (+ Boss bonus si tué)
```

### Glory Spending (Wizard)
```
HP Upgrade:        30 good points OR 20 bad points → +5 HP
Damage Upgrade:    35 good points OR 25 bad points → +3 DMG
Speed Upgrade:     40 good points OR 30 bad points → +5% SPD
Crit Upgrade:      50 good points OR 35 bad points → +5% CRIT
```

### Price Dynamics
```
Base: 50 gloire
Après attaque innocente: 50 * 1.2 = 60 gloire
Après 2 attaques innocentes: 50 * 1.4 = 70 gloire
Après soigner malade: 50 * 0.9 = 45 gloire
```

---

## 🎬 CRÉATION SCENE CHECKLIST

### Step 1: Créer PlayerScene
- [ ] Créer node CharacterBody2D, assigner script Player
- [ ] Ajouter Sprite2D, importer spritesheet joueur
- [ ] Ajouter CollisionShape2D (CapsuleShape2D 32x64)
- [ ] Ajouter AnimationPlayer, créer animations (idle, walk, attack, hurt, die)
- [ ] Ajouter Area2D enfant (hit_detection_area), ajouter CircleShape2D r=40
- [ ] Tester en F5

### Step 2: Créer NPCScene (Template)
- [ ] Créer node CharacterBody2D, assigner script NPC
- [ ] Ajouter Sprite2D (portrait PNJ)
- [ ] Ajouter CollisionShape2D
- [ ] Ajouter AnimationPlayer (idle, hurt)
- [ ] Ajouter Area2D (interaction_area), CircleShape2D r=60
- [ ] Dupliquer 6x pour Merchant, Blacksmith, Wizard, Generic, Sick, Mouse

### Step 3: Créer EnemyScene (Prefab)
- [ ] Créer node CharacterBody2D, assigner script Enemy
- [ ] Ajouter Sprite2D (rat spritesheet)
- [ ] Ajouter CollisionShape2D
- [ ] Ajouter AnimationPlayer (idle, chase, attack, hurt, die)
- [ ] Ajouter Area2D (detection_area), CircleShape2D r=200
- [ ] Sauvegarder en tant que Prefab (ressource réutilisable)

### Step 4: Créer GameScene (Main)
- [ ] Créer node Node2D
- [ ] Ajouter instance PlayerScene
- [ ] Ajouter NPCManager avec instances PNJ
- [ ] Ajouter DayNightCycleManager (script)
- [ ] Ajouter EnemySpawner (script), assigner enemy prefab
- [ ] Ajouter UIManager pour HUD
- [ ] Configurer groupes ("player", "pnj", "enemies", "game_manager", "ui_manager")
- [ ] Tester en F5

---

## 🧪 TEST CHECKLIST

### Unit Tests (Player)
- [ ] Attaque détecte ennemis dans arc 90°
- [ ] Dégâts appliqués correctement
- [ ] Knockback appliqué et décay
- [ ] Stats permanentes persistées
- [ ] Mort → Game Over

### Unit Tests (PNJ)
- [ ] Merchant vend items (prix corrects)
- [ ] Blacksmith améliore faux
- [ ] Wizard améliore stats permanentes
- [ ] Traitor system fonctionne
- [ ] Prix augmente après attaque innocente

### Unit Tests (Enemy)
- [ ] IA détecte joueur (200 pixels)
- [ ] IA chasse joueur (300 pixels)
- [ ] Attaque applique dégâts + knockback
- [ ] Difficulty scaling appliqué
- [ ] Pooling fonctionne (30 ennemis)

### Integration Tests
- [ ] Cycle jour/nuit complet (60+90 sec)
- [ ] 5 nuits survécues = victoire
- [ ] Difficulty augmente chaque nuit
- [ ] Spawn fonctionne (15 sec intervals)
- [ ] Max 15 ennemis respectés
- [ ] Performance: 30 FPS stable

---

## 📱 MOBILE SPECIFIC

### Joystick Virtuel (Input)
```gdscript
# Left stick → Movement
# Right stick → Attack direction

func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch or InputEventScreenDrag:
        # Detect left/right joystick position
        player.set_left_stick(left_stick_input)
        player.set_right_stick(right_stick_input)
```

### Resolution Target
```
Viewport: 1280x800 (16:10 ratio)
Export Android: min SDK 24, target SDK 33
Export iOS: min iOS 12.0
```

---

## ⚠️ COMMON PITFALLS

1. **Knockback not decaying:** Check knockback_decay = 0.95 in BaseCharacter
2. **Attack not hitting enemies:** Verify CircleShape2D radius = 40 in hit_detection_area
3. **Difficulty not scaling:** Check apply_difficulty_scaling() is called in spawner
4. **PNJ not visible in day:** Check is_day flag in DayNightCycleManager
5. **Pooling creating garbage:** Ensure reset_for_pooling() called, not instantiate()

---

**Document Version:** 1.0  
**Last Updated:** 2026-01-27  
**Next:** Create scenes in Godot editor & test

# 🔧 BUGFIX-GDD-001 - Correction Erreurs Autoload Game_Manager

**Story ID:** BUGFIX-GDD-001  
**Title:** Fix Game_Manager Type Assignment Errors  
**Priority:** P1 (Blocker - GDD-001 non-fonctionnel)  
**Status:** ✅ READY-TO-DEV  
**Severity:** Critical  
**Hours:** 1h  

---

## 🐛 ERREURS IDENTIFIÉES

### Erreur Principale (2 occurrences)
```
ERROR: res://scenes/main.gd:10 - Parse Error: Value of type "Game_Manager" cannot be assigned to a variable of type "Game_Manager".
ERROR: res://systems/player_controller.gd:19 - Parse Error: Value of type "Game_Manager" cannot be assigned to a variable of type "Game_Manager".
```

### Root Cause
Le problème vient d'une **incompatibilité Godot 4.x avec les autoloads typés**.

Quand tu accèdes à un autoload comme `Game_Manager`, Godot retourne:
- Une instance `Node` (pas une instance de la classe `Game_Manager`)
- Le type retourné n'est pas assignable à une variable typée `Game_Manager`

### Code Problématique
```gdscript
# WRONG (cause l'erreur):
var game_manager: Game_Manager = Game_Manager

# Pourquoi ça marche pas:
# Game_Manager (autoload) retourne Node, pas Game_Manager
# La variable attend Game_Manager
# Type mismatch → Parse Error
```

---

## ✅ SOLUTIONS

### Solution 1: Accéder directement à l'autoload (RECOMMANDÉE)
```gdscript
# Ne pas créer de variable locale
# Utiliser directement Game_Manager partout

# AVANT (WRONG):
var game_manager: Game_Manager
func _ready():
    game_manager = Game_Manager
    game_manager.run_state.night

# APRÈS (CORRECT):
func _ready():
    Game_Manager.run_state.night  # Direct access
```

**Avantages:**
- ✅ Pas de type mismatch
- ✅ Autoload persiste automatiquement
- ✅ Accès simple partout: `Game_Manager.run_state`
- ✅ Standard Godot 4 pattern

---

## 📝 FICHIERS À CORRIGER

### Fichier 1: res://scenes/main.gd
**Ligne 10:** Supprimer variable locale, utiliser `Game_Manager` directement

```gdscript
# AVANT (WRONG):
extends Node2D

var game_manager: Game_Manager

func _ready():
	game_manager = Game_Manager  # ← Parse Error ici
	print("[MAIN] Run state: Night %d" % game_manager.run_state.night)

# APRÈS (CORRECT):
extends Node2D

func _ready():
	print("[MAIN] Run state: Night %d" % Game_Manager.run_state.night)
	print("[MAIN] Phase: %s" % Game_Manager.run_state.current_phase)
	
	# Verify player exists
	var player = get_node("Day/Player")
	if player:
		print("[MAIN] Player found at position: %s" % player.global_position)
	
	# Log startup
	Game_Manager.run_state.log_state("Main scene ready, Day 1 active")
```

---

### Fichier 2: res://systems/player_controller.gd
**Ligne 19:** Supprimer variable locale, utiliser `Game_Manager` directement

```gdscript
# AVANT (WRONG):
extends CharacterBody2D

const SPEED = 150.0
const ATTACK_RANGE = 50.0

var game_manager: Game_Manager  # ← Parse Error ici
var current_hp: int = 100
var max_hp: int = 100

func _ready():
	game_manager = Game_Manager  # ← Parse Error ici
	game_manager.run_state.player_position = global_position

# APRÈS (CORRECT):
extends CharacterBody2D

const SPEED = 150.0
const ATTACK_RANGE = 50.0

var current_hp: int = 100
var max_hp: int = 100

func _ready():
	# Store initial position as run state (use Game_Manager directly)
	Game_Manager.run_state.player_position = global_position
	
	# Debug output
	print("[PLAYER] Spawned at position: %s" % global_position)
	print("[PLAYER] HP: %d/%d" % [current_hp, max_hp])

func _physics_process(delta):
	# Get input (mobile joystick or keyboard)
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Calculate velocity
	velocity = input_vector.normalized() * SPEED
	
	# Apply physics movement
	move_and_slide()
	
	# Update run state position (use Game_Manager directly)
	Game_Manager.run_state.player_position = global_position
```

---

## 🎯 ACCEPTANCE CRITERIA

- [ ] AC1: main.gd no longer references `var game_manager: Game_Manager`
- [ ] AC2: main.gd uses `Game_Manager.run_state` directly
- [ ] AC3: player_controller.gd no longer references `var game_manager: Game_Manager`
- [ ] AC4: player_controller.gd uses `Game_Manager.run_state` directly
- [ ] AC5: No parse errors in console after fixes
- [ ] AC6: Game starts without errors (can call F1 debug)

---

## 📋 IMPLEMENTATION STEPS

### Step 1: Fix main.gd
1. Open `res://scenes/main.gd`
2. Remove line: `var game_manager: Game_Manager`
3. Remove line: `game_manager = Game_Manager`
4. Replace all `game_manager.` with `Game_Manager.`
5. Save file

### Step 2: Fix player_controller.gd
1. Open `res://systems/player_controller.gd`
2. Remove line: `var game_manager: Game_Manager`
3. Remove line: `game_manager = Game_Manager`
4. Replace all `game_manager.` with `Game_Manager.`
5. Save file

### Step 3: Test
1. Close Godot editor completely
2. Reopen project
3. Check console: should have NO parse errors
4. Press Play (F5)
5. Verify game starts successfully
6. Press F1: should show debug info (no errors)

---

## ✅ VALIDATION

After fixes, console should show:
```
[GAME MANAGER] Starting...
[GAME MANAGER] RunState created
[RUN STATE DEBUG]
Night: 1 / 5
Phase: DAY
Player Alive: true
Gloire: 0
[MAIN] Main scene loaded
[MAIN] Run state: Night 1
[MAIN] Phase: DAY
[PLAYER] Spawned at position: (640, 360)
[PLAYER] HP: 100/100
```

**No errors should appear** ✅

---

## 🔍 WHY THIS ERROR HAPPENED

### Godot 4.x Autoload Behavior
```
1. You define: class_name Game_Manager
2. You configure: [autoload] Game_Manager="res://systems/game_manager.gd"
3. When accessed: Game_Manager returns the Node instance (not the class)
4. Type system sees:
   - Variable expects: Game_Manager (the class)
   - Autoload returns: Node (the instance)
   - Type mismatch → Parse Error
```

### Best Practice (Godot 4)
```gdscript
# ✅ CORRECT PATTERN:
# In autoload script, use class_name
# Then access directly without type hints

# game_manager.gd:
extends Node
class_name Game_Manager

# In other scripts:
func _ready():
    Game_Manager.initialize_run()  # Direct access, no variable
```

---

## 📊 IMPACT

### What This Fixes
- ✅ Parse errors in main.gd (line 10)
- ✅ Parse errors in player_controller.gd (line 19)
- ✅ LSP (Language Server Protocol) errors
- ✅ Script loading failures
- ✅ Game unable to start

### What This Doesn't Break
- ✅ Game_Manager still works as autoload
- ✅ RunState still persists
- ✅ All functionality remains the same
- ✅ Performance unchanged
- ✅ No breaking changes

---

## 🚀 AFTER FIX

Once corrected:
- ✅ GDD-001 will be fully functional
- ✅ No parse errors
- ✅ Game can start successfully
- ✅ Ready to move to GDD-002
- ✅ Foundation solid for all future stories

---

## 📝 CORRECTED FILES (Ready to Copy-Paste)

### Corrected main.gd
```gdscript
# main.gd
# Main scene coordinator

extends Node2D

func _ready():
	"""Initialize main scene"""
	
	print("[MAIN] Main scene loaded")
	print("[MAIN] Run state: Night %d" % Game_Manager.run_state.night)
	print("[MAIN] Phase: %s" % Game_Manager.run_state.current_phase)
	
	# Verify player exists
	var player = get_node("Day/Player")
	if player:
		print("[MAIN] Player found at position: %s" % player.global_position)
	
	# Log startup
	Game_Manager.run_state.log_state("Main scene ready, Day 1 active")
```

### Corrected player_controller.gd
```gdscript
# player_controller.gd
# Player movement and state management

extends CharacterBody2D

const SPEED = 150.0  # Pixels per second
const ATTACK_RANGE = 50.0

var current_hp: int = 100
var max_hp: int = 100

# Input tracking
var input_vector: Vector2 = Vector2.ZERO

func _ready():
	"""Initialize player"""
	
	# Store initial position as run state
	Game_Manager.run_state.player_position = global_position
	
	# Debug output
	print("[PLAYER] Spawned at position: %s" % global_position)
	print("[PLAYER] HP: %d/%d" % [current_hp, max_hp])

func _physics_process(delta):
	"""Handle movement each frame"""
	# Get input (mobile joystick or keyboard)
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Calculate velocity
	velocity = input_vector.normalized() * SPEED
	
	# Apply physics movement
	move_and_slide()
	
	# Update run state position
	Game_Manager.run_state.player_position = global_position

func take_damage(damage: int):
	"""Player takes damage"""
	current_hp -= damage
	print("[PLAYER] Damage taken: %d (HP: %d/%d)" % [damage, current_hp, max_hp])
	
	# Visual feedback (to add in GDD-004)
	
	# Check death
	if current_hp <= 0:
		die()

func die():
	"""Player dies"""
	print("[PLAYER] DEAD!")
	Game_Manager.run_state.player_dies()
	# Trigger Game Over screen (to implement in GDD-004)
	# visible = false

func heal(amount: int):
	"""Player heals"""
	current_hp = min(current_hp + amount, max_hp)
	print("[PLAYER] Healed: %d (HP: %d/%d)" % [amount, current_hp, max_hp])

func get_position_for_attack() -> Vector2:
	"""Get player center position for attack zone calculation"""
	return global_position

func get_debug_info() -> String:
	"""Debug info"""
	return "[PLAYER] HP: %d/%d | Pos: %s" % [current_hp, max_hp, global_position]
```

---

## 🎯 SIGN-OFF

**Bug:** Value of type "Game_Manager" cannot be assigned to variable of type "Game_Manager"  
**Root Cause:** Autoload type mismatch in Godot 4.x  
**Solution:** Use Game_Manager directly, no local variable needed  
**Complexity:** Low (simple fix)  
**Time:** 1 hour  
**Risk:** None (no breaking changes)  
**Status:** ✅ **READY FOR IMPLEMENTATION**

---

*Bug Fix Story: BUGFIX-GDD-001*  
*Created by: Agent PM Yersinia*  
*Priority: P1 Blocker*  
*Ready for: yersinia-gameplay-programmer to implement*


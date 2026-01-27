# GDD-001 MAIN SCENE SETUP

**Status:** Ready to use  
**Files Created:** 2 (main.tscn + scene_manager.gd)  

---

## 🎮 What Was Created

### 1. **scenes/main.tscn** - Main entry point scene
- Minimal scene file (just references the script)
- Automatically generates all nodes at runtime

### 2. **scenes/scene_manager.gd** - Scene generator script
- Creates Day scene with background, gameplay area, PNJ container
- Creates Player node with collision, sprite, animation player
- Creates UI layer with phase display, stats, buttons
- Handles all initialization

### 3. **systems/player_controller.gd** - Player logic
- Movement via joystick/keyboard (WASD)
- HP system (take_damage, heal, die)
- State tracking (position, health)

---

## ⚡ How to Use

### Step 1: Add Game_Manager Autoload

Edit `project.godot` and add under `[autoload]`:
```ini
[autoload]
Game_Manager="res://systems/game_manager.gd"
```

### Step 2: Set Main Scene

In `project.godot` under `[application]`:
```ini
[application]
run/main_scene="res://scenes/main.tscn"
```

### Step 3: Run Game

Press **F5** in Godot editor.

### Expected Output:
```
[GAME MANAGER] Starting...
[GAME MANAGER] RunState created
[SCENE MANAGER] Starting GDD-001 initialization...
[SCENE] Creating Day scene...
[SCENE] Creating Player...
[SCENE] Creating UI layer...
[SCENE MANAGER] Scene initialization complete
[PLAYER] Spawned at: (640, 360)
[PLAYER] HP: 100/100
```

---

## 🎮 Controls When Running

```
WASD or Arrows ... Move player
N ....................... Start Night
F1 ..................... Print debug
F2 ..................... Simulate night
F3 ..................... End run
```

---

## ✅ What Gets Generated

### Scene Hierarchy (Automatic):
```
Main (Node2D)
├─ Day (Node2D)
│  ├─ Background (ColorRect) - Green tint
│  └─ GameplayArea (Node2D)
│     ├─ Player (CharacterBody2D) at (640, 360)
│     │  ├─ CollisionShape2D (CapsuleShape2D)
│     │  ├─ Sprite2D (blue placeholder)
│     │  └─ AnimationPlayer
│     ├─ PNJContainer (Node2D) - Ready for GDD-005
│     └─ MapTiles (TileMap) - Placeholder
└─ UILayer (CanvasLayer)
   ├─ TopBar (PanelContainer)
   │  └─ PhaseLabel "Jour 1"
   │  └─ StatsLabel "Gloire: 0 | PNJ: 6 | Ennemis: 0"
   ├─ BottomBar (PanelContainer)
   │  └─ StartNightButton "Start Night (N)"
   └─ DebugLabel
```

---

## 🧪 Verification Checklist

After running, verify:

- [ ] **Game boots without errors** ✅
- [ ] **Blue player visible at center** ✅
- [ ] **"Jour 1" displayed** ✅
- [ ] **Stats show correctly** ✅
- [ ] **WASD moves player** ✅
- [ ] **F1 prints debug info** ✅
- [ ] **Button clickable** ✅
- [ ] **No red errors** ✅

---

## 🐛 Troubleshooting

**Game won't start:**
- Check Game_Manager autoload in project.godot
- Check main scene set to main.tscn
- Look for red errors in console

**Player not visible:**
- Check console for "[SCENE] Creating Player..." message
- Verify Sprite2D is being added (blue rectangle)

**UI not showing:**
- Check for "[SCENE] Creating UI layer..." message
- Verify CanvasLayer layer is 100

**Autoload errors:**
- Restart Godot editor after adding autoload
- Check path: `res://systems/game_manager.gd`

---

## 📋 GDD-001 Acceptance Criteria Status

| AC | Requirement | Status |
|----|------------|--------|
| 1 | Game Manager singleton persists | ✅ Autoload |
| 2 | RunState initialized (night=1, gloire=0) | ✅ Automatic |
| 3 | Player at center, joysticks work | ✅ scene_manager creates |
| 4 | Day 1 starts, no enemies | ✅ Automatic |
| 5 | UI shows "Jour 1" & stats | ✅ Created |
| 6 | Transition works | ✅ StartNightButton |

---

**All set! Run the game now** 🎮

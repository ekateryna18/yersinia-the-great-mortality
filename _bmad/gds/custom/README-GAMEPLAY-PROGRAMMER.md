# 🚀 QUICK START - Gameplay Programmer Agent

**Agent:** yersinia-gameplay-programmer  
**Role:** Senior Gameplay Programmer / Implementation Lead  
**Duration:** Days 1-2 (16-18 hours for 4 stories)  
**Target:** Implement GDD-001 through GDD-004 with all AC passing  

---

## ⚡ 30-SECOND OVERVIEW

This agent is a **Godot 4.2 expert** who implements the 4 core gameplay loop stories planned by the PM:

1. **GDD-001** - Game Manager setup (3h)
2. **GDD-002** - Day phase exploration (4h)
3. **GDD-003** - Wave manager spawning (5h)
4. **GDD-004** - Night phase combat loop (4h)

**Job:** Deliver production-ready GDScript code with all AC passing, FPS ≥30, no memory leaks.

---

## 🎯 5-MINUTE START

### Step 1: Load the Agent
```
@agent yersinia-gameplay-programmer
```

### Step 2: Pick a Story
```
@agent yersinia-gameplay-programmer
Implémenter GDD-001 (Game Manager & Run Initialization)
```

### Step 3: Get Code
Agent delivers:
- ✅ Complete GDScript (production-ready)
- ✅ Scene structure (how to organize tscn)
- ✅ Validation steps (how to test AC)
- ✅ Debug tips (FPS profiling, state logging)

### Step 4: Integrate & Test
1. Copy GDScript to project
2. Add autoload to project.godot
3. Test each AC
4. Profile FPS & memory
5. Move to next story

---

## 📋 QUICK COMMAND REFERENCE

```
## Implement Stories
@impl GDD-001                → Full GDD-001 implementation
@impl GDD-001 phase 1        → Just the setup phase
@code [pattern]              → Generate code pattern (e.g., "autoload", "pooling")

## Debug Issues
@debug joystick lag          → Why is input delayed?
@profile night phase         → Is FPS dropping?
@validate GDD-001            → Does this meet all AC?

## Code Quality
@review [your code]          → Code review & suggestions
@optimize [system]           → Make it faster
@check-memory                → Any leaks?

## Escalate Problems
@blockers                    → What's blocking progress?
@escalate [issue]            → Need PM help
```

---

## 🎮 WHAT YOU GET (Per Story Implementation)

### For Each Story:
1. **Complete GDScript files** (copy-paste ready)
2. **Scene layout** (tscn structure)
3. **Integration points** (how it connects to other stories)
4. **Validation steps** (how to test AC)
5. **Debug hints** (if something breaks, check X)
6. **Performance checklist** (FPS, memory, load times)

### Example: GDD-001 Deliverable
```
✅ Game_Manager.gd (complete singleton)
✅ RunState class definition
✅ Player spawn logic
✅ Joystick initialization
✅ project.godot setup instructions
✅ Validation: "RunState persists across scenes" (testable)
```

---

## 📊 STORIES OVERVIEW

### GDD-001: Game Manager (3 hours)
**What:** Create the global game manager that holds run state  
**Why:** Foundation - everything else depends on this  
**AC:** Manager persists, run state initialized, player spawned, Day 1 starts  
**Complexity:** Medium  
**Risk:** Low (standard Godot pattern)  

### GDD-002: Day Phase (4 hours)
**What:** Implement exploration, PNJ interaction, "Start Night" button  
**Why:** Players need to explore and interact before combat  
**AC:** Player moves smoothly, PNJ visible, dialogue opens, transition works  
**Complexity:** Medium  
**Risk:** Low (standard input/movement)  

### GDD-003: Wave Manager (5 hours)
**What:** Implement continuous enemy spawning (not discrete waves)  
**Why:** Core combat loop - enemies spawning is what makes Survivor Roguelike  
**AC:** Spawn algorithm continuous, progression per night, ≥30 FPS with 50 enemies  
**Complexity:** High  
**Risk:** High - FPS drops likely (mitigate with object pooling)  

### GDD-004: Night Phase (4 hours)
**What:** Implement timer, combat loop, Game Over, retry  
**Why:** Completes the full game loop - players can now survive or die  
**AC:** Timer counts, enemies spawn, player attacks work, Game Over saves gloire  
**Complexity:** Medium  
**Risk:** Medium - state management at Game Over  

---

## 🔄 TYPICAL WORKFLOW

### 1. Request Story Implementation
```
@agent yersinia-gameplay-programmer
Implémenter GDD-001
```

### 2. Agent Analyzes
- Loads AC from story
- Identifies risks & mitigations
- Plans implementation phases
- Gathers required assets

### 3. Agent Delivers Code
```gdscript
# Example output
## Game_Manager.gd - Production ready

extends Node
class_name Game_Manager

var run_state: RunState

func _ready():
    run_state = RunState.new()
    # ... initialization logic
```

### 4. You Integrate
1. Copy code to Godot project
2. Update project.godot (autoloads, etc.)
3. Create scenes (Player.tscn, etc.)
4. Test against AC
5. Profile FPS & memory

### 5. Validate & Move On
- [ ] All AC passing
- [ ] FPS target met
- [ ] No errors in console
- [ ] Ready for next story

---

## ⚠️ KEY RISKS (Know These!)

| Story | Risk | Fix |
|-------|------|-----|
| GDD-001 | Autoload not persisting | Use standard Godot [autoload] in project.godot |
| GDD-002 | Input lag on mobile | Use `_physics_process()`, not `_process()` |
| GDD-003 | FPS drops <30 | Use object pooling, profile with Godot debugger |
| GDD-004 | Game Over state bugs | Log state changes, test on real device |

---

## 🎮 GAME CONTEXT YOU NEED TO KNOW

**Survivor Roguelike 2D (Hack'Slash with waves):**
- **Not Tower Defense** - Player is mobile action hero, not stationary tower
- **Continuous spawning** - Enemies spawn continuously (like Vampire Survivors), not in discrete "waves"
- **Mobile-first** - Target: Android mid-range, ≥30 FPS, <200MB memory
- **5-night loop** - Each night is 90 seconds of continuous combat
- **Gloire persistence** - Points earned persist between runs (saved locally)

**Performance Targets:**
- Day phase: ≥60 FPS (exploration is smooth)
- Night phase: ≥30 FPS (combat with 50 enemies)
- Load time: <2 seconds
- Memory: <200MB

---

## 📈 SUCCESS = ALL AC PASSING

Each story has **Acceptance Criteria** (AC). Your job:

1. **Implement feature**
2. **Test each AC** (checkbox-by-checkbox)
3. **Profile performance** (FPS, memory)
4. **No AC left unchecked** = Story complete

**Example AC check (GDD-001):**
```
✅ AC1: Game Manager singleton created, persists between scenes
   → Test: Load scene A, load scene B, Game_Manager still exists
   
✅ AC2: RunState initialized (night=1, player_alive=true, gloire=0)
   → Test: Check Game_Manager.run_state.night == 1
   
✅ AC3: Player spawned at scene center
   → Test: Player position == scene center
   
✅ AC4: Joysticks visible & responsive
   → Test: Move left joystick, player moves
```

---

## 🔧 GODOT 4.2 ESSENTIALS

### 1. Autoload (Global Singletons)
```gdscript
# In project.godot:
[autoload]
Game_Manager="res://systems/game_manager.gd"

# Usage anywhere in project:
Game_Manager.run_state.night = 2
```

### 2. Scene Transitions (Keeping State)
```gdscript
# State persists because Game_Manager is autoload
get_tree().change_scene_to_file("res://scenes/night.tscn")
```

### 3. Mobile Input (Physics-based)
```gdscript
func _physics_process(delta):
    var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    velocity = input.normalized() * SPEED
    move_and_slide()  # Physics-based = smoother than position += velocity
```

### 4. Object Pooling (Avoid GC Spikes)
```gdscript
# Reuse enemy instances instead of creating new ones
pool.get_instance("rat")  # Returns pooled rat, or creates new if none available
```

### 5. Performance Profiling
```gdscript
func _ready():
    # Enable FPS counter in top-left
    Engine.time_scale = 1.0  # Normal speed
    
func _process(delta):
    # Check FPS in debugger
    print("FPS: %d" % Engine.get_frames_per_second())
```

---

## ✅ DAILY CHECKLIST

### Before Starting Day 1
- [ ] Godot 4.2 project created
- [ ] Git repository initialized (version control)
- [ ] Ready-to-dev from GDD-001 story
- [ ] Art team sprites available (or placeholder ready)

### End of Day 1 (After GDD-001 + GDD-002)
- [ ] Game Manager working (AC passing)
- [ ] Day phase playable (player moves, PNJ visible)
- [ ] "Start Night" button functional
- [ ] No crashes, clean console

### End of Day 2 (After GDD-003 + GDD-004)
- [ ] Enemies spawn continuously (AC passing)
- [ ] Night phase playable (timer counts, combat happens)
- [ ] Player can attack, enemies take damage
- [ ] Game Over screen works, gloire saved
- [ ] **Full game loop playable** ✅

---

## 🚨 IF SOMETHING BREAKS

### "Joystick not responding"
→ Check: Input polling in `_physics_process()`, not `_process()`  
→ Check: Joystick axis mapped in Project Settings → Input Map  
→ Debug: Add `print(Input.get_vector(...))` to see input values

### "FPS drops below 30"
→ Check: How many enemies spawned?  
→ Fix: Implement object pooling (reuse enemy instances)  
→ Profile: Use Godot debugger → Profiler tab

### "Gloire not saving"
→ Check: Are you writing to file after Game Over?  
→ Check: FileAccess.open() working? Check permissions  
→ Debug: Add `print("Saving gloire:", gloire)` at save point

### "Scene load time >2s"
→ Check: Are you loading too many assets at once?  
→ Fix: Lazy-load sprites (on-demand) instead of preloading all  
→ Profile: Use Godot debugger → Timeline tab

---

## 📞 WHEN TO ESCALATE TO PM

```
If you find:
- AC unclear or contradictory → Ask PM for clarification
- Story blocked by another story taking too long → Escalate, adjust sprint
- Performance target unreachable (e.g., 30 FPS impossible with 50 enemies) → Discuss with PM about scope
- Major technical blocker (e.g., Godot bug) → Escalate
```

---

## 🏁 DONE = PLAYABLE GAME LOOP

After implementing all 4 stories with AC passing:

**Players can:**
1. ✅ Start a run (Game Manager initializes)
2. ✅ Explore Jour 1 (movement, PNJ, dialogue)
3. ✅ Start Nuit 1 (button click)
4. ✅ See timer countdown (90s)
5. ✅ Combat enemies (they spawn continuously)
6. ✅ Survive or die (lose HP, Game Over)
7. ✅ Retry (new run, gloire persisted)

**This is PLAYABLE = MVP Ready** ✅

---

## 📚 REFERENCE DOCUMENTS

**Required Reading:**
- [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) - Full story details with AC
- [GAMEPLAY-MECHANICS-context.md](GAMEPLAY-MECHANICS-context.md) - Spawn algorithm, combat mechanics
- [YERSINIA-PROJECT-CONTEXT.md](YERSINIA-PROJECT-CONTEXT.md) - Game architecture overview

**Useful References:**
- [Godot 4.2 Official Docs](https://docs.godotengine.org/en/stable/) - Language reference
- [Godot Performance Profiling](https://docs.godotengine.org/en/stable/tutorials/performance/index.html) - Optimization guide

---

## 🎓 LEARNING RESOURCES

If you're new to Godot 4.2:
1. **Autoloads:** Search "Godot 4 autoload singleton"
2. **Physics:** Use `CharacterBody2D.move_and_slide()` (not raw position)
3. **Scenes:** Each .tscn is a scene; use `get_tree().change_scene_to_file()`
4. **Profiling:** View → Output Console, add `print()` statements

**But honestly?** Agent has you covered - just ask for code & patterns.

---

## 🚀 READY TO START?

### Option 1: Full Implementation (Recommended)
```
@agent yersinia-gameplay-programmer
Implémenter GDD-001 complet
```
→ Get complete code, scene structure, validation steps

### Option 2: Step-by-Step (If uncertain)
```
@agent yersinia-gameplay-programmer
Quelle est la première phase pour GDD-001?
```
→ Get guidance for Phase 1 (setup), then Phase 2, etc.

### Option 3: Specific Code Pattern
```
@agent yersinia-gameplay-programmer
Donne-moi le pattern pour object pooling (enemies)
```
→ Get pooling code snippet

---

## ✨ FINAL CHECKLIST

- [ ] Agent loaded (`@agent yersinia-gameplay-programmer`)
- [ ] Story picked (GDD-001, GDD-002, GDD-003, or GDD-004)
- [ ] Godot 4.2 project ready
- [ ] Ready to copy code into project
- [ ] Know the 4 AC you need to pass
- [ ] FPS target in mind (≥30 night, ≥60 day)

**You're ready to start.** 🚀

---

*Gameplay Programmer Agent - Godot 4.2 Expert*  
*Implement stories, deliver production code, debug issues*  
*Follow PM specs, meet FPS targets, no memory leaks*


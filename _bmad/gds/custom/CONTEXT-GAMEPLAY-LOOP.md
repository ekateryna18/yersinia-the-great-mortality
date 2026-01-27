# 📋 GAMEPLAY LOOP - CONTEXT BMAD

**System:** Gameplay Loop  
**Status:** ✅ Stories Generated  
**Stories Created:** 4 (GDD-001 à GDD-004)  
**Total Hours:** 16-18 heures  
**Sprint:** Sprint 1-2 (Days 1-2)  

---

## 📖 STORIES GÉNÉRÉES

### Epic: Gameplay Loop Jour/Nuit (Core Loop)

#### Story GDD-001: Game Manager & Run Initialization
- **Duration:** 3h
- **Complexity:** Medium
- **Status:** ✅ Ready-to-Dev
- **Dependencies:** None (blocker)
- **Agent:** yersinia-gameplay-programmer

**Objective:** Créer Game Manager global qui gère state run (5 cycles jour/nuit). Initialize joueur, PNJ system, vagues, démarrer Jour 1.

**Key ACs:**
- Game Manager singleton created & persists
- Run state initialized: night=1, player_alive=true, gloire=0
- Player spawned at center, joysticks ready
- Day 1 starts: PNJ accessible, enemies NOT spawning

---

#### Story GDD-002: Day Phase Manager (Exploration & PNJ)
- **Duration:** 4h
- **Complexity:** Medium
- **Status:** ✅ Ready-to-Dev
- **Dependencies:** GDD-001
- **Agent:** yersinia-gameplay-programmer

**Objective:** Implémenter phase JOUR - exploration libre, map navigation, PNJ accessible, joueur choisit transition Nuit.

**Key ACs:**
- Map displayable (day-time sprite, ambiance)
- Player movement smooth (8 directions)
- PNJ 6 instances visible, positioned
- PNJ dialogue UI opens (proximity trigger)
- "Start Night" button clickable
- Jour→Nuit transition disables movement, starts timer

---

#### Story GDD-003: Wave Manager & Continuous Spawn System
- **Duration:** 5h
- **Complexity:** High
- **Status:** ✅ Ready-to-Dev
- **Dependencies:** GDD-001
- **Agent:** yersinia-gameplay-programmer

**Objective:** Implémenter Wave Manager spawn continu d'ennemis pendant Nuit. Progression: Nuit 1 (5-8 rats, 30s delay) → Nuit 5 (50+ rats, 3s delay).

**Key ACs:**
- WaveManager continuous spawn algorithm
- Spawn delay decreases per night (lookup table)
- Enemy pool: rat, mutant prefabs ready
- Nuit 1: 5-8 rats over 90s
- Nuit 5: 50+ rats continuously
- Boss Nuit 5 only
- Performance: ≥30 FPS with max load

---

#### Story GDD-004: Night Phase Manager & Combat Loop
- **Duration:** 4h
- **Complexity:** Medium
- **Status:** ✅ Ready-to-Dev
- **Dependencies:** GDD-001, GDD-003
- **Agent:** yersinia-gameplay-programmer

**Objective:** Implémenter phase NUIT - timer (45-90s), disable PNJ, enable WaveManager, joueur combats. Auto-transition ou Game Over.

**Key ACs:**
- Night phase initializes: timer visible, countdown MM:SS
- Enemies spawn continuously
- PNJ invisible/non-interactible
- Player can attack (damages in range)
- Enemies can damage player (HP feedback)
- Timer expires → next phase or end run
- Player dies (HP=0) → Game Over, Gloire saved, Retry works

---

## 🎯 SPRINT PLAN

### Day 1 Execution (8h)
```
[00:00-03:00] GDD-001 - Game Manager initialization (3h)
[03:00-07:00] GDD-002 - Day phase movement & PNJ (4h)
[07:00-13:00] GDD-003 - Wave Manager spawn start (5h+ continue to Day 2)
```

### Day 2 Execution (8h)
```
[00:00-03:00] GDD-003 - Wave Manager tuning & perf testing (2-3h remaining)
[03:00-07:00] GDD-004 - Night phase timer & transitions (4h)
[07:00-08:00] Testing & bug fixes (1h)
```

---

## 🔧 TECHNICAL INTEGRATION

### Architecture Pattern
```
Game_Manager (Autoload)
├── RunState (persistent)
│   ├── night: int
│   ├── player_alive: bool
│   ├── gloire: int
│   └── stats_run: {}
├── Player scene (main)
├── UI layer (HUD, timers)
└── WaveManager (controls spawn)
```

### Scene Structure
```
Main.tscn
├── Game_Manager.gd (autoload)
├── Player.tscn
├── UI_HUD.tscn (joysticks, timer, gloire display)
├── Day_Phase
│   ├── Map sprite (day)
│   └── PNJ nodes (6)
└── Night_Phase
    ├── Map sprite (night overlay)
    └── WaveManager (enemy spawner)
```

### Key Godot Setup
```gdscript
# project.godot - Add autoload
[autoload]
Game_Manager="res://systems/game_manager.gd"

# Persist RunState between scenes
extends Node
class_name Game_Manager

var run_state: RunState
var wave_manager: WaveManager

func _ready():
    run_state = RunState.new()
    wave_manager = WaveManager.new()
```

---

## ⚙️ IMPLEMENTATION CHECKLIST

### Phase 1: Game Manager (GDD-001)
- [ ] Game_Manager.gd created
- [ ] RunState class defined
- [ ] Autoload configured in project.godot
- [ ] Player scene linked to Game Manager
- [ ] Day 1 initialization logic
- [ ] State persistence tested

### Phase 2: Day Phase (GDD-002)
- [ ] Player movement input mapped (8 directions)
- [ ] Isometric camera setup (orthogonal, follows player)
- [ ] PNJ 6 instances spawned at map positions
- [ ] PNJ proximity detection (50px range)
- [ ] Dialogue UI panel created
- [ ] "Start Night" button implemented
- [ ] Jour→Nuit transition logic

### Phase 3: Wave Manager (GDD-003)
- [ ] WaveManager.gd script created
- [ ] Spawn algorithm implemented (continuous, not discrete)
- [ ] Enemy prefabs: rat, mutant, boss
- [ ] Spawn delay lookup table (decrees per night)
- [ ] Enemy pool manager (object pooling)
- [ ] Spawn position logic (off-screen edges)
- [ ] Despawn logic (off-camera enemies)
- [ ] FPS profiling (30 FPS target)

### Phase 4: Night Phase (GDD-004)
- [ ] Night phase initialization
- [ ] Timer countdown logic & display (MM:SS)
- [ ] PNJ layer visibility toggle
- [ ] Player attack activation (joystick/button)
- [ ] Enemy damage to player
- [ ] Death detection (HP=0)
- [ ] Game Over screen
- [ ] Retry button logic
- [ ] Gloire save/load

---

## 🧪 TEST SCENARIOS

### Test 1: Run Initialization ✅
```
Given: Start game
When: Scene loads
Then: RunState created, player spawned, Day 1 starts
Check: Game Manager active, PNJ visible, enemies NOT spawning
```

### Test 2: Day Phase Movement ✅
```
Given: Day 1 active
When: Touch left joystick (8 directions)
Then: Player moves smoothly, no lag
Check: Animation plays, camera follows, collision detection
```

### Test 3: Wave Spawn Progression ✅
```
Given: Night 1 starts
When: 90s night duration runs
Then: 5-8 rats spawn continuously
When: Night 5 starts
Then: 50+ rats spawn continuously, boss appears
Check: Enemy count matches progression, no FPS drops
```

### Test 4: Combat Loop ✅
```
Given: Night 1, enemies spawned
When: Player attack button pressed (right joystick/button)
Then: Nearby enemies take damage, knockback, particles
When: Enemy attacks player
Then: Player HP decreases, feedback visual
```

### Test 5: Game Over ✅
```
Given: Player HP reaches 0 during night
When: Death triggers
Then: Game Over screen shows Gloire earned
When: Retry button clicked
Then: New run starts (RunState reset, gloire persisted post-run)
```

---

## 📊 VALIDATION METRICS

| Metric | Target | Status |
|--------|--------|--------|
| Run initialization time | <2s | ⏳ To test |
| Day phase FPS | ≥60 | ⏳ To test |
| Night phase FPS (5 enemies) | ≥60 | ⏳ To test |
| Night phase FPS (50 enemies) | ≥30 | ⏳ To test |
| Player movement responsiveness | <50ms lag | ⏳ To test |
| Spawn delay accuracy | ±1s per night | ⏳ To test |
| State persistence | 100% accuracy | ⏳ To test |
| Gloire save/load | Correct on retry | ⏳ To test |

---

## 🚀 READY-TO-DEV STATUS

✅ **All 4 stories are Ready-to-Dev:**
- AC testable and measurable
- Dependencies clear and ordered
- Agent specialist assigned
- Technical notes provided
- Risks identified + mitigated
- Estimation realistic
- MVP-aligned (no scope creep)

---

## 📞 NEXT STEPS

1. **Assign stories to dev team** → GDD-001 & GDD-002 start Day 1
2. **Create Godot scene structure** → Main.tscn, Player.tscn, UI_HUD.tscn
3. **Kickoff meeting** → Review AC, clarify questions, share context
4. **Daily standup** → Track blockers, adjust estimation if needed
5. **QA testing** → Validate each story against AC before next sprint

---

## 🔗 RELATED CONTEXTS & STORIES

- **Context:** GAMEPLAY-MECHANICS-context.md (day/night, waves, combat)
- **Context:** YERSINIA-PROJECT-CONTEXT.md (game overview, systems)
- **Agent:** yersinia-gameplay-programmer (specialist)
- **Follow-up stories:** GDD-005 (Player attack mechanics), GDD-006 (Enemy AI)
- **Follow-up systems:** NPC dialogue, progression, UI polish

---

**Generated by:** Agent PM Yersinia  
**Date:** 2026-01-27  
**System:** Gameplay Loop (Core MVP Loop)  
**Status:** ✅ READY - All stories documented and validated


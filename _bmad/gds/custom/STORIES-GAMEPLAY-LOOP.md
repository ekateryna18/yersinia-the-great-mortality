# 📖 STORIES - SYSTÈME GAMEPLAY LOOP

**System:** Gameplay Loop  
**Priority:** Priority 1 (BLOCKER - MVP fondation)  
**Timeline:** Sprint 1-2 (Days 1-2)  
**Total Estimation:** 16-18 heures  
**Team:** 1 dev senior + 1 dev junior  

---

## 📋 EPIC DECOMPOSITION

### Epic: Gameplay Loop Jour/Nuit (Core Loop)
**Description:** Implémenter la boucle jour/nuit 5-cycle qui compose le run entier. Jour: exploration libre + accès PNJ. Nuit: vagues continues + combat joueur. Transition automatique ou joueur-décidée.

**Stories:** 4  
**Dependencies:** Game manager structure, scene management  
**Risk:** State management complexity  

---

## 🎯 STORY DETAILS

### Story: GDD-001 - Game Manager & Run Initialization

**Type:** Feature / Core Architecture  
**Priority:** Priority 1 (BLOCKER)  
**Sprint:** Day 1 (start of game)

#### Description
Créer le Game Manager global qui gère le state de chaque run. Initialisation run: créer joueur, initialiser PNJ system, setup vagues, démarrer Jour 1.

#### Context Yersinia
- Run = session complète (5 nuits cycles)
- Jour 1 toujours commence illimité
- Nuit: toujours 45-90s (fixed)
- État run persiste entre day/night transitions
- Gloire + stats permanentes persistent post-run (sauvegarde local)

#### Acceptance Criteria
- [ ] AC1: Game Manager singleton créé, persiste entre scenes
- [ ] AC2: Run state initialized: night_counter=1, player_alive=true, gloire=0, stats_run={} 
- [ ] AC3: Player spawned at scene center, joysticks initialized
- [ ] AC4: Day 1 starts automatically, PNJ accessible, enemies NOT spawning
- [ ] AC5: Day 1 state displayable: UI shows "Jour 1", PNJ count, player stats
- [ ] AC6: Jour→Nuit transition callable (button ou delay), state persist

#### Technical Notes
- **Pattern:** Godot Game_Manager (autoload singleton)
- **State structure:**
  ```gdscript
  class RunState:
      var night: int = 1
      var player_alive: bool = true
      var gloire: int = 0
      var stats_run: Dictionary = {}  # temp stats this run
      var pnj_list: Array = []  # 6 PNJ instances
      var enemies_wave: Array = []
      var day_elapsed_sec: float = 0.0
      var night_elapsed_sec: float = 0.0
  ```
- **Autoload setup:** 
  - Add to project.godot: `autoload/Game_Manager="res://game_manager.gd"`
- **Performance:** Keep RunState lean, avoid heavy data each frame
- **Scene structure:** 
  - Main scene = Game_Manager + Player + UI layer
  - Day scene = Map + PNJ nodes
  - Night scene = Map + Wave spawner

#### Agent Specialist
`@agent yersinia-gameplay-programmer` - Core architecture, state management, scene setup

#### Dependencies
- Blocked by: None (start blocker)
- Unlocks: GDD-002, GDD-003, GDD-004, GDD-005 (all loop-dependent)

#### Risks
- **Risk 1:** Autoload complexity in Godot 4 → **Mitigation:** Use standard Godot pattern, test early
- **Risk 2:** State persistence between scenes buggy → **Mitigation:** Log state changes, validate transitions
- **Risk 3:** Performance if RunState too large → **Mitigation:** Keep data minimal, cache PNJ refs

#### Estimation
- **Time:** 3 hours
- **Complexity:** Medium
- **Ready-to-Dev:** ✅ YES

#### Validation Checklist
- [ ] Game Manager loads, persists between scenes
- [ ] Run state initializes correctly
- [ ] Player spawns, joysticks visible
- [ ] Jour 1 displays, PNJ accessible
- [ ] Day→Night transition works, state persists

---

### Story: GDD-002 - Day Phase Manager (Exploration & PNJ)

**Type:** Feature  
**Priority:** Priority 1 (BLOCKER)  
**Sprint:** Day 1 (after GDD-001)

#### Description
Implémenter la phase JOUR: exploration libre, map navigation, PNJ accessible, joueur choisit quand avancer vers Nuit.

#### Context Yersinia
- JOUR est illimité en durée
- PNJ spawn à positions fixées (6 PNJ per run, 2 aléatoires traîtres)
- Joueur peut parler PNJ (dialogue UI)
- Joueur peut acheter upgrades PNJ (progression economy)
- Ennemis NE spawn PAS en jour
- Joueur clique "Start Night" ou barre UI pour transition Nuit
- 🔑 Jour est "safe zone" pour récupération, stratégie

#### Acceptance Criteria
- [ ] AC1: Map displayable en jour (sprite day-time, ambiance claire)
- [ ] AC2: Player movement controls responsive (8 directions, smooth)
- [ ] AC3: PNJ 6 instances visible, positioned on map
- [ ] AC4: PNJ dialogue UI opens on player interaction (click/proximity)
- [ ] AC5: "Start Night" button visible, clickable (UI visible)
- [ ] AC6: Transition Jour→Nuit: disables movement, freezes PNJ, starts night timer
- [ ] AC7: Jour duration UX: time display (optional, no hard limit)

#### Technical Notes
- **PNJ positioning:** Fixed map positions (e.g., top-left, center, bottom-right, etc.)
- **Interaction range:** PNJ interactable if player within 50px distance
- **Movement controls:** Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") → apply velocity
- **Smooth movement:**
  ```gdscript
  velocity = input_vector.normalized() * SPEED
  position += velocity * delta
  ```
- **Camera:** Isometric camera follows player (orthogonal, tile-based view)
- **Day phase flow:**
  1. Player moves freely
  2. Opens PNJ dialog (click icon)
  3. Reads options (commerce, dialogue, upgrade)
  4. Clicks "Start Night" button
  5. Scene transition → Night phase

#### Agent Specialist
`@agent yersinia-gameplay-programmer` - Player movement, PNJ positioning, scene transitions

#### Dependencies
- Blocked by: GDD-001 (Run state, Game Manager)
- Unlocks: GDD-003 (Night phase depends on Day completion)

#### Risks
- **Risk 1:** Input lag on mobile → **Mitigation:** Use physics process for movement, optimize input polling
- **Risk 2:** PNJ collision overlap → **Mitigation:** Position carefully, test positions in editor
- **Risk 3:** Scene load time if PNJ count large → **Mitigation:** Lazy-load PNJ sprites on proximity

#### Estimation
- **Time:** 4 hours
- **Complexity:** Medium
- **Ready-to-Dev:** ✅ YES

#### Validation Checklist
- [ ] Player moves smoothly in all 8 directions
- [ ] PNJ visible, positioned correctly
- [ ] Dialogue opens on proximity interaction
- [ ] "Start Night" button functional
- [ ] Jour→Nuit transition smooth, state preserved

---

### Story: GDD-003 - Wave Manager & Continuous Spawn System

**Type:** Feature / Core Loop  
**Priority:** Priority 1 (BLOCKER)  
**Sprint:** Day 1 (parallel with GDD-002)

#### Description
Implémenter le Wave Manager qui gère spawn continu d'ennemis pendant la Nuit. Spawn progressif par nuit (Nuit 1: 5-8 rats → Nuit 5: 50+ rats). Continuous spawn algorithm: tant que alive_count < max, spawn un ennemi tous les N secondes (N décroit chaque nuit).

#### Context Yersinia
- **Spawn continu:** Pas de "vagues discrètes", toujours spawning pendant Nuit
- **Progression:** Chaque nuit augmente max_enemies et décroit spawn_delay
  - Nuit 1: max=8, spawn_delay=30s
  - Nuit 5: max=50, spawn_delay=3s
- **Ennemi types:** rat (commun), mutant (fort), boss (Nuit 5 seulement), npc (if attacked)
- **Enemy count:** Gérée par WaveManager, détruit automatiquement si hors écran
- **Difficulté:** Progression linéaire (Night 1 facile → Night 5 très dur)

#### Acceptance Criteria
- [ ] AC1: WaveManager script créé, gère spawning continuous
- [ ] AC2: Spawn algorithm: while alive_enemies < max_enemies: spawn()
- [ ] AC3: Spawn delay decreaes per night (lookup table ou lerp)
- [ ] AC4: Enemy pool initialized: rat, mutant prefabs ready
- [ ] AC5: Nuit 1 spawns 5-8 rats sur 90s (validate count in debug)
- [ ] AC6: Nuit 5 spawns 50+ rats continuously (FPS not dropping below 30)
- [ ] AC7: Boss spawned Nuit 5 (1 instance max)
- [ ] AC8: Enemies despawn if far off-screen (performance optimization)

#### Technical Notes
- **WaveManager script:**
  ```gdscript
  class WaveManager:
      var current_night: int = 1
      var alive_enemies: int = 0
      var max_enemies: int = 5 + (current_night * 3)
      var spawn_delay: float = lerp(30, 3, (current_night - 1) / 4.0)
      var last_spawn_time: float = 0.0
      
      func _process(delta):
          if Time.get_ticks_msec() - last_spawn_time > spawn_delay * 1000:
              if alive_enemies < max_enemies:
                  spawn_random_enemy()
                  last_spawn_time = Time.get_ticks_msec()
  ```
- **Enemy pool:** Create prefabs for rat, mutant, boss with pooling manager (avoid GC spikes)
- **Random selection:**
  ```gdscript
  func spawn_random_enemy():
      var enemy_type = get_enemy_type(current_night)  # Lookup table
      var enemy = ENEMY_POOL.get_instance(enemy_type)
      var spawn_pos = get_random_spawn_pos()
      enemy.position = spawn_pos
  ```
- **Spawn positions:** Random positions off-screen edges (around player camera bounds)
- **Performance target:** 30 FPS on Android mid-range with 50 rats + player attacks

#### Agent Specialist
`@agent yersinia-gameplay-programmer` - Wave manager architecture, spawn algorithm, performance tuning

#### Dependencies
- Blocked by: GDD-001 (Run state initialization)
- Unlocks: GDD-004 (Player attack resolution needs enemy list), GDD-005 (Combat feedback)

#### Risks
- **Risk 1:** FPS drops with 50+ enemies → **Mitigation:** Use object pooling, test early with full night 5 load
- **Risk 2:** Spawn positions spawn inside obstacles → **Mitigation:** Use pathfinding or predefined spawn zones
- **Risk 3:** Spawn delay too fast/slow (balance) → **Mitigation:** Tunable lookup table, adjust post-playtesting

#### Estimation
- **Time:** 5 hours
- **Complexity:** High
- **Ready-to-Dev:** ✅ YES

#### Validation Checklist
- [ ] WaveManager spawns enemies continuously during night
- [ ] Enemy count matches expectation per night
- [ ] FPS stays ≥30 with max enemy load
- [ ] Boss appears only on Night 5
- [ ] Spawn delay progression feels balanced

---

### Story: GDD-004 - Night Phase Manager & Combat Loop

**Type:** Feature  
**Priority:** Priority 1 (BLOCKER)  
**Sprint:** Day 1 (after GDD-001, GDD-003)

#### Description
Implémenter la phase NUIT: affichage Night timer (45-90s), disable PNJ, enable WaveManager, joueur combats librement. Timer affiche countdown, auto-transition Nuit suivante ou Jour au timer=0. Joueur meurt = Game Over (option Retry run).

#### Context Yersinia
- Nuit durée: FIXÉE (programmable par niveau, default 90s)
- Timer visible UI: "00:45" countdown
- Ennemis spawn continu via WaveManager
- PNJ fermés, non-interactibles
- Si joueur meurt: Game Over, Gloire sauvegardée, option "Retry" (nouvelle run)
- Si timer expire et joueur alive: auto-transition Nuit suivante (ou Jour si Night 5)
- 🔑 Combat direct: joueur attaque via joystick/button, ennemis retaliate

#### Acceptance Criteria
- [ ] AC1: Night phase initializes: timer=90s (or config value), display visible
- [ ] AC2: Timer countdown visible in HUD: "MM:SS" format, updates each frame
- [ ] AC3: Enemies spawn continuously via WaveManager during night
- [ ] AC4: PNJ nodes invisible/non-interactible during night
- [ ] AC5: Player can attack (joystick or button), damages enemies in range
- [ ] AC6: Enemies can damage player (HP decrease, visible feedback)
- [ ] AC7: Timer expires → auto-transition to next phase (next night or day)
- [ ] AC8: Player dies (HP=0) → Game Over screen, Gloire shown, "Retry" button works

#### Technical Notes
- **Night phase flow:**
  ```gdscript
  # OnNightStart
  night_timer = 90.0  # seconds
  wave_manager.activate()
  pnj_layer.visible = false
  ui_timer.visible = true
  
  # OnNightProcess
  night_timer -= delta
  if night_timer <= 0:
      end_night()
  if player.hp <= 0:
      game_over()
  
  # OnNightEnd
  wave_manager.deactivate()
  night_counter += 1
  if night_counter > 5:
      end_run()  # Gloire saved
  else:
      start_day()
  ```
- **Combat feedback:** Enemy hit = knockback + blood sprite/particle
- **Player death:** HP bar reaches 0 → fade out animation → Game Over screen
- **Game Over UI:** Show Gloire earned, run stats, "Retry" / "Menu" buttons

#### Agent Specialist
`@agent yersinia-gameplay-programmer` - Night loop logic, timer management, state transitions

#### Dependencies
- Blocked by: GDD-001 (Run state), GDD-003 (WaveManager)
- Unlocks: GDD-005 (Combat mechanics details)

#### Risks
- **Risk 1:** Timer inaccurate (drift) → **Mitigation:** Use Time.get_ticks_msec() not delta accumulation
- **Risk 2:** Game Over transition buggy (state not saved) → **Mitigation:** Log state before transition, verify Gloire persistence
- **Risk 3:** Player death feedback confusing (instant vs animation) → **Mitigation:** Add death animation, 1s delay before Game Over screen

#### Estimation
- **Time:** 4 hours
- **Complexity:** Medium
- **Ready-to-Dev:** ✅ YES

#### Validation Checklist
- [ ] Night timer displays correctly, counts down
- [ ] Enemies spawn during night
- [ ] Player can attack enemies
- [ ] Enemies can damage player
- [ ] Night transition works (next night or day)
- [ ] Player death triggers Game Over, Gloire saved
- [ ] Retry button creates new run

---

## 📊 SPRINT ASSIGNMENT

### Day 1 (8 hours dev time)
1. **GDD-001** (3h) - Game Manager, run initialization
2. **GDD-002** (4h) - Day phase (movement, PNJ positioning)
3. **GDD-003** (5h - partial) - Wave Manager start (spawn algorithm core)

### Day 2 (8 hours dev time)
1. **GDD-003** (remainder 2-3h) - Wave Manager tuning, performance testing
2. **GDD-004** (4h) - Night phase, timer, transitions
3. **Testing & Bug fixes** (1-2h)

---

## 🎯 VALIDATION & TESTING

### Checklist validations:
- [ ] Run initialization: RunState created, player spawned ✅
- [ ] Day phase: Player moves, PNJ visible, dialogue opens ✅
- [ ] Wave spawn: Continuous spawn verified per night progression ✅
- [ ] Night phase: Timer runs, enemies spawn, player can attack ✅
- [ ] Transitions: Day→Night→Day smooth, state preserved ✅
- [ ] Game Over: Gloire saved, retry works ✅
- [ ] Performance: 30 FPS maintained with max enemy load ✅
- [ ] Mobile input: Joysticks responsive, no lag ✅

### Test scenarios:
1. **Happy path:** Start game → Jour 1 explore → Start Night → Survive Night 1 → Auto-transition Jour → ... → Night 5 boss → Game Over (gloire saved)
2. **Death scenario:** Night 2 → Player dies → Game Over → Retry (new run starts)
3. **Performance:** Night 5 with 50 enemies + player attacks → FPS ≥30
4. **State persistence:** Gloire persists post-game, next run increments

---

## 📞 AGENT DISPATCH

- **Primary:** `@agent yersinia-gameplay-programmer`
  - Justif: Core loop architect, state machine, scene management, performance tuning
  
- **Secondary (optional):** `@agent yersinia-ui-systems-specialist`
  - Justif: Timer UI, HUD display, Game Over screen layout

---

## ⚠️ RISKS & MITIGATIONS

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|-----------|
| State management bugs (RunState corruption) | Blocker | Medium | Early testing, log state changes, validate persistence |
| FPS drops <30 with 50 enemies | Blocker | High | Object pooling, sprite batch rendering, tested early |
| Mobile input lag (joystick unresponsive) | Critical | Medium | Physics-based movement, input poll optimization |
| Scene load times slow (impacts transitions) | High | Medium | Async loading, preload critical assets day 0 |
| Balance: Night difficulty progression feels wrong | High | High | Tunable spawn_delay table, playtesting adjustments |

---

## 📈 SUCCESS METRICS

- ✅ **Run completes:** Player can survive 5 nights and reach Game Over screen
- ✅ **FPS stable:** ≥30 FPS on target device (Android mid-range) during night 5
- ✅ **Gloire persists:** Post-game gloire saved and visible on retry
- ✅ **Loop playable:** ~10-15min per run is target duration (Night 1-5 + transitions)
- ✅ **MVP-aligned:** No scope creep beyond continuous spawn, hack'slash combat, 5-night loop

---

## 🔗 RELATED DOCUMENTATION

- **Parent Epic:** Gameplay Loop System
- **Related Stories:** 
  - GDD-005 (Player Combat/Attack mechanics)
  - GDD-006 (Enemy AI/Knockback)
  - NPC System stories (dialogue, upgrade mechanics)
  - Progression stories (gloire save/load)

---

**Generated by:** Agent PM Yersinia  
**Date:** 2026-01-27  
**Status:** ✅ Ready-to-Dev (All AC testable, dependencies clear, agent assigned)


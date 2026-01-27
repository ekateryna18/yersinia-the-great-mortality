# 📚 EXEMPLES: Agent PM en Action

Voici des exemples concrets d'utilisation de l'agent PM pour Yersinia.

---

## EXEMPLE 1: Créer les Stories pour Gameplay Loop

### 🎯 REQUEST:
```
@agent yersinia-pm

Créer les stories pour le système gameplay-loop 
(jour/nuit cycle, vagues ennemis, combat joueur)
```

### ✅ RÉPONSE DE L'AGENT PM:

```markdown
# Gameplay Loop System - Epic Breakdown

**System Overview:** 
Core 4 cycles (jour → nuit) + waves + player combat
Estimated: 20-24 hours total dev | Risk: Medium | Blocker: None

---

## 📌 Epic 1: Day/Night Cycle Foundation

### Story GDD-001: Day/Night State Machine
**Type:** Feature | **Time:** 4 hours | **Complexity:** Medium

**Description:**
Implémenter la boucle jour/nuit fondamentale: jour state où PNJ sont accessibles et ennemis n'apparaissent pas, nuit state où ennemis spawn et PNJ sont fermés. Transition automatique jour→nuit via bouton joueur.

**Context Yersinia:**
- Jour: illimité duration, PNJ accessible via dialogue, enemies spawn = FALSE
- Nuit: 90 secondes max, PNJ non-accessible (fermés), waves spawn automatiquement
- Nuit 5: Boss final (rat boss) + 50+ ennemis intensifiés
- UI: Show jour/nuit indicator, night counter 90→0 visible

**Acceptance Criteria:**
- [ ] Jour state: PNJ markers visible, enemies NOT spawning, player can move freely
- [ ] Nuit state: PNJ markers hidden/grayed, enemies spawning enabled, night counter visible
- [ ] Day→Night transition: Trigger via UI button, scene/lighting swap, first wave spawns after 5s
- [ ] UI updates: Correct markers shown/hidden per state, transitions smooth (0.5s max)
- [ ] Night duration: Timer counts 90→0 seconds, auto-transition to next day OR on player death

**Technical Notes:**
- Use State Pattern (enum: DAY, NIGHT)
- Wave Manager enable/disable on state change
- Asset swap: day tileset ↔ night tileset
- Lighting: Adjust brightness, color tint for night
- Consider: PNJ dialogue system must be toggleable with state

**Agent Specialist:**
`@agent yersinia-gameplay-programmer` - Systèmes core gameplay, state machines

**Dependencies:**
- Blocked by: NONE (this is starter story)
- Unlocks: Enemy Wave Manager, Player Combat System

**Risks:**
1. **Risk:** State complexity growing (day has sub-states?)
   - **Mitigation:** Keep state simple for MVP (just DAY/NUIT)
   - **Fallback:** Use flags instead of state machine if complex

2. **Risk:** PNJ system not ready when day-state starts
   - **Mitigation:** Mock PNJ system, test state without PNJ first
   - **Fallback:** Start with invisible/placeholder PNJ

3. **Risk:** Performance hit from scene swap
   - **Mitigation:** Async load night scene, profile FPS
   - **Fallback:** Use toggle lighting + tileset without full scene swap

**Estimation:**
- **Time:** 4 hours (single dev)
- **Complexity:** Medium (state logic + scene transitions)
- **Ready-to-Dev:** ✅ YES - All AC clear, no blockers

---

### Story GDD-002: Night Timer & Auto-Progression
**Type:** Feature | **Time:** 3 hours | **Complexity:** Low

**Description:**
Implement night duration timer (90 seconds max) with countdown UI, auto-progression to next day when timer expires, or triggering loss state if player dies.

**Context Yersinia:**
- Night max duration: 90 seconds (configurable?)
- Timer should be visible in UI (large, easy to read on mobile)
- Night ends: Auto-transition to next day (if survived) OR show death screen (if killed)
- 5 nights total = 1 full run

**Acceptance Criteria:**
- [ ] Timer starts at 90 when night begins
- [ ] Timer countdown visible in UI (large font, easy read mobile)
- [ ] Timer counts down to 0 accurately (±0.5s tolerance)
- [ ] At 0, auto-transition to next day (show success state)
- [ ] If player dies before 0, death/loss state triggers instead
- [ ] Night 5: Different end-state (boss final + epilogue scene)

**Technical Notes:**
- Use Timer node in Godot, connect timeout signal
- UI: Large font (36+), contrasting color, positioned center-top
- Night progression: Track night_counter (1-5), increment each night
- Nuit 5: Set flag for boss-final behavior

**Agent Specialist:**
`@agent yersinia-gameplay-programmer`

**Dependencies:**
- Blocked by: GDD-001 (day/night state needed)
- Unlocks: Wave Spawn System, Enemy Spawning Algorithm

**Risks:**
1. **Risk:** Timer precision issues
   - **Mitigation:** Use delta_time accumulation, test frame-independent
   - **Fallback:** Round to nearest second if needed

2. **Risk:** UI not visible on all mobile screens
   - **Mitigation:** Test on 4" and 6" screens, use adaptive positioning
   - **Fallback:** Scale UI based on screen size

**Estimation:**
- **Time:** 3 hours
- **Complexity:** Low
- **Ready-to-Dev:** ✅ YES

---

## 📌 Epic 2: Wave System

### Story GDD-003: Enemy Wave Manager (Config-Driven)
**Type:** Feature | **Time:** 6 hours | **Complexity:** Medium-High

**Description:**
Create configurable wave manager that defines enemy counts, types, and spawn patterns per night (1-5). Each night has progressively harder waves. Config-driven so balance can be tuned without recompiling.

**Context Yersinia:**
- Wave progression:
  - Nuit 1: 5-8 rats, 1 wave every 30s
  - Nuit 2: 8-12 rats + mutants (20%), 1 wave every 20s
  - Nuit 3: 12-18 rats + mutants (40%), 1 wave every 15s
  - Nuit 4: 18-25 rats + mutants (60%), mini-boss possible, 1 wave every 10s
  - Nuit 5: Boss final (1 rat boss) + 50+ waves of rats, continuous spawn

**Acceptance Criteria:**
- [ ] Wave data stored in config file (YAML or JSON)
- [ ] Can define: enemy_count, enemy_types, spawn_delay, mutant_ratio per night
- [ ] WaveManager loads config and spawns waves in sequence
- [ ] Spawn delay correctly reduces per night (30s → 5s progression)
- [ ] Mutant ratio increases with night (0% → 60% curve)
- [ ] Night 5 spawns boss + continuous waves (50+ rat spawns)
- [ ] Config changes = balance changes (no code recompile)

**Technical Notes:**
- Create WaveData class (holds night config)
- Load from res://config/waves.yaml on startup
- Algorithm: spawn_delay = lerp(30, 5, night/4.0); enemy_count = 5 + night*3
- Mutant ratio = 0.2 * night
- Use Object Pooling for enemy spawning (performance critical @30 FPS)
- Store wave state: current_night, waves_spawned, next_spawn_time

**Agent Specialist:**
`@agent yersinia-gameplay-programmer`

**Dependencies:**
- Blocked by: GDD-001 (day/night state), GDD-002 (timer)
- Unlocks: Spawn Algorithm, Enemy Positioning

**Risks:**
1. **Risk:** Wave difficulty curve breaks balance (too hard too fast)
   - **Mitigation:** Tune config daily, playtest each night difficulty
   - **Fallback:** Reduce difficulty curve steepness (flatter progression)

2. **Risk:** Enemy pooling not efficient enough (FPS drop)
   - **Mitigation:** Profile with 50+ enemies, optimize pooling
   - **Fallback:** Cap max enemies 30 (reduce wave size)

3. **Risk:** Config file corruption breaks waves
   - **Mitigation:** Validate config on load, provide defaults
   - **Fallback:** Hardcode fallback waves if config missing

**Estimation:**
- **Time:** 6 hours
- **Complexity:** Medium-High (config parsing + optimization)
- **Ready-to-Dev:** ✅ YES

---

### Story GDD-004: Enemy Spawning Algorithm
**Type:** Feature | **Time:** 4 hours | **Complexity:** Medium

**Description:**
Implement spawning logic: select random spawn points around map edges, spawn correct enemy type per night, handle overlap/collision on spawn, trigger pathfinding to player.

**Context Yersinia:**
- Spawn points: Around map perimeter (edges)
- Spawn distribution: Randomized but avoid clustering
- Enemy types spawned per night based on WaveManager config
- On spawn: Start pathfinding behavior immediately
- Collision: Avoid spawning inside obstacles or player

**Acceptance Criteria:**
- [ ] Enemies spawn at designated spawn points (perimeter)
- [ ] Spawn distribution even (no 10+ spawning same location)
- [ ] Enemy type correct per night (rat type 1, mutant type 2, etc.)
- [ ] No spawn overlaps with player or obstacles
- [ ] Enemy AI state set to CHASE immediately on spawn
- [ ] Pathfinding works (enemies move toward player)
- [ ] Spawn visuals: Fade-in effect (0.3s) so not jarring

**Technical Notes:**
- Define spawn_points array (8-12 points around perimeter)
- Random.choice(spawn_points) for each spawn
- Store spawned_count_from_point, cap at 2-3 consecutive from same point
- Enemy type selection: if mutant_ratio > rand() → mutant, else rat
- Call enemy.set_state(CHASE) + enemy.start_pathfinding(player_position)
- Optional: Spawn FX (puff of dust, sound effect)

**Agent Specialist:**
`@agent yersinia-gameplay-programmer`

**Dependencies:**
- Blocked by: GDD-003 (wave manager)
- Unlocks: Combat System (enemies present to combat against)

**Risks:**
1. **Risk:** Pathfinding lag on 50+ spawns night 5
   - **Mitigation:** Use simple AI (move_toward), not full pathfinding
   - **Fallback:** Cap max enemies 30

2. **Risk:** Spawn points hardcoded (hard to adjust)
   - **Mitigation:** Define spawn_points in config or editor
   - **Fallback:** Hardcode but add comments for easy tweaking

**Estimation:**
- **Time:** 4 hours
- **Complexity:** Medium
- **Ready-to-Dev:** ✅ YES

---

## 📌 Epic 3: Combat System

### Story GDD-005: Player Attack System
**Type:** Feature | **Time:** 5 hours | **Complexity:** Medium

**Description:**
Implement player scythe attack: detect enemies in cone (90° in front), apply damage based on stats, trigger knockback effect. Auto-attacks on interval (configurable cooldown).

**Context Yersinia:**
- Weapon: Scythe (faux)
- Attack zone: Cone 90° in front of player
- Attack range: ~150 pixels
- Damage: base (10) + weapon bonus + stat bonuses
- Crit: chance based on crit stat, deals 1.5x damage
- Knockback: Apply impulse to hit enemies
- Cooldown: ~0.5s between attacks
- Auto-attack: Continuous while moving/alive

**Acceptance Criteria:**
- [ ] Scythe visual present and rotates with player direction
- [ ] Attack zone is cone 90° forward (~150px range)
- [ ] Damage calculation: base_damage + weapon_bonus + enchantments
- [ ] Crit check passes: 5% base chance, damage *= 1.5
- [ ] Knockback applied: enemies pushed away from player
- [ ] Cooldown enforced: 0.5s min between attacks
- [ ] Auto-attack works: Trigger attack every cooldown automatically
- [ ] Attack feedback: Damage numbers visible briefly, hit sound plays

**Technical Notes:**
- Use raycast_cone() to detect enemies in cone
- Damage formula: damage = base_damage * (1 + weapon_mod) + stat_bonus
- Crit: if Random.range(0, 100) < crit_stat → apply_crit()
- Knockback: Apply vector impulse (direction * force_magnitude)
- UI Feedback: Damage popup + sound effect on hit
- Animation: Scythe swing animation (0.3s duration)

**Agent Specialist:**
`@agent yersinia-gameplay-programmer`

**Dependencies:**
- Blocked by: GDD-001 (player needs to exist), GDD-003 (enemies to attack)
- Unlocks: Knockback Physics, Combat Feel Tuning

**Risks:**
1. **Risk:** Knockback feels weak/unresponsive
   - **Mitigation:** Tune force multiplier (test range 100-300)
   - **Fallback:** Increase visual fx to feel more impactful

2. **Risk:** Attack cooldown creates input lag feeling
   - **Mitigation:** Implement input buffering (queue next attack)
   - **Fallback:** Lower cooldown to 0.3s

**Estimation:**
- **Time:** 5 hours
- **Complexity:** Medium
- **Ready-to-Dev:** ✅ YES

---

### Story GDD-006: Enemy Knockback & Physics
**Type:** Feature | **Time:** 3 hours | **Complexity:** Low-Medium

**Description:**
Apply knockback physics to enemies: impulse on hit, deceleration over time, collision avoidance so enemies don't stack.

**Context Yersinia:**
- Knockback force: ~100-200 pixels/s depending on weapon
- Deceleration: Natural friction over 0.3s
- Stacking: Enemies shouldn't occupy same space
- Walls: Knockback respects map boundaries

**Acceptance Criteria:**
- [ ] Knockback applied on hit (direction * force)
- [ ] Knockback deceleration smooth (0.3s to stop)
- [ ] Enemies don't overlap/stack
- [ ] Knockback respects map boundaries (can't push through walls)
- [ ] Knockback + pathfinding coexist (resume chase after knockback settles)

**Technical Notes:**
- Store knockback_velocity on enemy
- Apply velocity each frame: position += knockback_velocity * delta
- Decelerate: knockback_velocity *= 0.95 (or similar dampening)
- Collision: Check nearby enemies, separate if overlapping
- Walls: Raycast before moving, clamp position if would exit bounds

**Agent Specialist:**
`@agent yersinia-gameplay-programmer`

**Dependencies:**
- Blocked by: GDD-005 (player attack)
- Unlocks: Combat Polish (done when GDD-005 + GDD-006 complete)

**Risks:**
None identified - straightforward physics integration.

**Estimation:**
- **Time:** 3 hours
- **Complexity:** Low-Medium
- **Ready-to-Dev:** ✅ YES

---

## 📊 Sprint Assignment (MVP Timeline)

### Day 1 (8 hours)
- **GDD-001:** Day/Night State (4h) ← **START HERE**
- **GDD-002:** Night Timer (3h)
- (1h buffer/breaks)

### Day 2 (8 hours)
- **GDD-003:** Wave Manager (6h)
- **GDD-004:** Spawn Algorithm (2h started)

### Day 2 Afternoon / Early Day 3
- **GDD-004:** Spawn Algorithm (finish 2h remaining)
- **GDD-005:** Player Attack (5h started)

### Day 3 Afternoon
- **GDD-005:** Player Attack (finish 3h remaining)
- **GDD-006:** Knockback Physics (3h)

---

## 🎯 Dependencies Graph

```
GDD-001 (Day/Night) ← STARTER [BLOCKER FOR ALL]
├─ GDD-002 (Night Timer) ← Blocks GDD-003, GDD-004
│  ├─ GDD-003 (Wave Manager)
│  │  └─ GDD-004 (Spawn Algorithm) ← Unlocks GDD-005
│  │     └─ GDD-005 (Player Attack)
│  │        └─ GDD-006 (Knockback)
│  │
│  └─ GDD-005 (Player Attack) ← Independent track, can run parallel after GDD-001
│     └─ GDD-006 (Knockback)
```

**Critical Path:** GDD-001 → GDD-002 → GDD-003 → GDD-004 → GDD-005 → GDD-006
**Parallel Possible:** GDD-005 can start when GDD-001 done (don't need GDD-002/003/004)

---

## ⚠️ Risks Identified

| Risk | Impact | Prob | Mitigation | Fallback |
|------|--------|------|-----------|----------|
| Performance @50+ enemies | CRITICAL | HIGH | Object pooling, daily profile | Cap 30 enemies |
| Wave balance breaks | HIGH | MEDIUM | Config-driven, daily tuning | Flat difficulty curve |
| State complexity grows | HIGH | MEDIUM | Keep simple enum states | Use flags instead |
| Knockback feels weak | MEDIUM | MEDIUM | Tune force multiplier | Enhance visual fx |
| Input lag on cooldown | MEDIUM | LOW | Input buffering | Lower cooldown to 0.3s |

---

## ✅ All Stories Ready-to-Dev

- GDD-001: ✅ YES
- GDD-002: ✅ YES
- GDD-003: ✅ YES
- GDD-004: ✅ YES
- GDD-005: ✅ YES
- GDD-006: ✅ YES

**All acceptance criteria are testable and clear. No ambiguity. Ready to assign to yersinia-gameplay-programmer.**
```

---

## RÉSUMÉ: Ce qu'a fait le PM

1. ✅ **Décomposé** gameplay-loop en 6 stories claires
2. ✅ **Documenté** chaque story avec:
   - AC testables
   - Context Yersinia chargé
   - Technical notes
   - Agent spécialisé recommandé
3. ✅ **Identifié** dépendences (GDD-001 blocker)
4. ✅ **Créé** sprint assignment (day 1-3)
5. ✅ **Analysé** risques (5 risques + mitigations)
6. ✅ **Validé** ready-to-dev pour tous

**Résultat:** Développeur gameplay-programmer peut commencer GDD-001 IMMÉDIATEMENT, sans questions. Tout est clair.

---

*Exemple PM Agent - Yersinia Gameplay Loop System*

# 📝 BACKLOG - GAMEPLAY LOOP SYSTEM

**System:** Gameplay Loop  
**Generated:** 2026-01-27 by Agent PM Yersinia  
**Priority:** Priority 1 (BLOCKER - MVP Foundation)  
**Total Stories:** 4  
**Total Hours:** 16-18  
**Sprint:** Sprint 1-2 (Days 1-2)  
**Team:** 1 dev senior + 1 dev junior  

---

## 🎯 STORIES BACKLOG

### GDD-001 | Game Manager & Run Initialization
- **Priority:** P1 (Blocker)
- **Hours:** 3h
- **Complexity:** Medium
- **Status:** ✅ Ready-to-Dev
- **Blocked by:** None
- **Unlocks:** GDD-002, GDD-003, GDD-004
- **Agent:** yersinia-gameplay-programmer
- **Sprint:** Day 1 (00:00-03:00)

**Description:** Créer le Game Manager global qui gère le state de chaque run. Initialisation run: créer joueur, initialiser PNJ system, setup vagues, démarrer Jour 1.

**Key ACs:**
- [x] Game Manager singleton, persists entre scenes
- [x] Run state initialized: night=1, player_alive=true, gloire=0
- [x] Player spawned at scene center
- [x] Joysticks initialized
- [x] Day 1 starts: PNJ accessible, enemies NOT spawning

**Risks:** Autoload complexity | State persistence | Performance
**Mitigation:** Use standard Godot pattern | Log state | Keep lean data

---

### GDD-002 | Day Phase Manager (Exploration & PNJ)
- **Priority:** P1 (Blocker)
- **Hours:** 4h
- **Complexity:** Medium
- **Status:** ✅ Ready-to-Dev
- **Blocked by:** GDD-001
- **Unlocks:** GDD-004 (transitions)
- **Agent:** yersinia-gameplay-programmer
- **Sprint:** Day 1 (03:00-07:00)

**Description:** Implémenter la phase JOUR - exploration libre, map navigation, PNJ accessible, joueur choisit transition Nuit.

**Key ACs:**
- [x] Map displayable (day-time sprite, ambiance)
- [x] Player movement smooth (8 directions)
- [x] PNJ 6 instances visible, positioned
- [x] PNJ dialogue UI opens (proximity trigger)
- [x] "Start Night" button clickable
- [x] Jour→Nuit transition smooth, state preserved

**Risks:** Input lag mobile | PNJ collision | Scene load time
**Mitigation:** Physics-based movement | Careful positioning | Lazy-load

---

### GDD-003 | Wave Manager & Continuous Spawn System
- **Priority:** P1 (Blocker)
- **Hours:** 5h
- **Complexity:** High
- **Status:** ✅ Ready-to-Dev
- **Blocked by:** GDD-001
- **Unlocks:** GDD-004, GDD-005, GDD-006
- **Agent:** yersinia-gameplay-programmer
- **Sprint:** Day 1 (07:00-13:00) + Day 2 (00:00-02:00)

**Description:** Implémenter Wave Manager spawn continu d'ennemis pendant Nuit. Progression: Nuit 1 (5-8 rats, spawn 30s) → Nuit 5 (50+ rats, spawn 3s).

**Key ACs:**
- [x] WaveManager continuous spawn algorithm
- [x] Spawn delay decreases per night (lerp/lookup)
- [x] Enemy pool: rat, mutant prefabs ready
- [x] Nuit 1: 5-8 rats over 90s
- [x] Nuit 5: 50+ rats continuously, boss once
- [x] Performance: ≥30 FPS with max load

**Risks:** FPS drops <30 | Spawn positions obstacles | Balance tuning
**Mitigation:** Object pooling tested | Pathfinding or zones | Tunable table

---

### GDD-004 | Night Phase Manager & Combat Loop
- **Priority:** P1 (Blocker)
- **Hours:** 4h
- **Complexity:** Medium
- **Status:** ✅ Ready-to-Dev
- **Blocked by:** GDD-001, GDD-003
- **Unlocks:** GDD-005, GDD-006, End-Run logic
- **Agent:** yersinia-gameplay-programmer
- **Sprint:** Day 2 (02:00-06:00)

**Description:** Implémenter phase NUIT - timer (45-90s), disable PNJ, enable WaveManager, joueur combats. Auto-transition ou Game Over.

**Key ACs:**
- [x] Night phase initializes: timer visible, countdown MM:SS
- [x] Enemies spawn continuously via WaveManager
- [x] PNJ invisible/non-interactible
- [x] Player can attack (damages in range)
- [x] Enemies can damage player (HP feedback)
- [x] Timer expires → next phase or end run
- [x] Player dies (HP=0) → Game Over, Gloire saved

**Risks:** Timer drift | Game Over state bugs | Death feedback
**Mitigation:** Use Time.get_ticks() | Log transitions | Add death animation

---

## 📊 SPRINT ALLOCATION

### Day 1 Schedule (8h dev)
```
08:00-11:00  GDD-001 - Game Manager (3h)
11:00-15:00  GDD-002 - Day phase (4h)
15:00-20:00  GDD-003 - Wave Manager start (5h+)
```

### Day 2 Schedule (8h dev)
```
08:00-10:30  GDD-003 - Wave Manager finish (2.5h)
10:30-14:30  GDD-004 - Night phase (4h)
14:30-15:00  Testing & fixes (0.5h)
```

### Parallel Work (Art team)
```
Day 1: Prepare enemy sprites (rat, mutant, boss)
Day 1: Prepare map day/night sprites
Day 1: Prepare PNJ sprites (6 types)
Day 2: UI assets (timer, button, HUD)
```

---

## 🧪 VALIDATION CHECKLIST

### Pre-Dev Review
- [ ] All 4 stories reviewed by team
- [ ] AC understood and testable
- [ ] Agent specialist acknowledged
- [ ] Dependencies clear
- [ ] Technical notes sufficient

### During-Dev (Daily)
- [ ] GDD-001: Game Manager compiles, runs without errors
- [ ] GDD-002: Player moves, PNJ visible, "Start Night" works
- [ ] GDD-003: Enemy spawns, count verified per night
- [ ] GDD-004: Timer runs, transitions work, Game Over screens

### Post-Dev (QA)
- [ ] Run initialization: <2s load
- [ ] Day phase: ≥60 FPS, smooth movement
- [ ] Night phase: ≥30 FPS with 50 enemies
- [ ] Combat: Damage feedback visible, knockback working
- [ ] Gloire: Saved post-game, visible on retry
- [ ] State persistence: 100% accurate across transitions

---

## 📈 SUCCESS METRICS

| Metric | Target | Pass Criteria |
|--------|--------|---------------|
| Run completes | 1 full run | 5 nights + boss visible |
| FPS stability | ≥30 during night 5 | No drops during combat |
| Gloire persistence | 100% accuracy | Same gloire on retry |
| Loop playable | ~10-15min/run | Feels balanced, engaging |
| MVP aligned | No scope creep | Only core loop, no extras |

---

## 🔗 RELATED DOCUMENTS

- **Main Stories Doc:** STORIES-GAMEPLAY-LOOP.md
- **Context Doc:** CONTEXT-GAMEPLAY-LOOP.md
- **Game Context:** GAMEPLAY-MECHANICS-context.md
- **Project Overview:** YERSINIA-PROJECT-CONTEXT.md
- **Agent PM:** yersinia-pm-project-manager.md

---

## 🚀 NEXT PHASES (Post Gameplay Loop)

After Gameplay Loop stories complete:

1. **GDD-005 & GDD-006:** Player combat mechanics (attack, knockback, dash)
2. **NPC System Stories:** Dialogue, upgrade economy, traitor logic
3. **Progression Stories:** Gloire save/load, stats persistence
4. **UI Polish:** HUD refinement, mobile optimization
5. **Playtesting & Balance:** Difficulty tuning, engagement metrics

---

**Generated by:** Agent PM Yersinia (yersinia-pm-project-manager.md)  
**Status:** ✅ COMPLETE & READY-TO-DEV  
**Next Action:** Assign stories to dev team, schedule kickoff meeting


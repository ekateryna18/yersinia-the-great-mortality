# 🎯 GUIDE: Agent PM Project Manager - Yersinia

**Tu as maintenant un PM agent qui connaît TOUTE la logique du jeu et peut créer des stories documentées avec contexte et agents spécialisés.**

---

## 🚀 QUICK START

### Charger l'agent PM:
```
@agent yersinia-pm
```

### Utilisation rapide:

```
# 1️⃣  Créer les stories pour un système
@agent yersinia-pm
Créer les stories pour le système [gameplay-loop | npc-system | ui-mobile | progression]

# 2️⃣  Planner sprint complet
@agent yersinia-pm
Planner sprint 1 (day 1-2)

# 3️⃣  Montrer backlog complet
@agent yersinia-pm
Montrer le backlog MVP complet

# 4️⃣  Analyser risques d'un système
@agent yersinia-pm
Analyser risques du système [système-name]
```

---

## 🧠 CE QUE L'AGENT PM SAIT

### Game Logic (Encodée dans l'agent):
✅ **Architecture Yersinia complète**
- Survivor Roguelike 2D isométrique (Hack'Slash avec vagues)
- Boucle jour/nuit (5 cycles = 1 run)
- Combat direct joueur, vagues continues ennemis
- 6 PNJ + 2 traîtres aléatoires
- Progression gloire + stats permanentes

✅ **Systèmes majeurs:**
- Gameplay Loop (jour exploration + nuit combats continus)
- NPC System (traîtres, dialogue, énigmes)
- Combat Joueur (faux melee direct, zone autour, knockback, dash)
- Enemy Waves (4 types, spawn continu+progressif)
- Progression (upgrade sources via PNJ)
- UI Mobile (joysticks déplacement+attaque)
- Asset Pipeline (sprites isométrique jour/nuit)

✅ **MVP Constraints (CRITIQUES):**
- 4 jours timeline = FIXED
- 30 FPS mobile min = FIXED
- 5 nuits durée = FIXED
- Système traître = REQUIRED
- Pas multijoueur, pas crafting, pas boss variantes

✅ **Anti-patterns (INTERDITS):**
- Pas progression infinie
- Pas UI overwhelming
- Pas state machines complexes
- Pas 3000+ lignes scripts
- Pas feature bloat

---

## 📋 OUTPUTS: Ce que l'agent PM crée

### 1. **Stories Documentées & Prêtes-à-Développer**

Format standardisé pour chaque story:

```markdown
## Story: GDD-001 - Game Loop Core (Jour/Nuit Cycle)

### Description
Implémenter la boucle jour/nuit fondamentale: transition jour→nuit, timer nuit, spawn vagues continues.

### Context Yersinia
- Jour: Illimité, PNJ accessibles, ennemis ne spawn PAS, joueur libre explorer
- Nuit: 90 sec max, PNJ fermés, vagues continues d'ennemis (spawn continu)
- Nuit 5: Boss final (rat boss) + 50+ ennemis intensifiés spawn continu

### Acceptance Criteria
- [ ] Jour state → affiche PNJ, permet déplacement libre, pas spawn ennemis
- [ ] Transition jour→nuit fonctionne (scene swap ou overlay)
- [ ] Nuit timer compte 90→0 secondes
- [ ] Première vague spawn automatique, puis spawn continu progressif
- [ ] Auto-transition vers nuit suivante après timer OU mort joueur

### Technical Notes
- Utiliser State Pattern pour Jour/Nuit
- Wave Manager handle spawn continu (pas discrete waves)
- UI show night counter + enemy count
- Asset: night tileset vs day tileset

### Agent Specialist
`@agent yersinia-gameplay-programmer` - Systèmes core gameplay

### Dependencies
- Blocked by: none (starter story)
- Unlocks: Enemy Waves, Combat System

### Risks
- **Risk:** State complexity avec PNJ transitions
- **Mitigation:** Use simple state enum (JOUR/NUIT)

### Estimation
- **Time:** 4 hours (day 1)
- **Complexity:** Medium
- **Ready-to-Dev:** ✅ YES
```

### 2. **Epic Breakdown avec Dependencies**

L'agent décompose grands systèmes en épics + stories ordonnées:

```
EPIC: Gameplay Core Loop
├── Story 1: Day/Night Cycle (blocker, 4h)
├── Story 2: Enemy Wave Spawn (depends on 1, 6h)
├── Story 3: Player Combat System (depends on 1, 6h)
└── Story 4: Night Transition & Boss Spawn (depends on 1-3, 4h)
```

### 3. **Sprint Planning (1-2 jours)**

Distribution stories par jour, ordonnée par MVP priority + dependencies:

```
## SPRINT 1 (Day 1-2) - BLOCKERS

Day 1:
- Morning: Game Loop (4h) → GDD-001
- Afternoon: Basic Player Movement (3h) → GDD-002

Day 2:
- Morning: Enemy Types Definition (3h) → GDD-003
- Afternoon: Wave Spawn System (5h) → GDD-004
```

### 4. **Risk Report & Contingencies**

L'agent identifie risques + mitigations:

```
### Risk: NPC State Complexity
- **Impact:** High (blocks npc-system)
- **Probability:** Medium (AI state machines tricky)
- **Mitigation:** Start with simple state enum, test state transitions daily
- **Fallback:** Pre-define NPC behaviors in config, avoid dynamic branching

### Risk: Performance (30 FPS target)
- **Impact:** Critical (mobile platform requirement)
- **Probability:** High (wave system + many enemies)
- **Mitigation:** Object pooling, ECS-lite architecture, profiling daily
- **Fallback:** Reduce wave density for MVP, cap max enemies 40
```

### 5. **Agent Dispatch Recommendations**

Pour chaque story, agent spécialisé recommandé:

```
- Gameplay Loop → @agent yersinia-gameplay-programmer
- NPC System → @agent yersinia-npc-system-architect
- UI Mobile → @agent yersinia-ui-systems-specialist
- Progression → @agent yersinia-progression-economy-specialist
- Assets → @agent yersinia-art-asset-director
- Optimization → @agent yersinia-mobile-performance-engineer
```

---

## 🎯 QUAND UTILISER CET AGENT PM

### ✅ PARFAIT POUR:

1. **Démarrer un projet** → "Planner sprint 1"
2. **Découper un système** → "Créer les stories pour gameplay-loop"
3. **Ajuster timeline** → "Analyser risques du système NPC"
4. **Assigner travail** → "Quelles stories aujourd'hui?"
5. **Escalader blockers** → "Quelle story bloque quoi?"
6. **Reporter status** → "Où on en est du MVP?"

### ❌ PAS POUR:

- Développer une story → Utilise agent spécialisé
- Écrire code → Utilise agent technique
- Créer des assets → Utilise art team
- Tester → Utilise QA agent

---

## 📊 EXEMPLE COMPLET: Créer les Stories du Gameplay Loop

### Request:
```
@agent yersinia-pm

Créer les stories pour le système gameplay-loop (jour/nuit, vagues, combat)
```

### Response de l'agent PM (exemple):

```markdown
# Breakdown: Gameplay Loop System
**Estimated:** 20-24 hours total dev time
**Risk Level:** Medium (core system, manageable complexity)
**Dependencies:** None (starter system)

---

## Epic 1: Day/Night Cycle Foundation

### Story GDD-001: Game Loop - Jour/Nuit State Machine
- **Description:** État jour vs nuit, transition, UI show état
- **AC:** [3 testable criteria]
- **Time:** 4h
- **Agent:** yersinia-gameplay-programmer
- **Ready:** ✅ YES

### Story GDD-002: Night Timer & Auto-Progression
- **Description:** Timer 90s nuit, count down UI, auto-transition
- **AC:** [3 testable criteria]
- **Time:** 3h
- **Dependency:** Blocks Wave Spawn
- **Agent:** yersinia-gameplay-programmer
- **Ready:** ✅ YES

---

## Epic 2: Wave System

### Story GDD-003: Enemy Wave Manager
- **Description:** Configurable wave progression (night 1→5), spawn delay
- **AC:** [4 testable criteria]
- **Time:** 6h
- **Dependency:** Depends on GDD-001
- **Agent:** yersinia-gameplay-programmer
- **Risk:** Wave balance complex - assign 2nd pair-programmer
- **Ready:** ✅ YES

### Story GDD-004: Enemy Spawning Algorithm
- **Description:** Spawn timing, enemy types, difficulty curve
- **AC:** [3 testable criteria]
- **Time:** 4h
- **Dependency:** Depends on GDD-003
- **Agent:** yersinia-gameplay-programmer
- **Ready:** ✅ YES

---

## Epic 3: Combat Integration

### Story GDD-005: Player Attack System
- **Description:** Joueur faux, zone attaque 90°, damage calculation
- **AC:** [4 testable criteria]
- **Time:** 5h
- **Dependency:** Depends on GDD-001 (day mode setup)
- **Agent:** yersinia-gameplay-programmer
- **Ready:** ✅ YES

### Story GDD-006: Enemy Knockback Physics
- **Description:** Knockback on hit, deceleration, collision avoidance
- **AC:** [3 testable criteria]
- **Time:** 3h
- **Dependency:** Depends on GDD-005
- **Agent:** yersinia-gameplay-programmer
- **Ready:** ✅ YES

---

## Sprint Assignment (Day 1-2)

### Day 1 (8h):
- GDD-001: Day/Night State (4h) ← **Start here**
- GDD-002: Night Timer (3h)
- (Afternoon break/async)

### Day 2 (8h):
- GDD-003: Wave Manager (6h)
- GDD-004: Spawn Algorithm (2h started)

### Day 2 Afternoon / Early Day 3:
- GDD-004: Spawn Algorithm (finish, 2h remaining)
- GDD-005: Player Attack (5h)

---

## Risks Identified

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Wave balance too complex | High | Config-driven waves, daily tuning |
| Enemy spawning lag | Critical | Object pooling, test FPS daily |
| Knockback physics jittery | Medium | Use physics-based impulse, test |
| State transitions buggy | Medium | Unit test state machine early |

---

## Dependencies Graph

```
GDD-001 (Day/Night) ←─ STARTER
├─→ GDD-002 (Night Timer) ← blocks GDD-003
├─→ GDD-005 (Player Attack) ← independent
│   └─→ GDD-006 (Knockback) ← depends on GDD-005
└─→ GDD-003 (Wave Manager)
    └─→ GDD-004 (Spawn Algorithm)
```

---

## Next Steps

1. **Today:** Load `@context gameplay-mechanics` for technical details
2. **Assign:** Give GDD-001 to gameplay-programmer
3. **Monitor:** Daily standups on FPS performance
4. **Ready-to-Dev:** All stories have AC testable ✅
```

---

## 🎮 CONTEXTES AUTO-CHARGÉS

L'agent PM charge automatiquement les contextes Yersinia pertinents:

```
✅ @context project-overview          (toujours)
✅ @context contraintes-mvp           (toujours)
✅ @context gameplay-mechanics        (si gameplay system)
✅ @context npc-traitor-system        (si NPC system)
✅ @context ui-mobile-design          (si UI system)
✅ @context progression-economy       (si progression system)
```

Tu peux aussi charger manuellement:
```
@context gameplay-mechanics
@context npc-traitor-system
@context ui-mobile-design
```

---

## 📞 COMMANDES RAPIDES

```bash
# Epic decomposition
@pm decompose gameplay-loop
@pm decompose npc-system
@pm decompose ui-mobile

# Risk analysis
@pm risk gameplay-loop
@pm risk npc-system

# Dependencies
@pm dependencies GDD-001

# Sprint management
@pm plan sprint 1
@pm today
@pm blockers
@pm burn-down sprint-1

# Story management
@pm create feature-name
@pm ready GDD-001
@pm assign GDD-001

# Reporting
@pm status
@pm risks sprint-1
@pm timeline gameplay-loop
```

---

## ✅ CHECKLIST: Before Dev Starts

L'agent PM valide chaque story:

- [ ] **Acceptance Criteria** testables et clairs
- [ ] **Dependencies** identifiées (blocker? unblock?)
- [ ] **Agent Specialist** assigné avec contexte
- [ ] **Risques** documentés + mitigations
- [ ] **Timeline** réaliste (padding pour risk)
- [ ] **MVP Alignment** validé (pas scope creep)
- [ ] **Technical Notes** suffisants pour commencer
- [ ] **Assets Required** listées (pour art team)
- [ ] **Ready-to-Dev = ✅ YES**

---

## 🎓 BEST PRACTICES

### 1. **Charger PM en PREMIER**
```
@agent yersinia-pm        ← Charge PM + contexts
→ Créer stories pour [système]
```

### 2. **Chaque Story Prête-à-Développer**
PM crée JAMAIS une story incomplète. Check ✅ Ready-to-Dev avant assign.

### 3. **Use Agent Dispatch**
Chaque story → recommandation agent spécialisé. Appelle-le:
```
@agent yersinia-gameplay-programmer   ← Fourni par PM
(avec contexte story déjà chargé)
```

### 4. **Daily Burn-Down**
```
@pm burn-down sprint-1        ← Voir progress, identifier blockers
```

### 5. **Risk Escalation**
Si blocker identifié:
```
@pm blockers                  ← Escalate immédiatement
```

---

## 🚀 READY TO START

Tu peux maintenant:

1. **Charger l'agent PM:** `@agent yersinia-pm`
2. **Créer des épics:** `@pm decompose gameplay-loop`
3. **Générer sprint:** `@pm plan sprint 1`
4. **Dispatcher agentsß:** Chaque story → agent spécialisé
5. **Monitor & track:** Daily burn-downs + risques

**Le PM agent décompose, documente, estime, identifie risques, et dispatche aux agents spécialisés. Tu fais juste demander et c'est fait.**

---

*Guide PM Agent - Yersinia: The Great Mortality - Game Jam 4 Days*

# 🎯 AGENT PM - Project Manager avec Logique Yersinia

**Tu as un Agent PM qui connaît TOUTE la logique du jeu Yersinia et peut découper le travail en stories documentées.**

---

## 🚀 DÉMARRER EN 30 SECONDES

```bash
# 1. Charger l'agent PM
@agent yersinia-pm

# 2. Demander décomposition d'un système
Créer les stories pour le système [gameplay-loop | npc-system | ui-mobile | progression]

# 3. ✅ Reçois stories prêtes-à-développer avec:
#    - Acceptance Criteria testables
#    - Context technique Yersinia
#    - Agent spécialisé recommandé
#    - Dépendences + risques
#    - Timeline réaliste
```

---

## 📋 CE QUE FAIT L'AGENT PM

### ✅ Décompose les systèmes en **épics documentés**
```
EPIC: Gameplay Loop
├── Story 1: Day/Night Cycle (4h)
├── Story 2: Wave Manager (6h)
├── Story 3: Combat System (6h)
└── Story 4: Boss Final (4h)
```

### ✅ Crée des **stories prêtes-à-développer**
```markdown
## Story: GDD-001 - Day/Night Cycle

### Acceptance Criteria
- [ ] Jour mode: PNJ accessibles, enemies OFF
- [ ] Nuit mode: enemies spawn, PNJ fermés
- [ ] Timer 90s visible, auto-transition

### Agent Specialist
@agent yersinia-gameplay-programmer

### Dependencies
Blocker: NONE | Unlocks: Wave Manager, Combat

### Estimation
Time: 4 hours | Complexity: Medium | Ready-to-Dev: ✅ YES
```

### ✅ Identifie **blockers et dépendences**
```
GDD-001 (starter, aucun blocker)
├─ GDD-002 (depends on GDD-001)
├─ GDD-003 (depends on GDD-001)
└─ GDD-004 (depends on GDD-002)
```

### ✅ Analyse les **risques + contingencies**
```
Risk: Wave complexity too high
→ Mitigation: Config-driven waves, daily tuning
→ Fallback: Reduce enemy count from 50 to 30
```

### ✅ Dispatche aux **agents spécialisés**
```
Gameplay → @agent yersinia-gameplay-programmer
NPC      → @agent yersinia-npc-system-architect
UI       → @agent yersinia-ui-systems-specialist
etc.
```

---

## 📊 UTILISATION PRATIQUE

### Exemple 1: Planner un Sprint Complet

```bash
@agent yersinia-pm
Planner sprint 1 (day 1-2) avec backlog MVP
```

**Output:**
```markdown
## SPRINT 1 - Day 1-2

### Day 1 (8 hours)
- GDD-001: Day/Night Cycle (4h) ← Blocker, START HERE
- GDD-002: Night Timer (3h)
- (1h buffer)

### Day 2 (8 hours)  
- GDD-003: Wave Manager (6h)
- GDD-004: Spawn Algorithm (2h started)

### Risk: ...
### Dependencies: [graph]
```

### Exemple 2: Découper le Système NPC

```bash
@agent yersinia-pm
Créer les stories pour le système NPC & traîtres
```

**Output:**
```markdown
## NPC System Breakdown

### Epic 1: NPC Foundation
- NPC-001: NPC Dialogue System (6h)
- NPC-002: 6 NPC Types Definition (4h)
- NPC-003: NPC Shop Integration (5h)

### Epic 2: Traitor System
- NPC-004: Random Traitor Selection (3h)
- NPC-005: Traitor Consequences (4h)
- NPC-006: Riddle Hint System (4h)

### Risks Identified:
- AI state complexity
- Traitor balance
- Dialogue branch trees

### Agent: @agent yersinia-npc-system-architect
```

### Exemple 3: Analyser Risques

```bash
@agent yersinia-pm
Analyser risques du système gameplay-loop
```

**Output:**
```markdown
## Risk Analysis - Gameplay Loop

| Risk | Impact | Probability | Mitigation | Fallback |
|------|--------|-------------|-----------|----------|
| Wave scaling too hard | CRITICAL | HIGH | Daily tuning config | Cap enemies 30 |
| 30 FPS performance miss | CRITICAL | MEDIUM | Object pooling, profile | Reduce particles |
| State transition bugs | HIGH | MEDIUM | Unit test early | Rollback to simple enum |
| Boss difficulty | MEDIUM | MEDIUM | Balance via config | Pre-set difficulty curve |
```

---

## 🎮 CONTEXTS AUTO-CHARGÉS

L'agent PM charge automatiquement (tu dois juste demander):

```
✅ project-overview          (toujours)
✅ contraintes-mvp           (toujours - OBLIGATOIRE)
✅ gameplay-mechanics        (si gameplay system)
✅ npc-traitor-system        (si NPC system)
✅ ui-mobile-design          (si UI system)
✅ progression-economy       (si progression system)
```

Tu peux aussi charger manuellement:
```
@context gameplay-mechanics
@context npc-traitor-system
```

---

## 🧠 LOGIQUE YERSINIA ENCODÉE

### Que sait l'agent PM sur le jeu:

```
✅ Architecture: Survivor Roguelike 2D isométrique (Hack'Slash avec vagues)
✅ Loop: [Jour exploration] → [Nuit 45-90s vagues continues] × 5 cycles
✅ Combat: Joueur faux melee direct, attaque zone autour, knockback, dash
✅ Ennemis: 4 types, vagues continues+progressives par nuit, spawn intelligent
✅ PNJ: 6 par run, 2 traîtres, énigmes
✅ Progression: Gloire + stats permanentes
✅ UI: Mobile first, joysticks, 44x44px targets
✅ Assets: Sprites isométrique hybride (custom + free)
✅ Constraints: 4j timeline, 30 FPS, <5s load, <200MB memory
✅ Anti-patterns: Pas multijoueur, pas boss variantes, pas feature bloat
```

Donc quand tu demandes des stories, l'agent PM **sait déjà tout ça**.

---

## 📞 COMMANDES RAPIDES

### Epic Management
```bash
@pm decompose gameplay-loop      # Décomposer epic en stories
@pm decompose npc-system
@pm decompose ui-mobile

@pm risk gameplay-loop           # Analyser risques
@pm dependencies GDD-001         # Voir dépendences
```

### Sprint Planning
```bash
@pm plan sprint 1                # Planner sprint complet
@pm today                        # Stories à faire aujourd'hui
@pm blockers                     # Montrer blockers
@pm burn-down sprint-1           # Voir progress
```

### Story Management
```bash
@pm create feature-name          # Créer 1 story
@pm ready GDD-001                # Story ready-to-dev?
@pm assign GDD-001               # Assigner agent
```

### Reporting
```bash
@pm status                       # Voir état projet
@pm risks sprint-1               # Risques du sprint
@pm timeline gameplay-loop       # Timeline réaliste
```

---

## ✅ CHECKLIST: Avant Dev

L'agent PM valide chaque story AVANT assignation:

- [ ] **Acceptance Criteria** testables ✅
- [ ] **Dependencies** claires (blocker? unblock?) ✅
- [ ] **Agent Specialist** assigné ✅
- [ ] **Risques** documentés + mitigations ✅
- [ ] **Timeline** réaliste (padding) ✅
- [ ] **MVP Alignment** OK (pas scope creep) ✅
- [ ] **Technical Notes** suffisants ✅
- [ ] **Assets Required** listées (pour art team) ✅
- [ ] **Ready-to-Dev = ✅ YES**

Si une story dit `Ready-to-Dev: ❌ NO`, elle doit être complétée avant de commencer.

---

## 🎯 WORKFLOW COMPLET

### Workflow 1: Planner d'un bout à l'autre

```bash
# 1. Charge PM + contexts
@agent yersinia-pm

# 2. Demande breakdown complet
Créer les stories pour tous les systèmes MVP

# 3. Reçois backlog complet:
#    - Tous épics + stories
#    - Sprint 1-4 assignment
#    - Risques globaux
#    - Agents recommandés
#    - Timeline 4 jours planné

# 4. Assigne à agents spécialisés
@agent yersinia-gameplay-programmer
(avec story + context du PM déjà chargé)
```

### Workflow 2: Planner au jour le jour

```bash
# Le matin
@agent yersinia-pm
Quelles stories faire aujourd'hui?

# Travail
@agent [specialist-agent]
Implémenter story [ID]

# Soir
@agent yersinia-pm
Burn-down sprint - on a complété quoi?
```

---

## 🚀 JE SUIS PRÊT

Tu peux maintenant:

1. **Charger:** `@agent yersinia-pm`
2. **Demander:** "Créer les stories pour [système]"
3. **Recevoir:** Stories prêtes-à-dev + épics + risques
4. **Dispatcher:** Chaque story → agent spécialisé
5. **Tracker:** Daily burn-downs + risques

**Le PM agent s'occupe de la décomposition, la documentation, l'estimation, les risques. Tu dis quoi faire, ça le fait.**

---

## 📚 LIRE AUSSI

- [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md) - Documentation complète
- [DOCUMENTATION.md](DOCUMENTATION.md) - All agents & contexts
- [manifest.yaml](manifest.yaml) - Index complet

---

*Agent PM Yersinia - Ready to plan, decompose, and dispatch work to specialized agents.*

# 🗂️ INDEX - PM AGENT YERSINIA COMPLETE

**Status:** ✅ Ready-to-Use  
**Last Updated:** 2026-01-27  
**Agent:** yersinia-pm-project-manager.md  
**Systems Documented:** Gameplay Loop (Core) + PM Foundation  

---

## 📍 QUICK NAVIGATION

### 🎮 MAIN AGENT
**[yersinia-pm-project-manager.md](yersinia-pm-project-manager.md)** - The PM Agent  
Central PM agent avec full game logic (Survivor Roguelike).  
Crée stories, décompose systèmes, gère sprints, identifie risques.

### 📚 CONTEXTS (Game Knowledge)
**[YERSINIA-PROJECT-CONTEXT.md](YERSINIA-PROJECT-CONTEXT.md)** - Game Overview  
Architecture complète, systèmes majeurs, contraintes MVP, specs techniques.

**[GAMEPLAY-MECHANICS-context.md](GAMEPLAY-MECHANICS-context.md)** - Gameplay Details  
Jour/nuit cycle, combat, waves, stats, enemy AI, input mobile.

**[NPC-TRAITOR-SYSTEM-context.md](NPC-TRAITOR-SYSTEM-context.md)** - NPC System (if exists)  
6 PNJ, 2 traîtres, dialogue, upgrade, énigmes.

### 📖 PM DOCUMENTATION
**[README-PM-AGENT.md](README-PM-AGENT.md)** - 5-Min Quick Start  
What PM agent does, how to use, key commands.

**[GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md)** - Comprehensive Guide  
Story templates, risk management, agent dispatch, examples.

**[EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md)** - Example Stories  
Real gameplay loop stories (GDD-001 to GDD-006) walkthrough.

**[CHECKLIST-PM-AGENT.md](CHECKLIST-PM-AGENT.md)** - Validation Checklist  
Pre/during/post development validation, metrics.

**[PM-AGENT-CREATED.md](PM-AGENT-CREATED.md)** - What Was Created  
Files generated, architecture, capabilities, usage.

**[RÉSUMÉ-COMPLET.md](RÉSUMÉ-COMPLET.md)** - French Complete Summary  
French full system summary (for FR-speaking team).

**[00-CRÉATION-COMPLÈTE.md](00-CRÉATION-COMPLÈTE.md)** - French Complete Creation Report  
French full report on what was created & how to use.

---

## 🎯 GAMEPLAY LOOP STORIES (Just Generated!)

**[STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md)** ⭐ **START HERE FOR DEV**  
4 stories ready-to-develop (GDD-001 to GDD-004).  
Each story has AC, technical notes, risks, estimation, agent assigned.

**[CONTEXT-GAMEPLAY-LOOP.md](CONTEXT-GAMEPLAY-LOOP.md)** - Gameplay Loop Context  
Sprint plan, architecture pattern, scene structure, test scenarios.

**[BACKLOG-GAMEPLAY-LOOP.md](BACKLOG-GAMEPLAY-LOOP.md)** - Gameplay Loop Backlog  
Prioritized stories, sprint allocation, validation metrics, tracking.

**[GENERATION-GAMEPLAY-LOOP-COMPLETE.md](GENERATION-GAMEPLAY-LOOP-COMPLETE.md)** - Generation Report  
What was generated, how to use, next steps.

---

## ✅ CORRECTION REFERENCE

**[CORRECTION-SURVIVOR.md](CORRECTION-SURVIVOR.md)** - Genre Correction Log  
Tower Defense → Survivor Roguelike correction details.  
All changes made to reflect true Survivor mechanics.

---

## 🗺️ DIRECTORY STRUCTURE

```
_bmad/gds/custom/
├── 📄 agents/
│   └── yersinia-pm-project-manager.md         ⭐ MAIN AGENT
│
├── 📄 contexts/
│   ├── YERSINIA-PROJECT-CONTEXT.md            (Game overview)
│   ├── GAMEPLAY-MECHANICS-context.md          (Gameplay details)
│   └── [NPC-TRAITOR-SYSTEM-context.md]        (If exists)
│
├── 📚 PM Documentation/
│   ├── START-HERE.md                          (30s overview)
│   ├── README-PM-AGENT.md                     (5min quick start)
│   ├── GUIDE-PM-AGENT.md                      (Full guide)
│   ├── EXAMPLE-PM-AGENT.md                    (Example stories)
│   ├── CHECKLIST-PM-AGENT.md                  (Validation)
│   ├── PM-AGENT-CREATED.md                    (What was created)
│   ├── RÉSUMÉ-COMPLET.md                      (French summary)
│   ├── 00-CRÉATION-COMPLÈTE.md                (French full report)
│   └── INDEX-PM-AGENT.md                      (This file!)
│
├── 📖 Generated Stories (NEW!)
│   ├── STORIES-GAMEPLAY-LOOP.md               ⭐ 4 STORIES READY-TO-DEV
│   ├── CONTEXT-GAMEPLAY-LOOP.md               (Context & architecture)
│   ├── BACKLOG-GAMEPLAY-LOOP.md               (Backlog tracking)
│   └── GENERATION-GAMEPLAY-LOOP-COMPLETE.md  (Generation report)
│
└── 📋 Reference/
    ├── CORRECTION-SURVIVOR.md                 (Genre correction log)
    └── [This INDEX file]
```

---

## 🎯 HOW TO USE THIS

### For Project Managers
1. Read: [README-PM-AGENT.md](README-PM-AGENT.md) (5 min)
2. Load agent: Review [yersinia-pm-project-manager.md](yersinia-pm-project-manager.md)
3. Create stories: Use command `@agent yersinia-pm → Créer les stories pour [système]`
4. Track: Use [BACKLOG-GAMEPLAY-LOOP.md](BACKLOG-GAMEPLAY-LOOP.md) template

### For Developers
1. Read: [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) (the 4 stories)
2. Understand context: [GAMEPLAY-MECHANICS-context.md](GAMEPLAY-MECHANICS-context.md)
3. Review architecture: [CONTEXT-GAMEPLAY-LOOP.md](CONTEXT-GAMEPLAY-LOOP.md)
4. Start Dev: GDD-001 (Game Manager), then GDD-002 (Day Phase)

### For Technical Leads
1. Review: [YERSINIA-PROJECT-CONTEXT.md](YERSINIA-PROJECT-CONTEXT.md) (architecture)
2. Validate stories: [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md)
3. Plan sprints: [BACKLOG-GAMEPLAY-LOOP.md](BACKLOG-GAMEPLAY-LOOP.md)
4. Track risks: Each story has risk section

### For French-Speaking Team
1. Start: [RÉSUMÉ-COMPLET.md](RÉSUMÉ-COMPLET.md)
2. Full report: [00-CRÉATION-COMPLÈTE.md](00-CRÉATION-COMPLÈTE.md)
3. Stories: [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) (bilingual format)

---

## 🔄 WORKFLOW: HOW TO USE THE PM AGENT

### Step 1: Load the Agent
```
@agent yersinia-pm
```
Agent loads with full Yersinia game logic (Survivor Roguelike, all systems).

### Step 2: Create Stories for a System
```
@agent yersinia-pm
Créer les stories pour le système [système name]
```

Example systems:
- `gameplay-loop` → 4 stories (DONE ✅)
- `npc-system` → Stories for PNJ + traitor
- `combat-mechanics` → Player attack, knockback, dash
- `progression` → Gloire, stats, upgrades
- `ui-mobile` → Joysticks, HUD, menus

### Step 3: Get Stories
PM generates:
1. **Epic decomposition** (what features)
2. **Stories with AC** (testable criteria)
3. **Technical notes** (GDScript patterns, Godot setup)
4. **Dependencies** (blocked by? unlocks?)
5. **Risks + mitigation** (contingencies)
6. **Agent specialists** (who develops this?)
7. **Estimations** (hours, complexity)
8. **Sprint assignment** (day-by-day schedule)

### Step 4: Document & Track
Use templates:
- Copy story format from [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md)
- Track in [BACKLOG-GAMEPLAY-LOOP.md](BACKLOG-GAMEPLAY-LOOP.md) (update status)
- Validate with [CHECKLIST-PM-AGENT.md](CHECKLIST-PM-AGENT.md)

---

## 📊 KEY METRICS

### Gameplay Loop (Just Generated)
| Metric | Value |
|--------|-------|
| Stories | 4 (GDD-001 to GDD-004) |
| Total Hours | 16-18h |
| Sprint | Days 1-2 |
| Complexity | 3 Medium + 1 High |
| Ready-to-Dev | ✅ 100% |
| Dependencies | Clear & ordered |
| Risks | Identified + mitigated |

### Full MVP Backlog (Estimated)
| System | Stories | Hours | Priority |
|--------|---------|-------|----------|
| Gameplay Loop | 4 | 16-18 | P1 |
| Combat Mechanics | 2-3 | 8-10 | P1 |
| NPC System | 3-4 | 10-12 | P2 |
| Progression | 2-3 | 6-8 | P2 |
| UI Mobile | 2-3 | 6-8 | P3 |
| Polish & Balance | 2 | 4-6 | P3 |
| **TOTAL MVP** | **~17-19** | **50-62h** | **4 days** |

---

## 🚀 NEXT SYSTEMS (Post Gameplay Loop)

After Gameplay Loop stories complete:

### System: Player Combat Mechanics (Priority 1)
- GDD-005: Player Attack (melee, zone, knockback)
- GDD-006: Player Dash (cooldown, evasion)
- Stories: 2-3 total

### System: NPC System (Priority 2)
- Stories for 6 PNJ types
- Dialogue framework
- Upgrade economy
- Traitor logic & consequences
- Stories: 3-4 total

### System: Progression Economy (Priority 2)
- Gloire save/load
- Stats persistence
- Upgrade sources (Forgeron, Marchand, Magicien)
- Stories: 2-3 total

---

## ✨ FEATURES OF THIS PM SYSTEM

✅ **Full game context** - Agent knows Survivor Roguelike, not Tower Defense  
✅ **Story templates** - Standardized format with AC, risks, estimations  
✅ **Agent dispatch** - Recommends specialist for each story  
✅ **Risk management** - Identifies blockers + contingencies  
✅ **Sprint planning** - Day-by-day allocation, dependency ordering  
✅ **Documentation** - 3+ formats (stories, context, backlog)  
✅ **Validation** - Pre/during/post dev checklists  
✅ **MVP focus** - No scope creep, 4-day constraint encoded  
✅ **Mobile optimization** - Touch targets, 30 FPS target, <200MB  
✅ **Performance targets** - Concrete FPS, load time, memory goals  

---

## 🎓 LEARNING RESOURCES

- **How stories are made:** [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md) (Phase 1-5 workflow)
- **Example real stories:** [EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md) (Gameplay loop walkthrough)
- **Game mechanics details:** [GAMEPLAY-MECHANICS-context.md](GAMEPLAY-MECHANICS-context.md) (Deep dive)
- **Architecture overview:** [YERSINIA-PROJECT-CONTEXT.md](YERSINIA-PROJECT-CONTEXT.md) (8 systems)

---

## 📞 QUICK REFERENCE

### Commands
```
@agent yersinia-pm                          → Load agent
@pm decompose [system]                      → Epic decomposition
@pm create [feature]                        → Single story
@pm risk [system]                           → Risk analysis
@pm plan sprint [1-4]                       → Sprint planning
@pm status                                  → Project status
```

### File Organization
```
Stories          → STORIES-GAMEPLAY-LOOP.md
Backlog/Tracking → BACKLOG-GAMEPLAY-LOOP.md
Context          → CONTEXT-GAMEPLAY-LOOP.md
Architecture     → YERSINIA-PROJECT-CONTEXT.md
Technical        → GAMEPLAY-MECHANICS-context.md
```

### Roles
```
PM Lead          → Use agent + create stories
Dev Lead         → Review stories, assign, track
Developers       → Read stories, implement AC
QA              → Validate against AC checklist
Art Team        → Parallel asset creation
```

---

## ⚡ FAST START (2 minutes)

1. **For Devs:** Open [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) → Read GDD-001 → Start coding
2. **For PM:** Open [README-PM-AGENT.md](README-PM-AGENT.md) → Understand workflow → Use agent for next system
3. **For Tech Leads:** Open [YERSINIA-PROJECT-CONTEXT.md](YERSINIA-PROJECT-CONTEXT.md) → Understand architecture → Review stories

---

## ✅ COMPLETION STATUS

- ✅ Agent PM created (yersinia-pm-project-manager.md)
- ✅ Contexts loaded (project overview, gameplay mechanics, NPC system)
- ✅ PM documentation complete (9 docs)
- ✅ Gameplay Loop stories generated (4 stories, 16-18h)
- ✅ All documentation generated (Stories, Context, Backlog)
- ✅ Index created (this file!)

**Status:** 🟢 **READY FOR PRODUCTION USE**

---

*Generated by Agent PM Yersinia*  
*Last Updated: 2026-01-27*  
*All systems follow Survivor Roguelike specification*  
*MVP-focused, 4-day constraint encoded*


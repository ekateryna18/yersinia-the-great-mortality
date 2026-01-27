# 🗂️ INDEX - PM + GAMEPLAY PROGRAMMER AGENTS (COMPLETE)

**Status:** ✅ Full Agent Suite Ready  
**Last Updated:** 2026-01-27  
**Agents Available:** PM + Gameplay Programmer  
**Systems Ready:** Gameplay Loop (Stories + Implementation)  

---

## 🎯 TWO AGENTS, ONE FLOW

### 1️⃣ Agent PM (Planning & Decomposition)
**File:** [yersinia-pm-project-manager.md](agents/yersinia-pm-project-manager.md)  
**Role:** Create stories from systems  
**Input:** "Créer les stories pour [système]"  
**Output:** Stories with AC, risks, estimations  

### 2️⃣ Agent Gameplay Programmer (Implementation & Execution)
**File:** [yersinia-gameplay-programmer.md](agents/yersinia-gameplay-programmer.md) ⭐ **NEW**  
**Role:** Implement stories with production code  
**Input:** "Implémenter GDD-001"  
**Output:** Complete GDScript, validation steps, debug tips  

---

## 🔄 WORKFLOW: PM → PROGRAMMER → QA

```
┌──────────────────────────────────────┐
│ 1. Agent PM (yersinia-pm)            │
│    "Créer les stories"               │
│    → 4 stories: GDD-001 to GDD-004   │
│    → AC testable                     │
│    → Risks identified                │
└──────────────────────────────────────┘
                ↓
┌──────────────────────────────────────┐
│ 2. Agent Programmer (NEW!)           │
│    "Implémenter GDD-001"             │
│    → Production GDScript              │
│    → AC validation                   │
│    → FPS profiling                   │
└──────────────────────────────────────┘
                ↓
┌──────────────────────────────────────┐
│ 3. QA Testing                        │
│    "Valider GDD-001"                 │
│    → All AC passing                  │
│    → Performance checked             │
│    → Ready for GDD-002               │
└──────────────────────────────────────┘
```

---

## 📍 FILE STRUCTURE

```
_bmad/gds/custom/

├── agents/
│   ├── yersinia-pm-project-manager.md          (PM Agent)
│   └── yersinia-gameplay-programmer.md         (Programmer Agent) ⭐ NEW
│
├── contexts/
│   ├── YERSINIA-PROJECT-CONTEXT.md             (Game overview)
│   ├── GAMEPLAY-MECHANICS-context.md           (Mechanics)
│   └── [NPC-TRAITOR-SYSTEM-context.md]         (If exists)
│
├── 📖 DOCUMENTATION/
│   ├── README-PM-AGENT.md                      (PM quickstart)
│   ├── README-GAMEPLAY-PROGRAMMER.md           (Programmer quickstart) ⭐ NEW
│   ├── GUIDE-PM-AGENT.md                       (PM guide)
│   ├── EXAMPLE-PM-AGENT.md                     (PM examples)
│   ├── CHECKLIST-PM-AGENT.md                   (Validation)
│   ├── PM-AGENT-CREATED.md                     (PM report)
│   ├── RÉSUMÉ-COMPLET.md                       (French summary)
│   └── 00-CRÉATION-COMPLÈTE.md                 (French report)
│
├── 📖 GAMEPLAY LOOP STORIES/
│   ├── STORIES-GAMEPLAY-LOOP.md                (4 stories with AC)
│   ├── CONTEXT-GAMEPLAY-LOOP.md                (Architecture)
│   ├── BACKLOG-GAMEPLAY-LOOP.md                (Tracking)
│   ├── GENERATION-GAMEPLAY-LOOP-COMPLETE.md   (Report)
│   └── EXECUTIVE-SUMMARY-GAMEPLAY-LOOP.md     (Summary)
│
├── 📋 AGENT CREATION REPORTS/
│   ├── CORRECTION-SURVIVOR.md                  (Genre correction)
│   ├── CREATION-GAMEPLAY-PROGRAMMER-COMPLETE.md (Programmer creation report) ⭐ NEW
│   └── [INDEX-COMPLETE.md]                     (Old index)
│
└── 📍 THIS FILE
    └── INDEX-AGENTS-COMPLETE.md                (Navigation guide) ⭐ NEW
```

---

## 🚀 HOW TO USE (Quick Start)

### For Project Managers
**Goal:** Create well-planned stories

1. **Read:** [README-PM-AGENT.md](README-PM-AGENT.md) (5 min)
2. **Load:** `@agent yersinia-pm`
3. **Create:** `Créer les stories pour [système]`
4. **Deliverable:** 4-5 stories with AC, risks, estimations

### For Programmers
**Goal:** Implement stories into playable code

1. **Read:** [README-GAMEPLAY-PROGRAMMER.md](README-GAMEPLAY-PROGRAMMER.md) (5 min)
2. **Review:** [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) (AC overview)
3. **Load:** `@agent yersinia-gameplay-programmer`
4. **Implement:** `Implémenter GDD-001` (or GDD-002, GDD-003, GDD-004)
5. **Deliverable:** Production GDScript, passing AC, FPS ≥30

### For Technical Leads
**Goal:** Oversee architecture & sprint

1. **Read:** [YERSINIA-PROJECT-CONTEXT.md](contexts/YERSINIA-PROJECT-CONTEXT.md) (30 min)
2. **Review:** [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) (AC clarity)
3. **Plan:** [BACKLOG-GAMEPLAY-LOOP.md](BACKLOG-GAMEPLAY-LOOP.md) (sprint assignment)
4. **Track:** Daily standup against AC & FPS metrics

### For QA/Testing
**Goal:** Validate stories meet AC

1. **Read:** [CHECKLIST-PM-AGENT.md](CHECKLIST-PM-AGENT.md) (validation guide)
2. **Get:** AC list from [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md)
3. **Test:** Each AC checkbox-by-checkbox
4. **Report:** Pass/Fail + FPS metrics

---

## 📊 AGENTS AT A GLANCE

| Agent | Role | Input | Output | Files |
|-------|------|-------|--------|-------|
| **PM** | Decompose systems | System name | Stories with AC | GDD-001-004 |
| **Programmer** ⭐ | Implement stories | Story ID | Production code | GDScript files |

---

## 🎯 STORIES (READY FOR IMPLEMENTATION)

### 4 Core Gameplay Loop Stories

| Story | Title | Hours | Complex | Status |
|-------|-------|-------|---------|--------|
| **GDD-001** | Game Manager & Run Init | 3h | 🟡 Medium | ✅ Ready |
| **GDD-002** | Day Phase Manager | 4h | 🟡 Medium | ✅ Ready |
| **GDD-003** | Wave Manager Spawn | 5h | 🔴 High | ✅ Ready |
| **GDD-004** | Night Phase Combat | 4h | 🟡 Medium | ✅ Ready |

**Total:** 16-18h (Days 1-2 of 4-day sprint)

---

## 📖 QUICK REFERENCE COMMANDS

### PM Agent Commands
```
@agent yersinia-pm
Créer les stories pour le système [nom]

@pm decompose [system]        → Epic decomposition
@pm risk [system]              → Risk analysis
@pm plan sprint [1-4]          → Sprint planning
```

### Programmer Agent Commands ⭐ NEW
```
@agent yersinia-gameplay-programmer
Implémenter GDD-001

@impl GDD-001                  → Full implementation
@impl GDD-001 phase 1          → Just setup
@code [pattern]                → Code pattern
@debug [issue]                 → Debug help
@profile [system]              → FPS profiling
```

---

## 🧠 WHAT EACH AGENT KNOWS

### Agent PM
✅ Yersinia game logic (Survivor Roguelike)  
✅ 7 major systems (gameplay loop, combat, NPC, progression, etc.)  
✅ MVP constraints (4 days, 30 FPS, <200MB)  
✅ Story decomposition patterns  
✅ Risk identification & mitigation  
✅ Sprint planning  

### Agent Programmer ⭐
✅ All 4 stories (GDD-001-004) with AC  
✅ Godot 4.6 patterns (autoloads, pooling, transitions)  
✅ Performance optimization (30 FPS target)  
✅ Mobile development best practices  
✅ Debugging toolkit (FPS, memory, state)  
✅ Risk mitigations (from PM)  

---

## ✨ HIGHLIGHTS

### What You Get (Complete System)
1. ✅ **PM Planning** - Stories with clear AC, risked, estimated
2. ✅ **Programmer Implementation** - Production code, patterns, validation
3. ✅ **Documentation** - Quick starts, guides, checklists
4. ✅ **Contexts** - Game architecture, mechanics, systems
5. ✅ **Integration** - PM → Programmer → QA clear flow

### Why This Works
- **Clear handoff:** PM defines AC, Programmer implements AC, QA validates AC
- **No ambiguity:** Stories include technical notes, code patterns, validation steps
- **Performance focused:** FPS targets encoded in AC & implementation
- **Mobile-ready:** Touch inputs, memory budgets, device optimization baked in
- **Risk-aware:** Blockers identified, mitigations provided

---

## 🚀 EXECUTION ROADMAP

### Sprint 1 (Days 1-2): Gameplay Loop Core
```
Day 1 morning:    GDD-001 (Game Manager) ✅
Day 1 afternoon:  GDD-002 (Day Phase) ✅
Day 1 late/Day 2: GDD-003 (Wave Manager) ✅
Day 2 afternoon:  GDD-004 (Night Phase) ✅

Result: Full gameplay loop playable
```

### Sprint 2 (Days 2-3): Combat & Polish
```
GDD-005: Player Attack (hack'slash)
GDD-006: Player Dash (evasion)
GDD-007: Combat Feedback (effects, knockback)
```

### Sprint 3 (Day 3): NPC & Progression
```
NPC stories: Dialogue, upgrade, traitor
Progression: Gloire, stats, persistence
```

---

## 📞 WHEN TO USE WHICH AGENT

### Use Agent PM When:
- You need to decompose a system into stories
- You need to identify risks & blockers
- You need to plan a sprint
- You need to understand game architecture
- You need story templates

### Use Agent Programmer When:
- You need to implement a story
- You need production-ready code
- You need debugging help
- You need performance optimization
- You need code patterns & examples
- You're stuck on a technical blocker

### When to Escalate Between Agents
```
Programmer stuck → "AC unclear, ask PM"
PM asked for code → "Programmer will implement"
Blocker found → "Escalate to PM for sprint adjust"
Performance risk → "Programmer optimizes, reports back"
```

---

## 📊 SUCCESS METRICS

### After Gameplay Loop (Both Agents Complete)
- ✅ 4 stories fully implemented
- ✅ All AC passing (100% checkboxes)
- ✅ FPS ≥30 during night phase
- ✅ Memory <200MB
- ✅ Game loop fully playable
- ✅ Gloire persists correctly
- ✅ Ready for next systems

### End of 4-Day Sprint (Full MVP)
- ✅ Gameplay loop stable
- ✅ Combat mechanics working
- ✅ NPC system integrated
- ✅ Progression saving/loading
- ✅ Playable game
- ✅ Deployable to mobile

---

## 📚 REQUIRED READING

**For Everyone:**
- [ ] [README-PM-AGENT.md](README-PM-AGENT.md) (if planning)
- [ ] [README-GAMEPLAY-PROGRAMMER.md](README-GAMEPLAY-PROGRAMMER.md) (if developing) ⭐ NEW
- [ ] [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md) (everyone needs AC)

**For Programmers:**
- [ ] [GAMEPLAY-MECHANICS-context.md](contexts/GAMEPLAY-MECHANICS-context.md)
- [ ] [YERSINIA-PROJECT-CONTEXT.md](contexts/YERSINIA-PROJECT-CONTEXT.md)

**For PM:**
- [ ] [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md)
- [ ] [EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md)

**For Tech Leads:**
- [ ] [EXECUTIVE-SUMMARY-GAMEPLAY-LOOP.md](EXECUTIVE-SUMMARY-GAMEPLAY-LOOP.md)
- [ ] [BACKLOG-GAMEPLAY-LOOP.md](BACKLOG-GAMEPLAY-LOOP.md)

---

## ⚡ FAST START (2 MINUTES)

### If you're a Programmer (Start here!)
1. Open [README-GAMEPLAY-PROGRAMMER.md](README-GAMEPLAY-PROGRAMMER.md)
2. Load agent: `@agent yersinia-gameplay-programmer`
3. Request: `Implémenter GDD-001`
4. Follow the code output

### If you're a PM (Start here!)
1. Open [README-PM-AGENT.md](README-PM-AGENT.md)
2. Load agent: `@agent yersinia-pm`
3. Request: `Créer les stories pour gameplay-loop`
4. Get 4 stories ready-to-dev

### If you're a Tech Lead (Start here!)
1. Open [EXECUTIVE-SUMMARY-GAMEPLAY-LOOP.md](EXECUTIVE-SUMMARY-GAMEPLAY-LOOP.md)
2. Review [STORIES-GAMEPLAY-LOOP.md](STORIES-GAMEPLAY-LOOP.md)
3. Assign GDD-001 to programmer
4. Schedule daily standup

---

## 🏁 FINAL STATUS

✅ **Complete Agent Suite Ready**

- ✅ Agent PM (planning & decomposition)
- ✅ Agent Programmer (implementation & execution)
- ✅ 4 Stories (GDD-001 to GDD-004)
- ✅ Documentation (quick starts, guides, checklists)
- ✅ Contexts (game architecture, mechanics)
- ✅ Integration clear (PM → Programmer → QA)

**Status: 🟢 READY FOR PRODUCTION DEVELOPMENT**

---

## 🎓 NEXT LEVEL AGENTS (Post Gameplay Loop)

After Gameplay Loop stories complete, create:

```
yersinia-combat-programmer.md
  → GDD-005: Player Attack
  → GDD-006: Player Dash
  → GDD-007: Knockback Effects

yersinia-npc-system-architect.md
  → NPC dialogue framework
  → Upgrade economy
  → Traitor logic

yersinia-progression-specialist.md
  → Gloire persistence
  → Stats management
  → Save/load system

yersinia-ui-systems-specialist.md
  → HUD layout
  → Joystick design
  → Mobile responsiveness
```

---

*Generated by Agent Creator*  
*Complete PM + Programmer Agent Suite for Yersinia*  
*Ready to build the game, story by story*


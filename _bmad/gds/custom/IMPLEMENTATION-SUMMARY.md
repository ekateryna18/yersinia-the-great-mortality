# Yersinia Agent System - Implementation Summary

## 📋 Fichiers Générés

J'ai créé **3 documents de référence** pour clarifier les scopes des 10 agents :

### 1️⃣ **AGENT-SCOPES-LIMITATIONS.md**
**Purpose:** Documentation détaillée des scopes de chaque agent  
**Contient:** Domaine valide, limitations critiques, red flags  
**Format:** 1 section par agent (10 agents total)  
**Usage:** Consulter avant d'appeler un agent

### 2️⃣ **AGENT-DEPLOYMENT-GUIDE.md**
**Purpose:** Guide d'implémentation et bonnes pratiques  
**Contient:** Scope de chaque agent + appels corrects/incorrects + decision matrix  
**Format:** Vue détaillée + exemples pratiques  
**Usage:** Formation équipe, onboarding

### 3️⃣ **AGENT-PROFILE-CARDS.md**
**Purpose:** Fiches de référence rapide (quick lookup)  
**Contient:** 1 fiche par agent, checkboxes ✅/❌, menu actions  
**Format:** Cards compactes, visuellement organisées  
**Usage:** Consultation rapide en ligne

---

## 🎯 Les 10 Agents Yersinia

### 1. 🎮 YERSINIA-GAMEPLAY (Ada Lovelace)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-gameplay-programmer.md`

**✅ Peut faire:**
- Jour/nuit cycling
- Enemy wave spawning
- Basic enemy AI
- Player combat (scythe 90°)
- Knockback & hitstun
- Player stats (HP, DMG, SPD, CRIT, KB)
- Resilience/respawn system

**❌ Limitations (Utiliser):**
- PNJ/Dialogues → `@agent yersinia-npc`
- Shop/Commerce → `@agent yersinia-npc`
- Progression permanente → `@agent yersinia-progression`
- UI layout → `@agent yersinia-ui`
- Optimisation → `@agent yersinia-performance`
- Art/Sprites → `@agent yersinia-art`
- Narrative → `@agent yersinia-narrative`
- Testing → `@agent yersinia-qa`

---

### 2. 🧑‍🤝‍🧑 YERSINIA-NPC (Thomas Anderson)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-npc-system-architect.md`

**✅ Peut faire:**
- NPC system architecture (3 main + variants)
- Dialogue linéaire simple
- 2 traîtres aléatoires par run
- Shop/commerce mechanics
- Riddle/enigma system
- NPC states (alive, dead, hostile)
- Consequences (kill innocent = service loss)
- Boss NPC integration

**❌ Limitations:**
- Gameplay/Combat → `@agent yersinia-gameplay`
- Progression permanente → `@agent yersinia-progression`
- UI dialog avancée → `@agent yersinia-ui`
- **Dialogue branché complexe → OUT OF MVP SCOPE**
- Sprites → `@agent yersinia-art`
- Narrative profonde → `@agent yersinia-narrative`
- **Réputation avancée → OUT OF MVP SCOPE**

---

### 3. 💻 YERSINIA-UI
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-ui-systems-specialist.md`

**✅ Peut faire:**
- Mobile UI (adaptive portrait/landscape)
- Virtual joysticks
- HUD adaptif
- Dialog box UI
- Shop interface
- Stats display
- Responsive design
- Mobile accessibility

**❌ Limitations:**
- Gameplay → `@agent yersinia-gameplay`
- NPC system → `@agent yersinia-npc`
- Art direction → `@agent yersinia-art`
- Performance → `@agent yersinia-performance`
- Backend logic → Dev agents
- Narrative → `@agent yersinia-narrative`

---

### 4. 📊 YERSINIA-PROGRESSION (Progression & Economy)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-progression-economy-specialist.md`

**✅ Peut faire:**
- Glory system
- Good/Bad points
- Permanent player stats
- Economy design (prices, costs)
- Run-to-run progression math
- Balance calculations
- Variable difficulty
- Progression metrics

**❌ Limitations:**
- Gameplay → `@agent yersinia-gameplay`
- NPC trading → `@agent yersinia-npc`
- UI stats display → `@agent yersinia-ui`
- Performance → `@agent yersinia-performance`
- IAP → `@agent yersinia-business`
- Testing → `@agent yersinia-qa`

---

### 5. ⚡ YERSINIA-PERFORMANCE (Mobile Performance Engineer)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-mobile-performance-engineer.md`

**✅ Peut faire:**
- Android/iOS optimization
- Profiling & benchmarking
- Memory management
- Batch rendering
- Asset optimization
- Object pooling
- Godot 4.2 tuning
- 30 FPS baseline validation

**❌ Limitations:**
- **Pas new features** (optimization only)
- Gameplay design → `@agent yersinia-gameplay`
- Art creation → `@agent yersinia-art`
- UI design → `@agent yersinia-ui`
- Narrative → `@agent yersinia-narrative`

---

### 6. 🎨 YERSINIA-ART (Art & Asset Director)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-art-asset-director.md`

**✅ Peut faire:**
- Isometric 2D art direction
- Visual style (Dofus-inspired)
- Sprite creation
- Tileset design
- Character design (joueur, 7 PNJ, 4 ennemis)
- UI visual assets
- Animation guidelines
- Asset organization

**❌ Limitations:**
- **Art seulement** (pas code/assets direct)
- Gameplay → `@agent yersinia-gameplay`
- NPC behavior → `@agent yersinia-npc`
- UI layout → `@agent yersinia-ui`
- Performance → `@agent yersinia-performance`
- Narrative → `@agent yersinia-narrative`

---

### 7. 📖 YERSINIA-NARRATIVE (Narrative Designer)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-narrative-designer.md`

**✅ Peut faire:**
- Univers & lore
- Dialog content (texte, ton)
- Traitor mystery storyline
- Character backgrounds (7 PNJ)
- Thèmes narratifs
- Riddle writing
- Character voice & personality
- 5-night narrative arc

**❌ Limitations:**
- **Contenu seulement** (pas implementation)
- Dialog system → `@agent yersinia-npc`
- UI text display → `@agent yersinia-ui`
- Gameplay → `@agent yersinia-gameplay`
- Art → `@agent yersinia-art`
- Economy → `@agent yersinia-progression`

---

### 8. 🧪 YERSINIA-QA (QA Testing Lead)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-qa-testing-lead.md`

**✅ Peut faire:**
- Testing strategy (roguelike)
- Permadeath validation
- Run-to-run progression testing
- Balance sheets
- Enemy wave testing
- NPC interaction testing
- Traitor system validation
- Performance/FPS testing
- Mobile device matrix

**❌ Limitations:**
- **Pas code fix** (testing only)
- Gameplay design → `@agent yersinia-gameplay`
- Feature implementation → Feature agents
- Art → `@agent yersinia-art`
- Narrative → `@agent yersinia-narrative`

---

### 9. 💰 YERSINIA-BUSINESS (Business & Monetization)
**Fichier Agent:** `_bmad/gds/custom/agents/yersinia-business-monetization-advisor.md`

**✅ Peut faire:**
- Economic model (F2P vs Premium)
- IAP strategy
- KPI definition
- Monetization hooks
- User acquisition
- App store optimization
- A/B testing framework
- Revenue forecasting

**❌ Limitations:**
- **Hors MVP scope** (post-launch focus)
- **Pas code** (strategy only)
- Gameplay → Feature agents
- Technical IAP → Dev agent
- Art/design → `@agent yersinia-art`
- QA → `@agent yersinia-qa`

---

### 10. 🤖 YERSINIA-AGENT-CREATOR (Agent Creator)
**Fichier Agent:** `_bmad/gds/custom/agents/agent-creator.md`

**✅ Peut faire:**
- Créer nouveaux agents spécialisés
- Générer contexts story-spécifiques
- Auditer agents existants
- Créer team agent manifests
- Générer workflows BMAD
- Optimiser agents

**❌ Limitations:**
- **Meta-agent** (crée agents, ne code pas features)
- **Pas implementation direct** (utiliser les agents créés)
- Gameplay/narrative/art → Feature agents générés

---

## 🔗 Matrix Décision Rapide

| Besoin | Agent | Context |
|--------|-------|---------|
| **Combat, vagues, IA** | yersinia-gameplay | yersinia-gdd |
| **PNJ, traîtres, dialogue** | yersinia-npc | yersinia-gdd |
| **Interfaces, joysticks** | yersinia-ui | yersinia-gdd |
| **Gloire, progression, balance** | yersinia-progression | yersinia-gdd |
| **30 FPS, optimisation** | yersinia-performance | godot-setup |
| **Sprites, style artistique** | yersinia-art | yersinia-gdd |
| **Lore, narratif, univers** | yersinia-narrative | yersinia-gdd |
| **Testing, QA, balance** | yersinia-qa | yersinia-gdd |
| **IAP, monétisation, KPI** | yersinia-business | yersinia-gdd |
| **Créer nouvel agent** | yersinia-agent-creator | yersinia-gdd |

---

## 🔑 Key Patterns

### Pattern 1: Simple Feature (1 Agent)
```
@context yersinia-gdd
@agent yersinia-gameplay

Besoin: Améliorer l'IA des rats
```

### Pattern 2: Multi-Agent Feature (Sequential)
```
Step 1:
@context yersinia-gdd
@agent yersinia-gameplay
Besoin: Implémenter le combat joueur

Step 2:
@context yersinia-gdd
@agent yersinia-ui
Besoin: Créer l'affichage du combat dans l'UI
```

### Pattern 3: Create Specialized Agent
```
@context yersinia-gdd
@agent yersinia-agent-creator

Besoin: Créer un agent pour la gestion des chests/loot system
```

---

## 📚 Fichiers de Référence

**Trois nouveaux documents créés:**

1. **AGENT-SCOPES-LIMITATIONS.md** - Référence détaillée
2. **AGENT-DEPLOYMENT-GUIDE.md** - Guide d'implémentation
3. **AGENT-PROFILE-CARDS.md** - Quick reference cards

**Intégrer dans CUSTOM-AGENTS-MANIFEST.md:**

Ajouter une section:
```markdown
## 📖 Documentation des Scopes

Consultez les guides de scope pour chaque agent:
- [AGENT-SCOPES-LIMITATIONS.md](./AGENT-SCOPES-LIMITATIONS.md) - Détails complets
- [AGENT-DEPLOYMENT-GUIDE.md](./AGENT-DEPLOYMENT-GUIDE.md) - Guide implémentation
- [AGENT-PROFILE-CARDS.md](./AGENT-PROFILE-CARDS.md) - Quick lookup cards
```

---

## ✅ Statut

**Fiches créées:** ✅ 10/10 agents documentés avec scopes  
**Documentation:** ✅ 3 guides complets  
**Format:** ✅ Prêt pour utilisation immédiate  
**Utilisation:** ✅ Consultable par les équipes

---

**Version:** 1.0 - MVP  
**Dernière mise à jour:** 2026-01-27  
**Créé par:** GitHub Copilot  
**Status:** ✅ Ready for Team Deployment

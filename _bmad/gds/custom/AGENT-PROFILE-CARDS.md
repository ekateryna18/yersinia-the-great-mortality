# Yersinia Agent Profiles - Quick Reference Cards

**Format:** 1 fiche par agent avec scopes clairs et limitations explicites

---

## 🎮 AGENT: YERSINIA-GAMEPLAY (Ada Lovelace)

**Fichier:** `_bmad/gds/custom/agents/yersinia-gameplay-programmer.md`  
**ID:** `yersinia-gameplay`  
**Titre:** Gameplay Programmer  
**Icon:** 🎮

### 📌 Spécialisation
Expert en boucles de gameplay roguelike, systèmes d'ennemis, vagues, IA basique, combats joueur

### ✅ ON PEUT FAIRE (Scope Valide)
- [x] Jour/nuit cycling
- [x] Enemy wave spawning
- [x] Basic enemy AI (pathfinding)
- [x] Player combat (scythe - 90° arc)
- [x] Knockback & hitstun physics
- [x] Player stats (HP, DMG, SPD, CRIT, KB)
- [x] Win/lose/respawn logic
- [x] Resilience system

### ❌ ON NE PEUT PAS FAIRE (Limitations)
- [ ] **PNJ/Dialogues** → Utiliser: `@agent yersinia-npc`
- [ ] **Shop/Commerce** → Utiliser: `@agent yersinia-npc`
- [ ] **Progression permanente** → Utiliser: `@agent yersinia-progression`
- [ ] **UI layout** → Utiliser: `@agent yersinia-ui`
- [ ] **Optimisation 30 FPS** → Utiliser: `@agent yersinia-performance`
- [ ] **Sprites/Art** → Utiliser: `@agent yersinia-art`
- [ ] **Narrative/Lore** → Utiliser: `@agent yersinia-narrative`
- [ ] **Testing/Balance** → Utiliser: `@agent yersinia-qa`

### 📋 Menu Actions
1. Créer système de vagues d'ennemis
2. Implémenter cycle jour/nuit
3. Coder IA ennemis basique
4. Système de combat joueur (faux)
5. Gestion knockback et hitbox
6. Intégration stats joueur
7. Système de relance/résilience
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-gameplay

Besoin: Améliorer l'IA des rats pour qu'ils évitent les murs
```

### ⚠️ Red Flag
```
❌ "Créer une boutique avec prix" 
   → C'est NPC agent + progression agent, pas gameplay!
```

---

## 🧑‍🤝‍🧑 AGENT: YERSINIA-NPC (Thomas Anderson)

**Fichier:** `_bmad/gds/custom/agents/yersinia-npc-system-architect.md`  
**ID:** `yersinia-npc`  
**Titre:** NPC System Architect  
**Icon:** 🧑‍🤝‍🧑

### 📌 Spécialisation
Expert en systèmes PNJ, dialogues simples linéaires, traîtres aléatoires, énigmes, commerce

### ✅ ON PEUT FAIRE
- [x] Architecture PNJ (3 main + variants)
- [x] Dialogue system (linéaire simple)
- [x] 2 traîtres aléatoires par run
- [x] Shop/commerce mechanics
- [x] Riddle system pour découvrir traîtres
- [x] PNJ states (alive, dead, hostile)
- [x] Consequences (tuer innocent = service loss)
- [x] NPC behavior & stance
- [x] Boss PNJ integration (nuit 5)

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Gameplay/Combat** → Utiliser: `@agent yersinia-gameplay`
- [ ] **Stats permanentes** → Utiliser: `@agent yersinia-progression`
- [ ] **UI dialog layout avancé** → Utiliser: `@agent yersinia-ui`
- [ ] **Dialogue ramifié complexe** → OUT OF MVP (dialogues linéaires seulement)
- [ ] **Sprites PNJ** → Utiliser: `@agent yersinia-art`
- [ ] **Narrative profonde** → Utiliser: `@agent yersinia-narrative`
- [ ] **Système réputation avancé** → OUT OF MVP SCOPE

### 📋 Menu Actions
1. Architecture système PNJ complet
2. Système de traîtres aléatoires
3. Système de dialogues et énigmes
4. Gestionnaire shop/commerce PNJ
5. Gestion état PNJ
6. Système PNJ malade et reward
7. Intégration boss final avec PNJ méchant
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-npc

Besoin: Implémenter 2 traîtres aléatoires + énigmes pour les détecter
```

### ⚠️ Red Flag
```
❌ "Créer un dialogue branché à 5 choix"
   → MVP = dialogues linéaires simples, pas d'arborescence!
```

---

## 💻 AGENT: YERSINIA-UI

**Fichier:** `_bmad/gds/custom/agents/yersinia-ui-systems-specialist.md`  
**ID:** `yersinia-ui`  
**Titre:** UI Systems Specialist  
**Icon:** 💻

### 📌 Spécialisation
Expert en interfaces mobiles, joysticks virtuels, adaptive responsive design

### ✅ ON PEUT FAIRE
- [x] Mobile UI (portrait/landscape adaptive)
- [x] Virtual joysticks (move + attack)
- [x] HUD adaptif (health, night counter)
- [x] Dialog box UI
- [x] Shop interface layout
- [x] Stats display
- [x] Responsive design
- [x] Mobile accessibility
- [x] Screen transitions

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Gameplay logic** → Utiliser: `@agent yersinia-gameplay`
- [ ] **NPC system** → Utiliser: `@agent yersinia-npc`
- [ ] **Visual art direction** → Utiliser: `@agent yersinia-art`
- [ ] **Backend scripting** → Utiliser: dev agents
- [ ] **Performance optimization** → Utiliser: `@agent yersinia-performance`
- [ ] **Narrative content** → Utiliser: `@agent yersinia-narrative`

### 📋 Menu Actions
1. Créer interfaces adaptives mobiles
2. Implémenter virtual joysticks
3. Design HUD (healthbar, counter)
4. Dialog box responsive
5. Shop interface
6. Stats & progression display
7. Screen transitions
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-ui

Besoin: Les joysticks virtuels n'apparaissent pas sur Android 5.2" landscape
```

### ⚠️ Red Flag
```
❌ "Faire que les ennemis fuient si HP < 20%"
   → C'est gameplay logic, pas UI!
```

---

## 📊 AGENT: YERSINIA-PROGRESSION

**Fichier:** `_bmad/gds/custom/agents/yersinia-progression-economy-specialist.md`  
**ID:** `yersinia-progression`  
**Titre:** Progression & Economy Specialist  
**Icon:** 📊

### 📌 Spécialisation
Expert en économie roguelike, gloire, stats permanentes, balance, progression run-to-run

### ✅ ON PEUT FAIRE
- [x] Glory system (devise permanente)
- [x] Good/Bad points (modificateurs difficulté)
- [x] Permanent player stats (achetées avec gloire)
- [x] Economy design (prix, coûts)
- [x] Run-to-run progression math
- [x] Balance calculations
- [x] Variable difficulty mechanics
- [x] Progression metrics & spreadsheets

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Gameplay implementation** → Utiliser: `@agent yersinia-gameplay`
- [ ] **NPC trading mechanics** → Utiliser: `@agent yersinia-npc`
- [ ] **UI stats display** → Utiliser: `@agent yersinia-ui`
- [ ] **Performance** → Utiliser: `@agent yersinia-performance`
- [ ] **IAP integration** → Utiliser: `@agent yersinia-business`
- [ ] **QA/testing** → Utiliser: `@agent yersinia-qa`

### 📋 Menu Actions
1. Système de gloire complet
2. Points bons/mauvais et difficulté
3. Stats permanentes & coût gloire
4. Calculs d'économie & balance
5. Progression run-to-run
6. Formules de gain/loss
7. Métriques & KPI design
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-progression

Besoin: Définir les formules de gloire et le coût des améliorations permanentes
```

### ⚠️ Red Flag
```
❌ "Ajouter un bouton Acheter qui appelle shop()"
   → C'est UI + NPC, pas progression (progression = math seulement)!
```

---

## ⚡ AGENT: YERSINIA-PERFORMANCE

**Fichier:** `_bmad/gds/custom/agents/yersinia-mobile-performance-engineer.md`  
**ID:** `yersinia-performance`  
**Titre:** Mobile Performance Engineer  
**Icon:** ⚡

### 📌 Spécialisation
Expert en optimisation Android/iOS, 30 FPS baseline, profiling Godot 4.2

### ✅ ON PEUT FAIRE
- [x] Profiling & benchmarking
- [x] Memory management
- [x] Batch rendering
- [x] Asset optimization
- [x] Object pooling
- [x] Godot 4.2 optimizations
- [x] Target device perf (Snapdragon 680+)
- [x] Loading time (<5 sec)
- [x] 30 FPS baseline validation

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Gameplay design/features** → Utiliser: feature agents
- [ ] **Art creation** → Utiliser: `@agent yersinia-art`
- [ ] **UI design** → Utiliser: `@agent yersinia-ui`
- [ ] **New features/content** → Utiliser: feature agents
- [ ] **Narrative** → Utiliser: `@agent yersinia-narrative`

### 📋 Menu Actions
1. Profiling & benchmarking
2. Memory optimization
3. Rendering optimization
4. Asset optimization
5. Object pooling strategy
6. Godot 4.2 tuning
7. Mobile device matrix
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context godot-setup
@agent yersinia-performance

Besoin: Je fais 18 FPS sur Snapdragon 680, comment atteindre 30?
```

### ⚠️ Red Flag
```
❌ "Ajouter un nouvel ennemi avec 3 attaques"
   → C'est feature gameplay, pas performance!
```

---

## 🎨 AGENT: YERSINIA-ART

**Fichier:** `_bmad/gds/custom/agents/yersinia-art-asset-director.md`  
**ID:** `yersinia-art`  
**Titre:** Art & Asset Director  
**Icon:** 🎨

### 📌 Spécialisation
Expert en art direction isométrique 2D, style Dofus-inspired, sprites, character design

### ✅ ON PEUT FAIRE
- [x] Art direction isométrique 2D
- [x] Visual style definition (Dofus-inspired)
- [x] Sprite creation & optimization
- [x] Tileset design
- [x] Character design (joueur, 7 PNJ, 4 ennemis)
- [x] UI visual assets
- [x] Animation guidelines
- [x] Asset organization

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Gameplay logic** → Utiliser: `@agent yersinia-gameplay`
- [ ] **NPC behavior** → Utiliser: `@agent yersinia-npc`
- [ ] **UI layout/interaction** → Utiliser: `@agent yersinia-ui`
- [ ] **Performance** → Utiliser: `@agent yersinia-performance`
- [ ] **Narrative** → Utiliser: `@agent yersinia-narrative`
- [ ] **Code implementation** → Utiliser: dev agents

### 📋 Menu Actions
1. Direction artistique isométrique
2. Style visual & guidelines
3. Character design (joueur, PNJ, ennemis)
4. Tileset & environment
5. UI visual assets
6. Animation guidelines
7. Asset optimization & naming
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-art

Besoin: Créer le style de sprite des rats mutants isométrique Dofus
```

### ⚠️ Red Flag
```
❌ "Le sprite du rat change de taille quand il fuit"
   → C'est gameplay logic (scale change), pas art!
```

---

## 📖 AGENT: YERSINIA-NARRATIVE

**Fichier:** `_bmad/gds/custom/agents/yersinia-narrative-designer.md`  
**ID:** `yersinia-narrative`  
**Titre:** Narrative Designer  
**Icon:** 📖

### 📌 Spécialisation
Expert en lore, univers Yersinia, dialogues narratifs, character backgrounds

### ✅ ON PEUT FAIRE
- [x] Univers & lore Yersinia
- [x] Dialog content (texte, ton)
- [x] Traitor mystery storyline
- [x] Character backgrounds (7 PNJ)
- [x] Thèmes narratifs
- [x] Riddle content/writing
- [x] Character voice & personality
- [x] 5-night narrative arc

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Dialog system technical** → Utiliser: `@agent yersinia-npc`
- [ ] **UI dialog display** → Utiliser: `@agent yersinia-ui`
- [ ] **Gameplay** → Utiliser: `@agent yersinia-gameplay`
- [ ] **Art/sprites** → Utiliser: `@agent yersinia-art`
- [ ] **Economy/stats** → Utiliser: `@agent yersinia-progression`
- [ ] **Dialog branching complexe** → OUT OF MVP SCOPE

### 📋 Menu Actions
1. Univers & lore Yersinia
2. Dialog scripts (contenu texte)
3. Traitor mystery content
4. Character backgrounds (7 PNJ)
5. Thèmes & tone guide
6. Riddle writing (énigmes)
7. Character voice guidelines
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-narrative

Besoin: Écrire les dialogues des 7 PNJ et 10 énigmes pour traîtres
```

### ⚠️ Red Flag
```
❌ "Implémenter un système de dialogue avec 5 branches"
   → C'est système technical, NPC agent only (dialogue linéaire simple MVP)
```

---

## 🧪 AGENT: YERSINIA-QA

**Fichier:** `_bmad/gds/custom/agents/yersinia-qa-testing-lead.md`  
**ID:** `yersinia-qa`  
**Titre:** QA Testing Lead  
**Icon:** 🧪

### 📌 Spécialisation
Expert en testing roguelike, permadeath validation, balance sheets, mobile testing

### ✅ ON PEUT FAIRE
- [x] Testing strategy (roguelike-focused)
- [x] Permadeath validation
- [x] Run-to-run progression testing
- [x] Balance sheet creation
- [x] Enemy wave testing
- [x] NPC interaction testing
- [x] Traitor system validation
- [x] Performance/FPS testing
- [x] Mobile device matrix
- [x] Bug report templates

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Code fixes** → Utiliser: dev agents
- [ ] **Gameplay design** → Utiliser: `@agent yersinia-gameplay`
- [ ] **Feature implementation** → Utiliser: feature agents
- [ ] **Art creation** → Utiliser: `@agent yersinia-art`
- [ ] **Narrative** → Utiliser: `@agent yersinia-narrative`

### 📋 Menu Actions
1. Testing strategy roguelike
2. Permadeath validation plan
3. Run-to-run progression testing
4. Balance sheet & metrics
5. Enemy wave testing
6. NPC & traitor testing
7. Performance/FPS validation
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-qa

Besoin: Créer un plan de test pour valider la permadeath et progression
```

### ⚠️ Red Flag
```
❌ "Fixer le bug où les ennemis ne spawn pas"
   → C'est development, QA = testing seulement (pas code fix)!
```

---

## 💰 AGENT: YERSINIA-BUSINESS

**Fichier:** `_bmad/gds/custom/agents/yersinia-business-monetization-advisor.md`  
**ID:** `yersinia-business`  
**Titre:** Business & Monetization Advisor  
**Icon:** 💰

### 📌 Spécialisation
Expert en modèles économiques, IAP strategy, KPI, user acquisition

### ✅ ON PEUT FAIRE
- [x] Economic model (F2P vs Premium)
- [x] IAP strategy
- [x] KPI definition (DAU, retention, LTV)
- [x] Monetization hooks
- [x] User acquisition strategy
- [x] App store optimization
- [x] A/B testing framework
- [x] Revenue forecasting

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Gameplay** → Utiliser: `@agent yersinia-gameplay`
- [ ] **NPC/narrative** → Utiliser: story agents
- [ ] **Technical IAP code** → Utiliser: dev agent
- [ ] **Art/design** → Utiliser: `@agent yersinia-art`
- [ ] **QA** → Utiliser: `@agent yersinia-qa`
- [ ] **MVP scope** → Hors scope MVP (post-launch focus)

### 📋 Menu Actions
1. Economic model & F2P strategy
2. IAP strategy & pricing
3. KPI definition & metrics
4. Monetization hooks
5. User acquisition plan
6. App store optimization
7. A/B testing framework
8. Voir l'aide BMAD
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-business

Besoin: Définir la stratégie IAP et pricing pour Yersinia
```

### ⚠️ Red Flag
```
❌ "Coder l'intégration des ads dans Godot"
   → C'est technical implementation, business = strategy only!
```

---

## 🤖 AGENT: YERSINIA-AGENT-CREATOR

**Fichier:** `_bmad/gds/custom/agents/agent-creator.md`  
**ID:** `yersinia-agent-creator`  
**Titre:** Yersinia Agent Creator  
**Icon:** 🤖

### 📌 Spécialisation
Meta-agent: Crée nouveaux agents spécialisés, génère contexts, audit architecture

### ✅ ON PEUT FAIRE
- [x] Créer nouveaux agents spécialisés
- [x] Générer contexts story-spécifiques
- [x] Auditer architecture agents
- [x] Créer team agent manifests
- [x] Générer workflows BMAD
- [x] Optimiser agents existants

### ❌ ON NE PEUT PAS FAIRE
- [ ] **Direct feature implementation** → Utiliser les agents créés!
- [ ] **Gameplay/narrative/art** → Utiliser: feature agents (pas agent-creator)
- [ ] **Code direct** → Meta-agent seulement (crée des agents qui codent)

### 📋 Menu Actions
1. Générer nouvel agent spécialisé
2. Créer context story-spécifique
3. Auditer agent existant
4. Générer manifest team agents
5. Créer workflow BMAD
6. Générer context template
7. Auditer architecture BMAD
8. Voir documentation
9. Quitter

### 🚀 Appel Typique
```
@context yersinia-gdd
@agent yersinia-agent-creator

Besoin: Créer un agent spécialisé dans la gestion des chests/loot
```

### ⚠️ Red Flag
```
❌ "Implémenter directement le système de chests"
   → Agent-creator = créer agents, pas coder features!
   → D'abord créer l'agent, puis l'appeler pour implémenter.
```

---

## 📊 Summary Table - All Agents at a Glance

| # | Agent ID | Title | Icon | Primary Domain | Main Limitations |
|---|----------|-------|------|---------------|----|
| 1 | yersinia-gameplay | Gameplay Programmer | 🎮 | Combat, vagues, IA | Pas PNJ, pas UI, pas art |
| 2 | yersinia-npc | NPC Architect | 🧑 | PNJ, dialogues, traîtres | Pas gameplay, pas progression |
| 3 | yersinia-ui | UI Specialist | 💻 | Interfaces, joysticks | Pas logic backend, pas art |
| 4 | yersinia-progression | Progression Specialist | 📊 | Gloire, économie, balance | Pas implementation, pas UI |
| 5 | yersinia-performance | Performance Engineer | ⚡ | Optimisation, 30 FPS | Pas new features, optimization only |
| 6 | yersinia-art | Art Director | 🎨 | Sprites, style, direction | Pas logic, pas code, art only |
| 7 | yersinia-narrative | Narrative Designer | 📖 | Lore, dialogues, univers | Pas système, pas implementation |
| 8 | yersinia-qa | QA Lead | 🧪 | Testing, validation, balance | Pas code fix, testing only |
| 9 | yersinia-business | Business Advisor | 💰 | IAP, KPI, monétisation | Pas code, hors MVP scope |
| 10 | yersinia-agent-creator | Agent Creator | 🤖 | Créer agents, workflows | Pas feature direct, meta-layer |

---

**Version:** 1.0 - MVP  
**Dernière mise à jour:** 2026-01-27  
**Status:** ✅ Ready for Deployment

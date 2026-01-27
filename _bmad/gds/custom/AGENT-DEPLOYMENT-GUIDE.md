# Yersinia - Agent Deployment & Scopes Guide

## 📋 Vue Générale des Agents

Vous avez **10 agents spécialisés** pour le projet Yersinia. Ce guide montre:
1. **Où chaque agent intervient**
2. **Où il NE PEUT PAS intervenir**
3. **Comment les appeler correctement**

---

## 🎮 AGENT 1: YERSINIA-GAMEPLAY

**Fichier:** `_bmad/gds/custom/agents/yersinia-gameplay-programmer.md`
**Persona:** Ada Lovelace (Gameplay Programmer)
**Expertise:** Boucles de jeu, mécaniques roguelike

### Domaine de Compétence ✅
```
✓ Jour/Nuit cycling logic
✓ Enemy wave spawning systems
✓ Basic enemy AI (pathfinding, attacks)
✓ Player combat mechanics (scythe - 90° arc attack)
✓ Knockback & hitstun
✓ Player stats (HP, damage, speed, crit, knockback)
✓ Game phases (win/lose/respawn logic)
✓ Resilience system (respawn counter)
```

### Limitations Critique ❌
```
✗ PNJ systems/dialogues → Utiliser @agent yersinia-npc
✗ Shop/commerce mechanics → Utiliser @agent yersinia-npc
✗ Permanent progression → Utiliser @agent yersinia-progression
✗ UI layout/interaction → Utiliser @agent yersinia-ui
✗ Performance optimization → Utiliser @agent yersinia-performance
✗ Art/sprites → Utiliser @agent yersinia-art
✗ Narrative/lore → Utiliser @agent yersinia-narrative
✗ QA/testing → Utiliser @agent yersinia-qa
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-gameplay

Besoin: Je veux améliorer le système d'IA des rats pour qu'ils évitent les obstacles
```

### Appel Incorrect ❌
```
@agent yersinia-gameplay
Créer la boutique avec prix IAP
→ ❌ HORS SCOPE - Utiliser @agent yersinia-business + @agent yersinia-npc
```

---

## 🧑‍🤝‍🧑 AGENT 2: YERSINIA-NPC

**Fichier:** `_bmad/gds/custom/agents/yersinia-npc-system-architect.md`
**Persona:** Thomas Anderson (NPC System Architect)
**Expertise:** PNJ, dialogues, traîtres

### Domaine de Compétence ✅
```
✓ NPC system architecture (3 main + variants)
✓ Dialogue system (linear, simple)
✓ Traitor system (2 random per run)
✓ Shop/commerce mechanics
✓ Riddle/enigma system for traitor discovery
✓ NPC states (alive, dead, hostile, betrayed)
✓ Consequences system (kill innocent = service loss)
✓ NPC behavior (stance, reactions)
✓ Boss NPC integration (final night)
```

### Limitations Critique ❌
```
✗ Gameplay loop/combat → Utiliser @agent yersinia-gameplay
✗ Permanent player stats → Utiliser @agent yersinia-progression
✗ UI dialog layout → Utiliser @agent yersinia-ui
✗ Dialogue deep narrative → Utiliser @agent yersinia-narrative
✗ NPC sprites/art → Utiliser @agent yersinia-art
✗ Performance → Utiliser @agent yersinia-performance
✗ Dialog complexity (branching trees) → OUT OF MVP SCOPE
✗ Advanced reputation → OUT OF MVP SCOPE
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-npc

Besoin: Implémenter le système de traîtres avec 2 suspects aléatoires et énigmes
```

### Appel Incorrect ❌
```
@agent yersinia-npc
Créer un dialogue complexe à 5 branches différentes
→ ❌ HORS SCOPE MVP - Dialogues linéaires simples seulement
```

---

## 💻 AGENT 3: YERSINIA-UI

**Fichier:** `_bmad/gds/custom/agents/yersinia-ui-systems-specialist.md`
**Persona:** [À vérifier]
**Expertise:** UI mobile, interfaces adaptatives

### Domaine de Compétence ✅
```
✓ Mobile UI (adaptive portrait/landscape)
✓ Virtual joysticks (movement + attack)
✓ HUD adaptive (healthbar, night counter)
✓ Dialog box UI
✓ Shop interface layout
✓ Stats display
✓ Responsive design
✓ Accessibility (mobile-friendly)
✓ Screen transitions
```

### Limitations Critique ❌
```
✗ Gameplay mechanics → Utiliser @agent yersinia-gameplay
✗ NPC system → Utiliser @agent yersinia-npc
✗ Visual art direction → Utiliser @agent yersinia-art
✗ Performance optimization → Utiliser @agent yersinia-performance
✗ Backend logic/scripting → Dev agents
✗ Narrative text content → Utiliser @agent yersinia-narrative
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-ui

Besoin: Adapter l'interface pour que les joysticks virtuels soient accessibles sur Android 5.2"
```

### Appel Incorrect ❌
```
@agent yersinia-ui
Faire que l'ennemi fuit quand sa santé < 20%
→ ❌ GAMEPLAY - Utiliser @agent yersinia-gameplay
```

---

## 📊 AGENT 4: YERSINIA-PROGRESSION

**Fichier:** `_bmad/gds/custom/agents/yersinia-progression-economy-specialist.md`
**Persona:** [À vérifier]
**Expertise:** Gloire, économie, progression run-to-run

### Domaine de Compétence ✅
```
✓ Glory system (currency per run)
✓ Good/Bad points (difficulty modifiers)
✓ Permanent player stats (bought with glory)
✓ Economy design (prices, costs)
✓ Run-to-run progression
✓ Balance calculations (cost/gain ratios)
✓ Variable difficulty mechanics
✓ Progression metrics
```

### Limitations Critique ❌
```
✗ Gameplay implementation → Utiliser @agent yersinia-gameplay
✗ NPC trading → Utiliser @agent yersinia-npc
✗ UI stats display → Utiliser @agent yersinia-ui
✗ Performance → Utiliser @agent yersinia-performance
✗ IAP integration → Utiliser @agent yersinia-business
✗ QA testing → Utiliser @agent yersinia-qa
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-progression

Besoin: Définir la formule de calcul de gloire et le coût des améliorations permanentes
```

### Appel Incorrect ❌
```
@agent yersinia-progression
Ajouter un bouton Acheter qui appelle la fonction de shop
→ ❌ UI LOGIC - Utiliser @agent yersinia-ui ou dev agent
```

---

## ⚡ AGENT 5: YERSINIA-PERFORMANCE

**Fichier:** `_bmad/gds/custom/agents/yersinia-mobile-performance-engineer.md`
**Persona:** [À vérifier]
**Expertise:** Optimisation Android/iOS, 30 FPS

### Domaine de Compétence ✅
```
✓ Android/iOS optimization
✓ Profiling & benchmarking (30 FPS baseline)
✓ Memory management
✓ Batch rendering optimization
✓ Asset optimization (textures, audio)
✓ Object pooling (enemies)
✓ Godot 4.2 specific optimizations
✓ Target device perf (Snapdragon 680+)
✓ Loading time optimization (<5 sec)
```

### Limitations Critique ❌
```
✗ Gameplay design → Utiliser @agent yersinia-gameplay
✗ Feature implementation → Utiliser feature agents
✗ Art creation → Utiliser @agent yersinia-art
✗ UI design → Utiliser @agent yersinia-ui
✗ New features → Feature agents seulement
```

### Appel Correct ✅
```
@context godot-setup
@agent yersinia-performance

Besoin: Je ne fais que 18 FPS sur Snapdragon 680, c'est quoi les priorités pour atteindre 30?
```

### Appel Incorrect ❌
```
@agent yersinia-performance
Ajouter un nouvel ennemi avec 3 attaques différentes
→ ❌ FEATURE - Utiliser @agent yersinia-gameplay
```

---

## 🎨 AGENT 6: YERSINIA-ART

**Fichier:** `_bmad/gds/custom/agents/yersinia-art-asset-director.md`
**Persona:** [À vérifier]
**Expertise:** Direction artistique isométrique 2D

### Domaine de Compétence ✅
```
✓ Isometric 2D art direction
✓ Visual style (Dofus-inspired)
✓ Sprite creation/optimization
✓ Tileset design
✓ Character design (7 NPCs + 4 enemies)
✓ UI visual assets
✓ Animation guidelines
✓ Asset organization & naming
```

### Limitations Critique ❌
```
✗ Gameplay logic → Utiliser @agent yersinia-gameplay
✗ NPC behavior → Utiliser @agent yersinia-npc
✗ UI layout/interaction → Utiliser @agent yersinia-ui
✗ Performance → Utiliser @agent yersinia-performance
✗ Narrative → Utiliser @agent yersinia-narrative
✗ Code implementation → Dev agents
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-art

Besoin: Créer le style de sprite pour les rats mutants en isométrique Dofus
```

### Appel Incorrect ❌
```
@agent yersinia-art
Faire que le sprite du rat change de taille quand il fuit
→ ❌ GAMEPLAY LOGIC - Utiliser @agent yersinia-gameplay + code
```

---

## 📖 AGENT 7: YERSINIA-NARRATIVE

**Fichier:** `_bmad/gds/custom/agents/yersinia-narrative-designer.md`
**Persona:** [À vérifier]
**Expertise:** Lore, univers, dialogues narrative

### Domaine de Compétence ✅
```
✓ Yersinia universe & lore
✓ Dialog content (text, tone)
✓ Traitor mystery storyline
✓ Character backgrounds (7 NPCs)
✓ Themes (Great Mortality, rats, betrayal)
✓ Riddle content/writing
✓ Character voice & personality
✓ Narrative arc (5-night story)
```

### Limitations Critique ❌
```
✗ Dialog system technical → Utiliser @agent yersinia-npc
✗ UI text display → Utiliser @agent yersinia-ui
✗ Gameplay → Utiliser @agent yersinia-gameplay
✗ Art/sprites → Utiliser @agent yersinia-art
✗ Economy/stats → Utiliser @agent yersinia-progression
✗ Complex dialog branching → OUT OF MVP SCOPE
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-narrative

Besoin: Écrire les dialogues des 7 PNJ et 10 énigmes pour découvrir les traîtres
```

### Appel Incorrect ❌
```
@agent yersinia-narrative
Implémenter un système de dialogue avec 5 branches
→ ❌ TECHNICAL - Utiliser @agent yersinia-npc pour système linéaire simple
```

---

## 🧪 AGENT 8: YERSINIA-QA

**Fichier:** `_bmad/gds/custom/agents/yersinia-qa-testing-lead.md`
**Persona:** [À vérifier]
**Expertise:** Testing roguelike, balance, permadeath

### Domaine de Compétence ✅
```
✓ Roguelike testing strategy
✓ Permadeath validation
✓ Run-to-run progression testing
✓ Balance sheet creation
✓ Enemy wave testing
✓ NPC interaction testing
✓ Traitor system validation
✓ Performance/FPS testing
✓ Mobile device matrix
✓ Bug report templates
```

### Limitations Critique ❌
```
✗ Code fixes → Dev agents
✗ Gameplay design → Utiliser @agent yersinia-gameplay
✗ Feature implementation → Feature agents
✗ Art → Utiliser @agent yersinia-art
✗ Narrative → Utiliser @agent yersinia-narrative
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-qa

Besoin: Créer un plan de test pour valider que la permadeath fonctionne correctement
```

### Appel Incorrect ❌
```
@agent yersinia-qa
Fixer le bug où les ennemis ne spawn pas
→ ❌ DEVELOPMENT - Utiliser @agent yersinia-gameplay + code
```

---

## 💰 AGENT 9: YERSINIA-BUSINESS

**Fichier:** `_bmad/gds/custom/agents/yersinia-business-monetization-advisor.md`
**Persona:** [À vérifier]
**Expertise:** Modèle économique, IAP, KPI

### Domaine de Compétence ✅
```
✓ Economic model (F2P vs Premium)
✓ IAP strategy
✓ KPI definition (DAU, retention, LTV)
✓ Monetization hooks
✓ User acquisition
✓ App store optimization
✓ A/B testing framework
✓ Revenue forecasting
```

### Limitations Critique ❌
```
✗ Gameplay → Utiliser @agent yersinia-gameplay
✗ NPC/narrative → Story agents
✗ Technical IAP implementation → Dev agent
✗ Art/design → Utiliser @agent yersinia-art
✗ QA → Utiliser @agent yersinia-qa
✗ MVP scope → Hors scope MVP (post-launch)
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-business

Besoin: Définir la stratégie IAP pour Yersinia (premium currency, battle pass, etc.)
```

### Appel Incorrect ❌
```
@agent yersinia-business
Coder l'intégration des ads dans Godot
→ ❌ TECHNICAL - Utiliser dev agent ou business pour strategy seulement
```

---

## 🤖 AGENT 10: YERSINIA-AGENT-CREATOR

**Fichier:** `_bmad/gds/custom/agents/agent-creator.md`
**Persona:** Jean-Claude Borg (Agent Creator)
**Expertise:** Création d'agents BMAD spécialisés

### Domaine de Compétence ✅
```
✓ Créer nouveaux agents spécialisés
✓ Générer contexts story-spécifiques
✓ Auditer architecture agents
✓ Créer manifests team
✓ Générer workflows BMAD
✓ Optimiser agents existants
```

### Limitations Critique ❌
```
✗ Direct feature implementation → Utiliser les agents créés!
✗ Gameplay/narrative/art → Feature agents
✗ Ne code pas directement → Génère agents qui codent
```

### Appel Correct ✅
```
@context yersinia-gdd
@agent yersinia-agent-creator

Besoin: Créer un agent spécialisé dans la gestion des chests/loot
```

### Appel Incorrect ❌
```
@agent yersinia-agent-creator
Implémenter directement le système de chests
→ ❌ META-AGENT - D'abord créer l'agent spécialisé, puis l'appeler
```

---

## 🔗 Decision Matrix - Matrix Décision Rapide

| Besoin | Agent | Context |
|--------|-------|---------|
| Combats, vagues, IA | yersinia-gameplay | yersinia-gdd |
| PNJ, traîtres, dialogue | yersinia-npc | yersinia-gdd |
| Interfaces, joysticks | yersinia-ui | yersinia-gdd |
| Gloire, progression, balance | yersinia-progression | yersinia-gdd |
| 30 FPS, optimisation | yersinia-performance | godot-setup |
| Sprites, style artistique | yersinia-art | yersinia-gdd |
| Lore, narratif, univers | yersinia-narrative | yersinia-gdd |
| Testing, QA, balance | yersinia-qa | yersinia-gdd |
| IAP, monétisation, KPI | yersinia-business | yersinia-gdd |
| Créer nouvel agent | yersinia-agent-creator | yersinia-gdd |

---

## ⚠️ Common Mistakes & Fixes

### ❌ Mistake 1: "Calling gameplay for UI work"
```
@agent yersinia-gameplay
Créer un boutton pour passer au jour suivant
→ ❌ C'est UI, pas gameplay
→ ✅ @agent yersinia-ui
```

### ❌ Mistake 2: "Calling NPC for economy"
```
@agent yersinia-npc
Définir le prix des potions de force
→ ❌ C'est économie, pas NPC
→ ✅ @agent yersinia-progression
```

### ❌ Mistake 3: "Calling performance for features"
```
@agent yersinia-performance
Ajouter un nouvel ennemi avec 3 attaques
→ ❌ C'est feature, pas performance
→ ✅ @agent yersinia-gameplay
```

### ❌ Mistake 4: "No context loaded"
```
@agent yersinia-gameplay
Créer la boucle jour/nuit
→ ❌ Context manquant!
→ ✅ @context yersinia-gdd @agent yersinia-gameplay
```

### ❌ Mistake 5: "Asking for out-of-scope features"
```
@agent yersinia-narrative
Implémenter un dialogue ramifié à 10 branches
→ ❌ Hors scope MVP
→ ✅ Dialogues linéaires simples seulement
```

---

## 📋 Workflow Recommendé

### Pour une nouvelle feature:
```
1. Load context: @context yersinia-gdd
2. Identifier l'agent approprié (voir matrix ci-dessus)
3. Appeler: @agent agent-name
4. Décrire le besoin spécifique
5. Si approche multi-agent (ex: gameplay + ui):
   @context yersinia-gdd
   @agent yersinia-gameplay
   [détail gameplay]
   → Puis faire séquence distincte pour UI
```

### Pour déboguer une issue:
```
1. Identifier quelle partie du système est affectée
2. Charger l'agent responsable
3. Charger context + agent
4. Décrire symptôme
5. Attendre diagnostic
6. Suivre le workflow indiqué
```

---

**Version:** 1.0 - MVP
**Dernière mise à jour:** 2026-01-27
**Status:** Ready for deployment

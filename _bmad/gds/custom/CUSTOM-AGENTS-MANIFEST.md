# Custom Agents Manifest - Module Yersinia

## 🎮 Agents Disponibles

| ID                      | Nom                          | Fichier                            | Description                                    |
| ----------------------- | ---------------------------- | ---------------------------------- | ---------------------------------------------- |
| yersinia-agent-creator  | Yersinia Agent Creator       | custom/agents/agent-creator.md    | Générateur d'agents BMAD spécialisés           |
| yersinia-gameplay       | Gameplay Programmer          | agents/gameplay-programmer.md      | Boucles de jeu, vagues, IA, jour/nuit         |
| yersinia-npc            | NPC System Architect         | agents/npc-system-architect.md    | PNJ, traîtres, dialogues, énigmes             |
| yersinia-ui             | UI Systems Specialist        | agents/ui-systems-specialist.md   | Interfaces mobiles adaptatives                |
| yersinia-progression    | Progression & Economy        | agents/progression-economy-specialist.md | Gloire, stats permanentes, balance |
| yersinia-performance    | Mobile Performance Engineer  | agents/mobile-performance-engineer.md | Optimisation Android/iOS, 30 FPS |
| yersinia-qa             | QA Testing Lead              | agents/qa-testing-lead.md         | Tests roguelike, permadeath, balance           |
| yersinia-art            | Art & Asset Director         | agents/art-asset-director.md      | Direction artistique isométrique 2D           |
| yersinia-narrative      | Narrative Designer           | agents/narrative-designer.md      | Univers, dialogues, lore, traitor mystery     |
| yersinia-business       | Business & Monetization      | agents/business-monetization-advisor.md | Modèle économique, IAP, KPI |

## 📋 Contexts Disponibles

| Context                | Fichier                                    | Description                              | Usage                          |
| ---------------------- | ------------------------------------------ | ---------------------------------------- | ------------------------------ |
| **YERSINIA-GDD**       | **custom/contexts/YERSINIA-GDD-context.md**       | **🎮 Game Design Document complet**      | **Toujours - référence core** |
| **GAME-JAM-TIMELINE**  | **custom/contexts/GAME-JAM-TIMELINE-context.md**  | **⏱️ MVP 5 jours, timeline critique**    | **Si planning**               |
| **ROGUELIKE-PATTERNS** | **custom/contexts/ROGUELIKE-PATTERNS-context.md** | **🔄 Patterns roguelike modernes**       | **Si mechanic roguelike**     |
| **GODOT-SETUP**        | **custom/contexts/GODOT-SETUP-context.md**        | **🛠️ Godot 4.2 LTS setup guide**        | **Si infra dev**              |
| **AGENT-TEMPLATE**     | **custom/contexts/AGENT-TEMPLATE-context.md**     | **🤖 Template pour créer agents**        | **Avec agent-creator**        |

## ⚠️ IMPORTANT - Contexte Obligatoire

Avant toute intervention, **CHARGER OBLIGATOIREMENT**:

```
@context yersinia-gdd
```

Ce fichier contient:
- 🎮 Concept core complet
- 🎯 Scope MVP
- 🧑‍🤝‍🧑 Systèmes de PNJ avec traîtres
- 💰 Économie et progression
- 📊 Métriques de succès

## 🚀 Usage - Appels Copilot

### Charger un agent
```
@agent yersinia-agent-creator
```

### Charger un contexte
```
@context yersinia-gdd
```

### Charger plusieurs contexts
```
@context yersinia-gdd
@context roguelike-patterns
```

### Créer un nouvel agent spécialisé
```
@agent yersinia-agent-creator

Crée un agent spécialisé pour [feature spécifique] basé sur le template AGENT-TEMPLATE
```

## 📖 Workflow Recommandé

### 1️⃣ Pour modifier/étendre une feature existante
```
@context yersinia-gdd
@agent yersinia-gameplay
Besoin: [description feature]
```

### 2️⃣ Pour créer un nouvel agent spécialisé
```
@context yersinia-gdd
@context agent-template
@agent yersinia-agent-creator
Crée un agent pour: [spécialité]
```

### 3️⃣ Pour implémenter une story de game jam
```
@context yersinia-gdd
@context game-jam-timeline
@agent yersinia-gameplay
(ou autre agent approprié)

Story: [détail]
```

### 4️⃣ Pour déboguer/optimiser performance
```
@context godot-setup
@agent yersinia-performance
Problème: [détail]
```

## 🎯 Principes Clés

✅ **Toujours charger YERSINIA-GDD d'abord** - Référence unique de vérité
✅ **Agents spécialisés** - Chacun maîtrise son domaine
✅ **Roguelike-first** - Patterns et contraintes roguelike respectées
✅ **Mobile-optimized** - Android/iOS as priority (30 FPS baseline)
✅ **5 jours MVP** - Timeline critique, scope discipliné

## 📝 Notes de Configuration

### Activation des agents custom
Les agents custom héritent de la config BMAD standard:
- `{user_name}` depuis `_bmad/gds/config.yaml`
- `{communication_language}` = français
- `{output_folder}` depuis config

### Créer un agent custom supplémentaire
```bash
# 1. Charger le contexte template
@context agent-template

# 2. Utiliser le créateur
@agent yersinia-agent-creator
Crée un agent pour: [cas d'usage spécifique]

# 3. L'agent généré sera créé dans custom/agents/
```

## 🔗 Relations Entre Agents

```
┌─────────────────────────────────────────────┐
│   YERSINIA-AGENT-CREATOR (orchestrateur)    │
├─────────────────────────────────────────────┤
│                   ↓                         │
├─ Gameplay Programmer (boucles jeu)         │
├─ NPC System (PNJ + traîtres + dialogues)   │
├─ UI Specialist (interfaces mobiles)        │
├─ Progression Specialist (économie)         │
├─ Performance Engineer (optimisation)       │
├─ QA Lead (tests roguelike)                 │
├─ Art Director (visuels isométrique)        │
├─ Narrative Designer (lore + énigmes)       │
└─ Business Advisor (monétisation)           │
```

Tous les agents peuvent être appelés indépendamment pour focus spécialisé.

---

**Créé pour Yersinia: The Great Mortality - Game Jam Edition**
**MVP Timeline: 4-5 jours | Godot 4.2 LTS | Mobile (Android/iOS)**

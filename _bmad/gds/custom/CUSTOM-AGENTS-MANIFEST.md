# Custom Agents Manifest - Module Yersinia

## 🎮 Agents Disponibles

| ID                      | Nom                          | Fichier                            | Description                                    |
| ----------------------- | ---------------------------- | ---------------------------------- | ---------------------------------------------- |
| yersinia-agent-creator  | Yersinia Agent Creator       | custom/agents/agent-creator.md    | Générateur d'agents BMAD spécialisés           |
| yersinia-gameplay       | Gameplay Programmer          | custom/agents/yersinia-gameplay-programmer.md      | Boucles de jeu, vagues, IA, jour/nuit         |
| yersinia-npc            | NPC System Architect         | custom/agents/yersinia-npc-system-architect.md    | PNJ, traîtres, dialogues, énigmes             |
| yersinia-ui             | UI Systems Specialist        | custom/agents/yersinia-ui-systems-specialist.md   | Interfaces mobiles adaptatives                |
| yersinia-progression    | Progression & Economy        | custom/agents/yersinia-progression-economy-specialist.md | Gloire, stats permanentes, balance |
| yersinia-performance    | Mobile Performance Engineer  | custom/agents/yersinia-mobile-performance-engineer.md | Optimisation Android/iOS, 30 FPS |
| yersinia-qa             | QA Testing Lead              | custom/agents/yersinia-qa-testing-lead.md         | Tests roguelike, permadeath, balance           |
| yersinia-art            | Art & Asset Director         | custom/agents/yersinia-art-asset-director.md      | Direction artistique isométrique 2D           |
| yersinia-narrative      | Narrative Designer           | custom/agents/yersinia-narrative-designer.md      | Univers, dialogues, lore, traitor mystery     |
| yersinia-business       | Business & Monetization      | custom/agents/yersinia-business-monetization-advisor.md | Modèle économique, IAP, KPI |

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

## � Documentation des Scopes & Limitations

**⚠️ IMPORTANT:** Chaque agent a un domaine spécialisé ET des limitations claires.

### Consulter les Guides de Scope:

1. **[AGENT-SCOPES-LIMITATIONS.md](./AGENT-SCOPES-LIMITATIONS.md)** 
   - Référence détaillée des 10 agents
   - Domaines valides vs limitations critiques
   - Pour chaque agent: ✅ Peut faire | ❌ Ne peut pas faire

2. **[AGENT-DEPLOYMENT-GUIDE.md](./AGENT-DEPLOYMENT-GUIDE.md)**
   - Guide complet d'implémentation
   - Appels corrects vs incorrects
   - Decision matrix (quel agent pour quel besoin?)
   - Common mistakes & fixes

3. **[AGENT-PROFILE-CARDS.md](./AGENT-PROFILE-CARDS.md)**
   - Quick reference cards (1 par agent)
   - Format compact avec checkboxes
   - Parfait pour consultation rapide

4. **[IMPLEMENTATION-SUMMARY.md](./IMPLEMENTATION-SUMMARY.md)**
   - Vue d'ensemble de tous les fichiers
   - Résumé des 10 agents
   - Patterns d'utilisation

### ⚠️ RED FLAGS - Appels Invalides Courants

❌ **"@agent yersinia-gameplay - créer une boutique IAP"**
   - Boutique = NPC agent, IAP = business agent

❌ **"@agent yersinia-art - optimiser les 30 FPS"**
   - Performance = performance agent, pas art

❌ **"@agent yersinia-ui - implémenter le système de traîtres"**
   - Traîtres = NPC agent, UI agent = layout seulement

❌ **"@agent yersinia-progression - ajouter un bouton Acheter"**
   - Progression = math seulement, bouton = UI/NPC agent

❌ **"@agent yersinia-narrative - créer un dialogue ramifié à 5 branches"**
   - MVP = dialogues linéaires simples (NPC agent), pas arborescence

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

**Mais respectez leurs scopes!** → Consultez les documents ci-dessus.

---

**Créé pour Yersinia: The Great Mortality - Game Jam Edition**
**MVP Timeline: 4-5 jours | Godot 4.2 LTS | Mobile (Android/iOS)**

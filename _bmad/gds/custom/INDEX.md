# 🎯 Index - Yersinia Agents Documentation

## 📑 Navigation Rapide

Vous êtes ici : `_bmad/gds/custom/`

### 🎓 Documentation des Agents (Pour Comprendre les Scopes)

| Document | Contenu | Meilleur Pour |
|----------|---------|---------------|
| **[AGENT-SCOPES-LIMITATIONS.md](./AGENT-SCOPES-LIMITATIONS.md)** | Vue détaillée de chaque agent + scopes | Comprendre les limitations |
| **[AGENT-DEPLOYMENT-GUIDE.md](./AGENT-DEPLOYMENT-GUIDE.md)** | Guide complet + exemples + decision tree | Formation équipe, bonnes pratiques |
| **[AGENT-PROFILE-CARDS.md](./AGENT-PROFILE-CARDS.md)** | Fiches rapides avec checkboxes | Consultation rapide en ligne |
| **[IMPLEMENTATION-SUMMARY.md](./IMPLEMENTATION-SUMMARY.md)** | Résumé de tous les documents | Vue d'ensemble du système |

---

## 🎮 Les 10 Agents Yersinia

### 1. 🎮 YERSINIA-GAMEPLAY
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-gameplay-programmer.md`
- **Persona:** Ada Lovelace
- **Spécialité:** Boucles de jeu, vagues, IA, combat
- **Peut faire:** Jour/nuit, spawning ennemis, IA basique, combats, stats joueur
- **Ne peut PAS faire:** PNJ, UI, progression permanente, art, narrative

### 2. 🧑‍🤝‍🧑 YERSINIA-NPC
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-npc-system-architect.md`
- **Persona:** Thomas Anderson
- **Spécialité:** PNJ, traîtres, dialogues, commerce
- **Peut faire:** Architecture PNJ, dialogues linéaires, traîtres, énigmes, shop
- **Ne peut PAS faire:** Gameplay, progression, UI avancée, branching dialogs

### 3. 💻 YERSINIA-UI
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-ui-systems-specialist.md`
- **Spécialité:** Interfaces mobiles, joysticks, adaptive design
- **Peut faire:** Mobile UI, virtual joysticks, HUD, responsive design
- **Ne peut PAS faire:** Gameplay logic, art direction, backend code

### 4. 📊 YERSINIA-PROGRESSION
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-progression-economy-specialist.md`
- **Spécialité:** Gloire, économie, progression run-to-run
- **Peut faire:** Glory system, Good/Bad points, stats permanentes, balance math
- **Ne peut PAS faire:** Implementation, UI display, IAP code

### 5. ⚡ YERSINIA-PERFORMANCE
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-mobile-performance-engineer.md`
- **Spécialité:** Optimisation Android/iOS, 30 FPS baseline
- **Peut faire:** Profiling, memory mgmt, asset optimization, Godot tuning
- **Ne peut PAS faire:** New features, game design, art creation

### 6. 🎨 YERSINIA-ART
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-art-asset-director.md`
- **Spécialité:** Direction artistique isométrique 2D
- **Peut faire:** Sprites, tileset, character design, visual style
- **Ne peut PAS faire:** Code, gameplay logic, UI layout

### 7. 📖 YERSINIA-NARRATIVE
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-narrative-designer.md`
- **Spécialité:** Lore, univers, dialogues narratifs
- **Peut faire:** Univers, dialog content, traitor mystery, character backgrounds
- **Ne peut PAS faire:** System technical, implementation, code

### 8. 🧪 YERSINIA-QA
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-qa-testing-lead.md`
- **Spécialité:** Testing roguelike, balance, permadeath validation
- **Peut faire:** Testing strategy, permadeath validation, balance sheets, QA matrix
- **Ne peut PAS faire:** Code fix, gameplay design, feature implementation

### 9. 💰 YERSINIA-BUSINESS
- **Fichier Agent:** `_bmad/gds/custom/agents/yersinia-business-monetization-advisor.md`
- **Spécialité:** IAP, KPI, monétisation
- **Peut faire:** Economic model, IAP strategy, KPI, revenue forecast
- **Ne peut PAS faire:** Code, MVP features (post-launch only)

### 10. 🤖 YERSINIA-AGENT-CREATOR
- **Fichier Agent:** `./agents/agent-creator.md`
- **Persona:** Jean-Claude Borg
- **Spécialité:** Créer nouveaux agents BMAD spécialisés
- **Peut faire:** Créer agents, générer contexts, auditer architecture
- **Ne peut PAS faire:** Direct feature implementation (méta-layer only)

---

## 📋 Contexts Disponibles

| Context | Fichier | Usage |
|---------|---------|-------|
| **YERSINIA-GDD** | `contexts/YERSINIA-GDD-context.md` | **TOUJOURS - Game Design complet** |
| **GAME-JAM-TIMELINE** | `contexts/GAME-JAM-TIMELINE-context.md` | Si planning/timeline critique |
| **ROGUELIKE-PATTERNS** | `contexts/ROGUELIKE-PATTERNS-context.md` | Si mécanique roguelike |
| **GODOT-SETUP** | `contexts/GODOT-SETUP-context.md` | Si infra/performance |
| **AGENT-TEMPLATE** | `contexts/AGENT-TEMPLATE-context.md` | Avec agent-creator |

---

## 🚀 Quick Start

### Pour une simple feature:
```
@context yersinia-gdd
@agent yersinia-gameplay

Besoin: Améliorer l'IA des rats
```

### Pour multi-agent feature:
```
Step 1:
@context yersinia-gdd
@agent yersinia-gameplay
Besoin: Implémenter combat joueur

Step 2:
@context yersinia-gdd
@agent yersinia-ui
Besoin: Créer UI du combat
```

### Pour créer agent spécialisé:
```
@context yersinia-gdd
@agent yersinia-agent-creator

Besoin: Créer agent pour système de chests/loot
```

---

## ⚠️ Common Mistakes

| Erreur | Correction |
|--------|-----------|
| `@agent yersinia-gameplay - créer boutique` | ❌ Boutique = NPC agent |
| `@agent yersinia-ui - implémenter traîtres` | ❌ Traîtres = NPC agent |
| `@agent yersinia-art - optimiser 30 FPS` | ❌ Performance = performance agent |
| `@agent yersinia-progression - ajouter bouton` | ❌ Bouton = UI agent |
| `@agent yersinia-narrative - dialogue branché` | ❌ MVP = linéaire simple (NPC) |

---

## 📚 Fichier Principal de Référence

**[CUSTOM-AGENTS-MANIFEST.md](./CUSTOM-AGENTS-MANIFEST.md)**
- ✅ Agents disponibles (table)
- ✅ Contexts disponibles
- ✅ Workflow recommandé
- ✅ Principes clés
- ✅ Liens vers documentation des scopes

---

## 🔗 Relations Entre Fichiers

```
CUSTOM-AGENTS-MANIFEST.md (main entry point)
    ↓
    ├─→ AGENT-SCOPES-LIMITATIONS.md (detailed specs per agent)
    │   └─→ Voir les limitations de chaque agent
    │
    ├─→ AGENT-DEPLOYMENT-GUIDE.md (implementation guide)
    │   └─→ Decision matrix + examples + mistakes
    │
    ├─→ AGENT-PROFILE-CARDS.md (quick reference)
    │   └─→ 1 fiche par agent, format compact
    │
    ├─→ IMPLEMENTATION-SUMMARY.md (overview)
    │   └─→ Vue d'ensemble du système
    │
    └─→ (Ce fichier) INDEX.md (navigation)
        └─→ Centralize documentation
```

---

## 💡 Tips & Tricks

### Tip 1: Toujours charger yersinia-gdd
```
@context yersinia-gdd
@agent [agent-name]
```
Le contexte GDD est la source unique de vérité.

### Tip 2: Vérifier les scopes avant d'appeler
Consultez les 3 documents de scope avant d'appeler un agent.
- Besoin gameplay? → yersinia-gameplay
- Besoin PNJ? → yersinia-npc
- Besoin UI? → yersinia-ui

### Tip 3: Appels séquentiels pour multi-agent
Si une feature nécessite 2+ agents, faire des appels séquentiels séparés.

### Tip 4: Agent-creator pour new specialties
Si vous avez un besoin spécialisé non couvert, utiliser agent-creator.

---

## 📊 Statistics

- **Total Agents:** 10 spécialisés
- **Scopes dokumentés:** ✅ 10/10
- **Documentation files:** 4
- **Contexts disponibles:** 5
- **MVP Timeline:** 4-5 jours
- **Target Platform:** Android/iOS (30 FPS baseline)

---

## ✅ Status

- ✅ Tous les agents documentés
- ✅ Scopes et limitations clairs
- ✅ Appels corrects vs incorrects spécifiés
- ✅ Decision matrix disponible
- ✅ Quick reference cards créées
- ✅ Fichier INDEX créé

---

**Créé pour:** Yersinia: The Great Mortality - Game Jam Edition  
**Version:** 1.0 - MVP  
**Dernière mise à jour:** 2026-01-27  
**Status:** ✅ Ready for Team Use

---

**Questions?** Consultez:
1. AGENT-SCOPES-LIMITATIONS.md pour détails
2. AGENT-DEPLOYMENT-GUIDE.md pour guide complet
3. AGENT-PROFILE-CARDS.md pour quick lookup

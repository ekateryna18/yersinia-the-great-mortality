# 🎯 INDEX: Agent PM - Où Commencer

**Tu as un nouvel Agent PM qui décompose le jeu Yersinia en stories prêtes-à-développer.**

---

## 📍 QUICKSTART (2 MINUTES)

### Ce que tu cherches:
- **Créer les stories pour un système?**
  → Lire: [README-PM-AGENT.md](README-PM-AGENT.md) (5 min)
  → Utiliser: `@agent yersinia-pm`

- **Comprendre comment utiliser PM?**
  → Lire: [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md) (20 min complet)

- **Voir exemple concret (Gameplay Loop)?**
  → Lire: [EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md) (15 min)

- **Naviguer tous les agents & contexts?**
  → Lire: [DOCUMENTATION.md](DOCUMENTATION.md) ou [manifest.yaml](manifest.yaml)

---

## 📚 FICHIERS FOURNIS

### 🎯 NOUVEAUX - Pour Agent PM

| Fichier | Description | Lire si... |
|---------|-------------|-----------|
| [README-PM-AGENT.md](README-PM-AGENT.md) | **Quick start PM** (5 min) | Tu veux démarrer vite |
| [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md) | **Documentation complète PM** (20 min) | Tu veux comprendre fond |
| [EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md) | **Exemple Gameplay Loop** (15 min) | Tu veux un exemple concret |
| [yersinia-pm-project-manager.md](agents/yersinia-pm-project-manager.md) | **Agent PM lui-même** | (Tu n'as pas besoin de lire, juste `@agent yersinia-pm`) |

### 📋 EXISTANTS - Référence

| Fichier | Description |
|---------|-------------|
| [README.md](README.md) | Main README (mis à jour avec PM) |
| [DOCUMENTATION.md](DOCUMENTATION.md) | Full agent & context reference |
| [manifest.yaml](manifest.yaml) | Index tous agents + contexts |

---

## 🚀 WORKFLOW RECOMMANDÉ

```
1. Lire README-PM-AGENT.md (5 min)
   → Comprendre ce que PM fait
   
2. Utiliser l'agent PM:
   @agent yersinia-pm
   "Créer les stories pour [système]"
   
3. Recevoir stories prêtes-à-dev:
   - Acceptance Criteria clairs ✅
   - Context Yersinia chargé ✅
   - Agent spécialisé recommandé ✅
   - Risques documentés ✅
   
4. Assigner stories à agents spécialisés
   
5. ✅ Done - Stories implémentées proprement
```

---

## ❓ FAQ RAPIDE

### Q: Qu'est-ce que l'agent PM fait?
**A:** Décompose les systèmes de jeu en **stories documentées, prêtes-à-développer**, avec acceptance criteria clairs, context technique, agents recommandés, et risques identifiés.

### Q: Comment l'utiliser?
**A:** 
```
@agent yersinia-pm
Créer les stories pour [gameplay-loop | npc-system | ui-mobile | progression]
```
Puis reçois tout prêt-à-dev.

### Q: Qu'est-ce qu'une "story prête-à-dev"?
**A:** Une story qui a:
- ✅ Acceptance Criteria testables
- ✅ Context Yersinia chargé (architecture, constraints, méchaniques)
- ✅ Agent spécialisé recommandé
- ✅ Dépendences identifiées (blocker? unblock?)
- ✅ Risques + mitigations documentés
- ✅ Timeline estimée
- ✅ Ready-to-Dev: YES

Donc développeur peut commencer **immédiatement** sans questions.

### Q: Le PM remplace quelle étape?
**A:** Le PM remplace la phase "décomposition". Normalement tu dis "créer système X", tu dois découper toi-même. PM le fait automatiquement + génère stories.

### Q: Quels systèmes PM peut décomposer?
**A:** N'importe quel système Yersinia:
- Gameplay Loop (jour/nuit, vagues, combat)
- NPC System (PNJ, traîtres, énigmes)
- UI Mobile (layouts, touch targets, HUD)
- Progression (gloire, stats, balance)
- Assets (sprites, pipeline, organisation)
- etc.

### Q: Et après les stories?
**A:** Tu assignes chaque story à l'agent spécialisé que PM recommande:
```
@agent yersinia-gameplay-programmer
(avec story + context déjà chargé du PM)
```

### Q: Comment je track le progress?
**A:** 
```
@agent yersinia-pm
Burn-down sprint-1    # Voir quoi complété
```

---

## 🎓 LECTURES RECOMMANDÉES (par ordre)

### Débutant (15 minutes)
1. Ce fichier (INDEX)
2. [README-PM-AGENT.md](README-PM-AGENT.md) - Quick start

→ **Tu peux utiliser le PM maintenant**

### Intermédiaire (45 minutes)
3. [EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md) - Exemple concret Gameplay Loop
4. [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md) - Documentation complète PM

→ **Tu comprends comment PM fonctionne en détail**

### Avancé (15 minutes)
5. [manifest.yaml](manifest.yaml) - Voir tous les agents/contexts
6. [DOCUMENTATION.md](DOCUMENTATION.md) - Référence complète

→ **Tu connais tout l'écosystème BMAD Yersinia**

---

## 🎮 EXEMPLE RAPIDEMENT

### Tu veux les stories pour le gameplay-loop:

```bash
# 1. Charge PM
@agent yersinia-pm

# 2. Demande
Créer les stories pour le système gameplay-loop

# 3. Reçois (dans EXAMPLE-PM-AGENT.md):
## Epic 1: Day/Night Cycle Foundation
- GDD-001: State Machine (4h) → Ready ✅
- GDD-002: Timer (3h) → Ready ✅

## Epic 2: Wave System
- GDD-003: Wave Manager (6h) → Ready ✅
- GDD-004: Spawn Algorithm (4h) → Ready ✅

## Epic 3: Combat
- GDD-005: Player Attack (5h) → Ready ✅
- GDD-006: Knockback (3h) → Ready ✅

Sprint: Day 1-2-3 timeline
Risks: 5 identified + mitigations
Dependencies: Graph showing order
```

**Boom - tu as 6 stories prêtes-à-assigner aux devs.**

---

## 📞 COMMANDES CLÉS

```bash
# Créer stories
@agent yersinia-pm
Créer les stories pour [système]

# Planner sprint
@agent yersinia-pm
Planner sprint 1

# Voir blockers
@agent yersinia-pm
Quels sont les blockers actuels?

# Burn-down
@agent yersinia-pm
Burn-down sprint-1
```

---

## ✅ PRÊT À DÉMARRER?

1. **Lire:** [README-PM-AGENT.md](README-PM-AGENT.md) (5 min) ← COMMENCE ICI
2. **Utiliser:** `@agent yersinia-pm`
3. **Recevoir:** Stories prêtes-à-dev

**C'est tout. Le PM s'occupe du reste.**

---

## 🔗 FICHIERS PAR CAS D'USAGE

### "Je veux juste commencer"
→ [README-PM-AGENT.md](README-PM-AGENT.md)

### "Je veux voir un exemple"
→ [EXAMPLE-PM-AGENT.md](EXAMPLE-PM-AGENT.md)

### "Je veux comprendre en détail"
→ [GUIDE-PM-AGENT.md](GUIDE-PM-AGENT.md)

### "Je veux voir tous les agents"
→ [DOCUMENTATION.md](DOCUMENTATION.md)

### "Je veux le manifest complet"
→ [manifest.yaml](manifest.yaml)

### "Je veux créer nouvel agent custom"
→ [DOCUMENTATION.md](DOCUMENTATION.md) section "Créer agent custom"

### "Je suis bloqué par une erreur"
→ `@context erreurs-courantes`

---

*Index Agent PM - Start Here to Decompose Yersinia into Stories*

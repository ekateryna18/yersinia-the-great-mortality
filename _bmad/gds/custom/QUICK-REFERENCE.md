# 🎯 YERSINIA AGENTS - QUICK REFERENCE (1 Page)

## 10 Agents à Votre Service

| # | Agent ID | Title | ✅ Domaine | ❌ Limitations |
|---|----------|-------|---------|----------------|
| 1️⃣ | `yersinia-gameplay` | 🎮 Gameplay Programmer | Combat, vagues, IA | PAS: PNJ, UI, art, perf |
| 2️⃣ | `yersinia-npc` | 🧑 NPC Architect | PNJ, traîtres, dialogues | PAS: Gameplay, progression, UI avancée |
| 3️⃣ | `yersinia-ui` | 💻 UI Specialist | Interfaces, joysticks | PAS: Gameplay, art, backend |
| 4️⃣ | `yersinia-progression` | 📊 Progression Specialist | Gloire, économie, balance | PAS: Implementation, UI, IAP |
| 5️⃣ | `yersinia-performance` | ⚡ Performance Engineer | 30 FPS, optimisation | PAS: New features, design |
| 6️⃣ | `yersinia-art` | 🎨 Art Director | Sprites, tileset, style | PAS: Code, gameplay, UI |
| 7️⃣ | `yersinia-narrative` | 📖 Narrative Designer | Lore, dialogues, univers | PAS: System technical, code |
| 8️⃣ | `yersinia-qa` | 🧪 QA Lead | Testing, balance, validation | PAS: Code fix, gameplay design |
| 9️⃣ | `yersinia-business` | 💰 Business Advisor | IAP, KPI, monétisation | PAS: Code, MVP features |
| 🔟 | `yersinia-agent-creator` | 🤖 Agent Creator | Créer agents, workflows | PAS: Direct feature implementation |

---

## 🚀 Appel Simple (Copier-Coller)

```
@context yersinia-gdd
@agent yersinia-gameplay

Besoin: [Votre demande spécifique]
```

**Remplacer `yersinia-gameplay` par l'agent approprié selon le besoin.**

---

## 📋 Decision Tree (30 Secondes)

```
Qu'est-ce que vous voulez faire?

├─ Combats / Vagues / IA → yersinia-gameplay ✅
├─ PNJ / Traîtres / Dialogues → yersinia-npc ✅
├─ Interfaces / Joysticks → yersinia-ui ✅
├─ Gloire / Économie / Balance → yersinia-progression ✅
├─ 30 FPS / Optimisation → yersinia-performance ✅
├─ Sprites / Style artistique → yersinia-art ✅
├─ Lore / Narrative → yersinia-narrative ✅
├─ Testing / QA → yersinia-qa ✅
├─ IAP / Monétisation → yersinia-business ✅
└─ Créer nouvel agent → yersinia-agent-creator ✅
```

---

## ⚠️ 5 Erreurs Communes (Et Comment Les Fixer)

| Erreur | ❌ Mauvais | ✅ Correct |
|--------|---------|-----------|
| Boutique IAP | `@agent yersinia-gameplay` | `@agent yersinia-npc` |
| Optimiser 30 FPS | `@agent yersinia-art` | `@agent yersinia-performance` |
| Traîtres | `@agent yersinia-ui` | `@agent yersinia-npc` |
| Dialogue branché 5 choix | N/A (MVP non) | Dialogues linéaires seulement |
| Bouton Acheter | `@agent yersinia-progression` | `@agent yersinia-ui` + `yersinia-npc` |

---

## 📚 3 Documents Essentiels

| # | Fichier | Quand Consulter | Format |
|---|---------|-----------------|--------|
| 1 | [AGENT-SCOPES-LIMITATIONS.md](./AGENT-SCOPES-LIMITATIONS.md) | Besoin des détails | Détaillé (10 sections) |
| 2 | [AGENT-DEPLOYMENT-GUIDE.md](./AGENT-DEPLOYMENT-GUIDE.md) | Formation équipe | Complet + exemples |
| 3 | [AGENT-PROFILE-CARDS.md](./AGENT-PROFILE-CARDS.md) | Lookup rapide | Compact + checkboxes |

**Index Complet:** [INDEX.md](./INDEX.md)

---

## 💡 Pattern d'Appel Simple Feature

```
@context yersinia-gdd
@agent yersinia-gameplay
Besoin: Améliorer l'IA des rats pour qu'ils évitent les obstacles
```

## 💡 Pattern Multi-Agent Feature

```
# Step 1: Gameplay logic
@context yersinia-gdd
@agent yersinia-gameplay
Besoin: Implémenter le système de combat joueur

# Step 2: UI display
@context yersinia-gdd
@agent yersinia-ui
Besoin: Créer l'interface du combat (button positions, feedback)
```

---

## ✅ Checklist Avant d'Appeler un Agent

- [ ] Contexte chargé (`@context yersinia-gdd`)?
- [ ] Agent approprié pour le besoin? (Voir decision tree)
- [ ] Scope valide? (Pas ❌ limitations)
- [ ] Prêt à appeler!

---

## 🎯 MVP Scope (Ne Pas Oublier)

**✅ IN SCOPE:**
- Gameplay jour/nuit + 5 nuits
- 2 traîtres aléatoires
- Dialogues linéaires simples
- 3 PNJ principaux
- Progression gloire (run-to-run)
- 30 FPS baseline mobile
- Permadeath système

**❌ OUT OF SCOPE:**
- Dialogue branché complexe
- Réputation avancée
- Multijoueur
- Market complex
- Ads/IAP avancée

---

**Version:** 1.0 - MVP Quick Ref  
**Créé:** 2026-01-27  
**Status:** ✅ Ready

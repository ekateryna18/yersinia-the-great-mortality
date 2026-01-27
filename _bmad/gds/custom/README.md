# 🤖 CUSTOM AGENTS - Yersinia Project

Bienvenue dans le système de Custom Agents BMAD pour Yersinia: The Great Mortality!

## 🚀 Quick Start

```bash
# Charger Agent Creator
@agent yersinia-creator

# Charger contextes projet
@context project-overview
@context contraintes-mvp

# Créer agent personnalisé
@agent yersinia-creator
→ Menu item 1: Créer un nouvel agent custom
```

## 📁 Structure

```
custom/
├── README.md                           # Ce fichier
├── manifest.yaml                       # 📋 Index agents & contexts
├── DOCUMENTATION.md                    # 📚 Guide complet
├── TEMPLATE-AGENT-CUSTOM.md            # 🎨 Template réutilisable
│
├── agents/
│   ├── yersinia-agent-creator.md       # 🤖 Agent Creator (crée agents)
│   └── [future-custom-agents]
│
└── contexts/
    ├── YERSINIA-PROJECT-CONTEXT.md     # 📖 Vue projet complète
    ├── CONTRAINTES-MVP.md              # ⚠️ Limites PO (OBLIGATOIRE)
    ├── GAMEPLAY-MECHANICS-context.md   # 🎮 Jour/nuit, vagues, combat
    ├── NPC-TRAITOR-SYSTEM-context.md   # 🧑‍🤝‍🧑 PNJ, traîtres, énigmes
    ├── UI-MOBILE-DESIGN-context.md     # 📱 Interfaces tactiles
    ├── PROGRESSION-ECONOMY-context.md  # 📈 Gloire, stats persist
    ├── PERFORMANCE-CONSTRAINTS-context.md # ⚡ 30 FPS, <5s chargement
    ├── ASSET-PIPELINE-context.md       # 🎨 Sprites, organisation
    ├── NARRATIVE-LORE-context.md       # 📖 Univers, dialogues
    ├── MONETIZATION-STRATEGY-context.md # 💰 IAP, business model
    └── ERREURS-COURANTES-context.md    # 🆘 SOS troubleshooting
```

## 🎯 Agents disponibles

### Custom Agents
| Agent | ID | Description |
|-------|----|----|
| 🤖 Agent Creator | `yersinia-creator` | Crée et configure agents BMAD custom |

### GDS Standards (intégrés)
| Agent | ID | Description |
|-------|----|----|
| 🎮 Gameplay Programmer | `gameplay-programmer` | Boucles jeu, vagues, IA |
| 🧑‍🤝‍🧑 NPC System Architect | `npc-system-architect` | PNJ, traîtres, énigmes |
| 📱 UI Systems Specialist | `ui-systems-specialist` | Interfaces mobiles |
| 📈 Progression & Economy | `progression-economy` | Gloire, stats persist |
| ⚡ Mobile Performance | `mobile-performance` | 30 FPS, memory, loading |
| ✅ QA Testing Lead | `qa-testing-lead` | Tests, balance, edge cases |
| 🎨 Art & Asset Director | `art-asset-director` | Sprites isométriques |
| 📖 Narrative Designer | `narrative-designer` | Univers, dialogues, lore |

## 📋 Contexts clés

### À charger OBLIGATOIREMENT
```
@context project-overview      # Vue projet complète
@context contraintes-mvp       # Limites PO - OBLIGATOIRE
```

### Par feature
```
Gameplay      → @context gameplay-mechanics
PNJ/Traître   → @context npc-traitor-system
UI Mobile     → @context ui-mobile-design
Progression   → @context progression-economy
Performance   → @context performance-constraints
Assets        → @context asset-pipeline
Narrative     → @context narrative-lore
Monetization  → @context monetization-strategy
Error         → @context erreurs-courantes
```

## 🔄 Workflows

### Feature: Implémentation jour/nuit
```
1. @context project-overview           # Orienter
2. @context contraintes-mvp            # Limites temps
3. @agent gameplay-programmer          # Développer
4. @context gameplay-mechanics         # Référence
5. @agent qa-testing-lead              # Tester
```

### Feature: Système traître
```
1. @context project-overview
2. @context contraintes-mvp
3. @agent npc-system-architect         # Architecture
4. @context npc-traitor-system         # Détails
5. @agent qa-testing-lead              # Tests
```

### Feature: Créer agent custom
```
1. @agent yersinia-creator             # Lance création
   (Pose questions → Génère structure → Crée contexts)
2. @agent [new-agent-id]               # Utilise nouvel agent
3. Agent ajouté manifest automatiquement
```

## ✅ Checklist utilisation

### Avant chaque intervention
- [ ] Charger `@context project-overview`
- [ ] Charger `@context contraintes-mvp`
- [ ] Charger contexte feature spécifique
- [ ] Charger agent approprié
- [ ] Implémenter
- [ ] Tester avec QA agent

### Créer agent custom
- [ ] `@agent yersinia-creator`
- [ ] Menu → Créer agent
- [ ] Répondre questions
- [ ] Agent généré + context créé
- [ ] Manifest mis à jour automatiquement
- [ ] Test: `@agent [new-id]`

### Créer context feature
- [ ] Identifier besoin context
- [ ] `@agent yersinia-creator`
- [ ] Menu → Générer context
- [ ] Spécifier feature
- [ ] Context créé
- [ ] Documenté avec examples
- [ ] Réutilisable

## 🎨 Templates

### Créer agent custom rapidement
```
Copie: _bmad/gds/custom/TEMPLATE-AGENT-CUSTOM.md
Remplace placeholders [ENTRE_CROCHETS]
Ajoute via `@agent yersinia-creator`
```

## 🔐 Agent Creator features

Agent Creator (`@agent yersinia-creator`) propose:

1. **Créer nouvel agent**
   - Questions spécialisation
   - Génère structure YAML
   - Crée menu + handlers
   - Valide syntax

2. **Générer context support**
   - Pour feature spécifique
   - Sections organisées
   - Examples documentés
   - Réutilisable

3. **Ajouter agent au manifest**
   - Mise à jour automatique
   - Validation références
   - Cohérence maintenue

4. **Lister agents disponibles**
   - Vue complète ecosystem
   - ID, descriptions
   - Usages recommandés

5. **Configurer Copilot**
   - Setup recherche agents
   - @agent et @context autocomplétion
   - Manifest integration

## 📚 Documentation

- **Manifest:** `manifest.yaml` - Index agents & contexts
- **Guide complet:** `DOCUMENTATION.md` - Usage patterns, FAQ
- **Template agent:** `TEMPLATE-AGENT-CUSTOM.md` - Copier-coller
- **This file:** `README.md` - Quick start & structure

## 🚨 Important

### ⚠️ CHARGER TOUJOURS OBLIGATOIREMENT
```
@context project-overview
@context contraintes-mvp
```

Ces contextes définissent:
- Architecture projet
- Limites MVP 4 jours
- Constraints non-négotiables
- Success metrics

### ❌ Contraintes MVP
- ❌ Pas de scope creep (4 jours!)
- ❌ Pas de features post-MVP
- ❌ Pas de complexité gratuite
- ❌ Pas d'IAP paywall

### ✅ Patterns validés
- ✅ Jour/nuit cycle
- ✅ Random traitor system
- ✅ Object pooling ennemis
- ✅ Virtual joystick mobile
- ✅ Persistent progression

## 🔗 Intégration Copilot

Pour activer custom agents dans Copilot:

```yaml
# .copilot/copilot.yaml (ou config Copilot)
custom_agents_manifest: _bmad/gds/custom/manifest.yaml

agent_search_paths:
  - _bmad/gds/agents/
  - _bmad/gds/custom/agents/

context_search_paths:
  - _bmad/gds/custom/contexts/
```

Puis utiliser:
```
@agent yersinia-creator
@agent gameplay-programmer
@context project-overview
@context npc-traitor-system
```

## 🎯 Cas d'usage

### Je veux...

**...comprendre le projet**
→ `@context project-overview`

**...implémenter jour/nuit**
→ `@context gameplay-mechanics` + `@agent gameplay-programmer`

**...créer système traître**
→ `@context npc-traitor-system` + `@agent npc-system-architect`

**...créer agent custom**
→ `@agent yersinia-creator` (menu item 1)

**...tester équilibre**
→ `@agent qa-testing-lead`

**...optimiser mobile**
→ `@agent mobile-performance`

**...documenter projet**
→ `@context project-overview` + générateur doc

## 📞 Support

**Q: Quel agent pour [feature]?**
→ Consulte manifest.yaml ou `@agent yersinia-creator` (menu: Lister agents)

**Q: Comment créer agent custom?**
→ `@agent yersinia-creator` (menu: Créer nouvel agent)

**Q: Erreur [description]?**
→ `@context erreurs-courantes` (troubleshooting rapide)

**Q: Timeline MVP?**
→ `@context contraintes-mvp` (limites PO)

---

**🎮 Ready?**

```bash
# Démarre par:
@agent yersinia-creator

# Ou charge projet:
@context project-overview
@context contraintes-mvp

# Puis utilise agents/contexts comme besoin
```

Bon développement! 🚀

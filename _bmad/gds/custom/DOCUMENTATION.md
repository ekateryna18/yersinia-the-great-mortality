# 📚 DOCUMENTATION AGENT CREATOR & CUSTOM AGENTS

## Quick Start

### Charger Agent Creator
```
@agent yersinia-creator
```

### Charger contexte projet
```
@context project-overview
@context contraintes-mvp
```

### Créer un nouvel agent
```
@agent yersinia-creator

Créer un agent pour [feature/system spécifique]
```

---

## Architecture BMAD Yersinia

### Structure répertoires
```
_bmad/gds/
├── agents/                          # Agents GDS standards
│   ├── gameplay-programmer.md
│   ├── npc-system-architect.md
│   ├── ui-systems-specialist.md
│   └── ... (7 autres)
├── custom/                          # Agents & contexts custom
│   ├── manifest.yaml                # Documentation tous agents
│   ├── TEMPLATE-AGENT-CUSTOM.md     # Template réutilisable
│   ├── agents/
│   │   ├── yersinia-agent-creator.md
│   │   └── [future-custom-agents]
│   └── contexts/
│       ├── YERSINIA-PROJECT-CONTEXT.md
│       ├── CONTRAINTES-MVP.md
│       ├── GAMEPLAY-MECHANICS-context.md
│       ├── NPC-TRAITOR-SYSTEM-context.md
│       └── [future-contexts]
└── workflows/
    └── [workflows utilisés par agents]
```

---

## Agents disponibles

### GDS Standards (8 agents)
1. **Gameplay Programmer** → `@agent gameplay-programmer`
2. **NPC System Architect** → `@agent npc-system-architect`
3. **UI Systems Specialist** → `@agent ui-systems-specialist`
4. **Progression & Economy** → `@agent progression-economy`
5. **Mobile Performance** → `@agent mobile-performance`
6. **QA Testing Lead** → `@agent qa-testing-lead`
7. **Art & Asset Director** → `@agent art-asset-director`
8. **Narrative Designer** → `@agent narrative-designer`

### Custom Agents (new!)
1. **Agent Creator** → `@agent yersinia-creator`

---

## Contexts disponibles

### Project contexts
- **@context project-overview** - Vue complète projet + architecture
- **@context contraintes-mvp** - ⚠️ OBLIGATOIRE - Contraintes PO 4j
- **@context gameplay-mechanics** - Jour/nuit, vagues, combat
- **@context npc-traitor-system** - 6 PNJ, 2 traîtres, énigmes
- **@context ui-mobile-design** - Layouts, touch targets, HUD
- **@context progression-economy** - Gloire, stats persist, balance
- **@context performance-constraints** - 30 FPS, <5s chargement
- **@context asset-pipeline** - Sprites Godot, organisation
- **@context narrative-lore** - Univers, dialogues, lore
- **@context monetization-strategy** - IAP, cooldown, business model

### Support contexts
- **@context erreurs-courantes** - SOS: Erreur → Fix one-liner

---

## Workflows recommandés par feature

### Feature: Implémentation jour/nuit
1. `@context project-overview` - Comprendre scope
2. `@context contraintes-mvp` - Mémoriser limites
3. `@agent gameplay-programmer` - Implémentation
4. `@context gameplay-mechanics` - Référence détails
5. `@agent qa-testing-lead` - Tests

### Feature: Système traître
1. `@context project-overview`
2. `@context contraintes-mvp`
3. `@agent npc-system-architect` - Architecture
4. `@context npc-traitor-system` - Détails système
5. `@agent qa-testing-lead` - Tests edge cases

### Feature: UI mobile
1. `@context project-overview`
2. `@agent ui-systems-specialist` - Implémentation
3. `@context ui-mobile-design` - Référence
4. `@agent mobile-performance` - Optimisation
5. Test sur appareils réels

### Feature: Création nouvel agent custom
1. `@agent yersinia-creator` - Crée agent
2. Agent Creator génère contexts auto
3. Agent ajouté manifest automatiquement
4. Testable avec `@agent [new-id]`

---

## Best practices utilisation

### ✅ DO
- ✅ Charger PROJECT-OVERVIEW en premier (orienter contexte)
- ✅ Charger CONTRAINTES-MVP avant implémentation (respecter scope)
- ✅ Charger context spécifique feature (références détails)
- ✅ Charger agent spécialisé (expertise ciblée)
- ✅ Valider avec QA testing lead (régression + balance)
- ✅ Créer agent custom pour nouvelles spécialités (réutilisabilité)
- ✅ Ajouter context projet custom pour features complexes

### ❌ DON'T
- ❌ Ignorer contraintes MVP (scope creep)
- ❌ Développer sans contexte spécifique (erreurs d'implémentation)
- ❌ Passer l'étape teste (buggy release)
- ❌ Créer agent pour simple demande (utiliser existants)
- ❌ Modifie manifest manuellement (utiliser Agent Creator)
- ❌ Oublier charge @context + @agent (manque de contexte)

---

## Patterns workflow complets

### Pattern: Gameplay feature complète
```
1. @context project-overview       # Comprendre scope général
2. @context contraintes-mvp         # Limites de temps
3. @context gameplay-mechanics      # Détails de la feature
4. @agent gameplay-programmer       # Développement
   → Pose questions clarification
   → Génère architecture
   → Code implémentation
5. @agent qa-testing-lead          # Test complet
   → Balance testing
   → Edge case validation
   → Performance check
6. @agent mobile-performance        # Optimisation si besoin
7. Commit + Push
```

### Pattern: Création système nouveau
```
1. @agent yersinia-creator         # Crée agent custom
   → Questions spécialisation
   → Génère structure agent
   → Crée contexts support
   → Ajoute manifest
2. @agent [new-custom-agent]       # Utilise agent créé
   → Feature implementation
3. @context [new-context]          # Référence détails
4. Itération agile
```

---

## Troubleshooting

### Problème: @agent non trouvé
**Solution:**
1. Vérifie ID exact dans manifest.yaml
2. Recharge manifest Copilot
3. Utilise `@agent yersinia-creator` → Lister agents

### Problème: Context manquant
**Solution:**
1. Crée context via `@agent yersinia-creator`
2. Ou ajoute manually dans _bmad/gds/custom/contexts/
3. Recharge manifest

### Problème: Agent pas à jour
**Solution:**
1. L'Agent Creator a créé version
2. Modifie directement fichier .md
3. Recharge Copilot

### Problème: Inconsistance architecture
**Solution:**
1. Charge `@context contraintes-mvp`
2. Relis architecture project
3. Valide avec agent spécialisé
4. Refactor si besoin

---

## FAQ

**Q: Puis-je créer mon propre agent custom?**
A: Oui! Via `@agent yersinia-creator` → Créer nouvel agent

**Q: Comment j'ajoute context pour ma feature?**
A: Via `@agent yersinia-creator` → Générer context support

**Q: Peux-je modifier agents GDS?**
A: Déconseillé (standard). Crée agent custom à la place.

**Q: Comment j'utilise Agent Creator?**
A: `@agent yersinia-creator` puis choisis action du menu

**Q: Contextes @ context format?**
A: Markdown (.md) avec sections claires, documentées

**Q: Où je mets mon agent custom?**
A: `_bmad/gds/custom/agents/[nom].md`

**Q: Quoi après créer agent?**
A: Agent Creator l'ajoute manifest auto → `@agent [id]` fonctionne

---

## Ressources

- **Manifest agents:** `_bmad/gds/custom/manifest.yaml`
- **Template agent:** `_bmad/gds/custom/TEMPLATE-AGENT-CUSTOM.md`
- **GDD complet:** Initial request utilisateur
- **Project context:** `@context project-overview`
- **MVP limits:** `@context contraintes-mvp`

---

**🎮 READY? Commence par:**
```
@agent yersinia-creator
```

Ou charge projet:
```
@context project-overview
@context contraintes-mvp
```

Good luck! 🚀

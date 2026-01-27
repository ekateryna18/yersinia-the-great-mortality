# 🤖 Yersinia Custom Agents System - Documentation

## 📖 Vue d'ensemble

Le système custom d'agents BMAD permet de générer, gérer et orchestrer des agents spécialisés pour le développement de Yersinia.

**Architecture:**
```
_bmad/gds/custom/
├── CUSTOM-AGENTS-MANIFEST.md      # Index + documentation agents
├── agents/                         # Agents spécialisés
│   └── agent-creator.md           # Générateur d'agents
└── contexts/                       # Contextes pour agents
    ├── YERSINIA-GDD-context.md
    ├── GAME-JAM-TIMELINE-context.md
    ├── ROGUELIKE-PATTERNS-context.md
    ├── GODOT-SETUP-context.md
    └── AGENT-TEMPLATE-context.md
```

## 🚀 UTILISATION RAPIDE

### 1️⃣ Appeler un agent spécialisé

```
@agent yersinia-gameplay

Besoin: Implémenter le système de vagues d'ennemis
```

**Agents disponibles:**
- `@agent yersinia-agent-creator` - Créer nouveaux agents
- `@agent yersinia-gameplay` - Programmeur gameplay
- `@agent yersinia-npc` - Architécte système PNJ
- `@agent yersinia-ui` - Spécialiste interfaces mobiles
- Etc... (voir CUSTOM-AGENTS-MANIFEST.md pour liste complète)

### 2️⃣ Charger un contexte

```
@context yersinia-gdd

Pour avoir la référence complète du GDD
```

**Contexts disponibles:**
- `@context yersinia-gdd` - 📖 Game Design Document complet (OBLIGATOIRE)
- `@context game-jam-timeline` - ⏱️ Timeline MVP 5 jours
- `@context roguelike-patterns` - 🔄 Patterns roguelike éprouvés
- `@context godot-setup` - 🛠️ Architecture Godot 4.2

---

## 📚 DOCUMENTATION DES SCOPES & LIMITATIONS

**⚠️ IMPORTANT:** Chaque agent a un domaine spécialisé ET des limitations claires.

### Consulter avant d'appeler un agent:

| Document | Contenu | Usage |
|----------|---------|-------|
| **[QUICK-REFERENCE.md](./QUICK-REFERENCE.md)** | 1 page - Decision tree + 5 erreurs courantes | Pour commencer rapidement |
| **[AGENT-SCOPES-LIMITATIONS.md](./AGENT-SCOPES-LIMITATIONS.md)** | Détails complets de chaque agent | Comprendre les limitations |
| **[AGENT-DEPLOYMENT-GUIDE.md](./AGENT-DEPLOYMENT-GUIDE.md)** | Guide complet + exemples corrects/incorrects | Formation équipe |
| **[AGENT-PROFILE-CARDS.md](./AGENT-PROFILE-CARDS.md)** | Fiches rapides avec checkboxes | Lookup rapide en ligne |
| **[INDEX.md](./INDEX.md)** | Navigation complète de tous les fichiers | Se retrouver dans la documentation |

### 🚨 RED FLAGS - Appels Invalides

❌ **"@agent yersinia-gameplay - créer une boutique IAP"**
- Boutique = NPC agent | IAP = business agent

❌ **"@agent yersinia-ui - implémenter le système de traîtres"**
- Traîtres = NPC agent | UI agent = layout seulement

❌ **"@agent yersinia-narrative - créer un dialogue branché à 5 choix"**
- MVP = dialogues linéaires simples (NPC agent), pas d'arborescence

❌ **"@agent yersinia-progression - ajouter un bouton Acheter"**
- Progression = math seulement | Bouton = UI agent + NPC agent

❌ **"@agent yersinia-art - optimiser les 30 FPS"**
- Performance = performance agent | Art agent = sprites/style seulement

---

## 📋 Les 10 Agents (Résumé Rapide)

1. **🎮 yersinia-gameplay** - Boucles jeu, vagues, IA, combats
2. **🧑 yersinia-npc** - PNJ, traîtres, dialogues, commerce
3. **💻 yersinia-ui** - Interfaces, joysticks, adaptive design
4. **📊 yersinia-progression** - Gloire, économie, balance
5. **⚡ yersinia-performance** - Optimisation, 30 FPS
6. **🎨 yersinia-art** - Sprites, style, direction artistique
7. **📖 yersinia-narrative** - Lore, univers, dialogue narratif
8. **🧪 yersinia-qa** - Testing, validation, balance
9. **💰 yersinia-business** - IAP, KPI, monétisation
10. **🤖 yersinia-agent-creator** - Créer agents spécialisés

**→ [Voir les détails complets](./AGENT-SCOPES-LIMITATIONS.md)**
- `@context agent-template` - 🤖 Template créer agents

### 3️⃣ Combiner agents + contexts

```
@context yersinia-gdd
@context roguelike-patterns
@agent yersinia-gameplay

Besoin: Implémenter le système traîtres aléatoires de manière roguelike-compliant
```

## 📋 WORKFLOWS COURANTS

### Workflow 1: Implémenter Une Feature

1. Charger le GDD
```
@context yersinia-gdd
```

2. Charger l'agent spécialisé
```
@agent yersinia-gameplay
```

3. Décrire la feature
```
Besoin: Système de knockback pour ennemis avec gravité
```

### Workflow 2: Déboguer Un Bug

1. Charger contexte Godot
```
@context godot-setup
```

2. Charger agent performance
```
@agent yersinia-performance
```

3. Décrire le bug
```
Bug: Crash au changement jour/nuit, FPS drope à 5
```

### Workflow 3: Créer Un Agent Nouveau

1. Charger le template
```
@context agent-template
```

2. Utiliser le créateur
```
@agent yersinia-agent-creator
Crée un agent pour: Audio systems design
```

3. L'agent généré sera dans `custom/agents/`

## 🎯 PRINCIPES CLÉS

### ✅ À FAIRE
- ✅ Toujours charger `@context yersinia-gdd` d'abord
- ✅ Combiner contexts + agents pour precision
- ✅ Respecter invariants roguelike (permadeath, traîtres, etc)
- ✅ Tester sur mobile (30 FPS baseline)
- ✅ Implémenter dans timeline 5 jours

### ❌ À NE PAS FAIRE
- ❌ Charger un agent sans contexte GDD
- ❌ Modifier invariants (permadeath, jour/nuit, etc)
- ❌ Sacrifier performance pour features
- ❌ Élargir scope MVP sans accord team
- ❌ Oublier progression permanente (gloire system)

## 📊 MATRICE AGENT-FEATURE

Quelle agent appeler pour quelle feature:

| Feature | Agent | Context |
|---------|-------|---------|
| Joueur déplacement | gameplay | godot-setup |
| Ennemi IA | gameplay | roguelike-patterns |
| Système vagues | gameplay | game-jam-timeline |
| PNJ dialogue | npc | yersinia-gdd |
| Traîtres aléatoires | npc | roguelike-patterns |
| UI shop | ui | godot-setup |
| Stats permanentes | progression | yersinia-gdd |
| Optimisation 30 FPS | performance | godot-setup |
| Tests permadeath | qa | roguelike-patterns |
| Art sprites isometrique | art | yersinia-gdd |
| Lore + énigmes | narrative | yersinia-gdd |
| IAP/Monétisation | business | yersinia-gdd |

## 🔐 CONTRAINTES À TOUJOURS RESPECTER

Ces contraintes sont dans GDD - JAMAIS à violer:

1. **Permadeath Inviolable**
   - Mort = fin run, stats permanentes sauvées seulement
   - Jamais de save mid-run

2. **Jour/Nuit Distinct**
   - Jour: Pas d'ennemis, PNJ accessible
   - Nuit: Ennemis spawn, PNJ pas accessible
   - Jamais de mix

3. **Traîtres Aléatoires**
   - 2 traîtres par run, 6 PNJ total
   - Impact sur boss Nuit 5
   - Découverte via énigmes seulement

4. **5 Nuits Exactes**
   - Pas d'extension, pas de shortcut
   - Nuit 5 = boss final + traîtres vivants

5. **Performance Mobile (30 FPS)**
   - Baseline: Android Snapdragon 680+
   - 5 sec load time max
   - <200 MB memory

## 📞 EN CAS DE PROBLÈME

### "Comment créer un nouvel agent?"
```
@context agent-template
@agent yersinia-agent-creator
Crée agent pour: [cas d'usage]
```

### "Quel agent pour [feature]?"
Consulter la matrice agent-feature au-dessus

### "Je viole une contrainte?"
1. Relire YERSINIA-GDD-context.md
2. Charger l'agent spécialisé pour la feature
3. Demander: "Comment implémenter [feature] en respectant [contrainte]?"

### "Performance bloquée?"
```
@context godot-setup
@agent yersinia-performance
Problème: [description du lag]
```

## 🎮 EXEMPLE D'UTILISATION COMPLÈTE

**Scénario:** Vous devez implémenter le système de traîtres

**Commandes Copilot:**
```
@context yersinia-gdd
@context roguelike-patterns
@agent yersinia-npc-system

Besoin complet: 
1. Générer 2 traîtres aléatoires par run
2. Impléter énigmes pour les découvrir
3. Assurer traîtres vivants deviennent boss Nuit 5
4. Tests de regression: Permadeath + traîtres
```

**Agent va:**
1. ✅ Charger GDD + patterns roguelike
2. ✅ Générer code architecture traîtres
3. ✅ Implémenter énigmes système
4. ✅ Intégrer au boss final Nuit 5
5. ✅ Proposer tests QA

## 🔄 MISE À JOUR DU MANIFEST

Après créer un nouvel agent:

1. **Sauvegarder le fichier agent** dans `custom/agents/`
2. **Mettre à jour** `CUSTOM-AGENTS-MANIFEST.md`
```markdown
| yersinia-[domain] | [Name] | custom/agents/[file].md | [Description] |
```
3. **Ajouter contexte** si applicable dans `custom/contexts/`
4. **Commit + push** pour team

## 📚 DOCUMENTATION ADDITIONNELLE

- **CUSTOM-AGENTS-MANIFEST.md** - Index complet agents + contexts
- **AGENT-TEMPLATE-context.md** - Template créer agents
- **YERSINIA-GDD-context.md** - Référence complète du jeu
- **GAME-JAM-TIMELINE-context.md** - Timeline critique MVP
- **ROGUELIKE-PATTERNS-context.md** - Patterns éprouvés
- **GODOT-SETUP-context.md** - Architecture technique Godot

## 🚨 AIDE RAPIDE

```
Besoin rapide?
@agent yersinia-gameplay
/bmad-help comment implémenter [X]?

Bloqué?
@context yersinia-gdd
@context erreurs-courantes (si créé)
@agent [spécialiste]
Je suis bloqué par [problème]
```

---

**🎮 Yersinia: The Great Mortality - Custom Agents System**
**MVP Timeline: 4-5 jours | Godot 4.2 LTS | Mobile (Android/iOS)**

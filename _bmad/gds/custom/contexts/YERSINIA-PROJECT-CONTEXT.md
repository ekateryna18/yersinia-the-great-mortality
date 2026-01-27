# 📋 PROJECT OVERVIEW - Yersinia: The Great Mortality

## Vue d'ensemble du projet

**Nom:** Yersinia: The Great Mortality  
**Genre:** Survivor Roguelike 2D Isométrique (Hack'Slash avec vagues, style Vampire Survivors)
**Plateforme:** Mobile (Android/iOS)  
**Moteur:** Godot 4.2 LTS  
**Timeline MVP:** 4 jours  
**Équipe:** 2 graphistes + 2 développeurs  
**Assets:** Sprites perso + free assets modifiés  

## 🎯 Concept Core

Un survivor roguelike où le joueur survit à des vagues continues de rats mutants la nuit en combattant (hack'slash direct), puis explore et interagit avec des PNJ le jour (5 jours/nuits = 1 run). Le joueur se déplace et combats librement, avec upgrades progressifs entre les runs.

### Méchaniques clés
- **Jour:** Explorer map, parler PNJ, acheter/améliorer équipement
- **Nuit (45-90s):** Défendre contre vagues d'ennemis rats
- **5 cycles:** 5 nuits = 1 run complète
- **Boss final:** Nuit 5 = Rat Boss + PNJ méchant non-tué

## 📐 Architecture système

### Boucle gameplay principal
```
Run Start → Jour 1 (exploration/PNJ) → Nuit 1 (vagues 45-90s) → Jour 2 → ... → Nuit 5 (Boss) → Run End
```

### Systèmes majeurs
1. **Gameplay Loop** - Jour/nuit, vagues continues, combat direct (hack'slash)
2. **Combat Joueur** - Faux melee, attaques zone, knockback, dash, crit
3. **Enemy Waves** - 4 types d'ennemis, spawn continu+progressif par nuit
4. **NPC System** - 6 PNJ, 2 traîtres aléatoires, énigmes
5. **Progression** - Gloire, stats permanentes entre runs
6. **UI Mobile** - Joysticks (déplacement+attaque), HUD adaptatif
7. **Performance** - 30 FPS stable mobile
8. **Assets** - Sprites isométrique jour/nuit

## 👤 Personnage Joueur

**Arme:** Faux (scythe) - Combat melee direct  
**Attaque:** Zone autour joueur (omnidirectionnel ou selon direction déplacement)
**Contrôles mobiles:** Joystick gauche (déplacement), Joystick droit (orientation+attaque) ou Bouton attaque unique
**Méchaniques:** Knockback sur ennemis, dash possible (cooldown), crit possible

**Stats évolutives:**
- HP (points de vie)
- Dégâts (base + arme + enchantements)
- Vitesse déplacement
- Crit (chance coup critique)
- Knockback (force repoussement)
- Armure (réduction dégâts)

## 👹 Systèmes ennemis

**4 types principaux:**
- Rat normal
- Rat mutant
- Rat Boss
- PNJ si attaqué

**Vagues:**
- Nuits 1-4: Vagues progressives
- Nuit 5: Boss final (1 Rat Boss + vagues intensifiées 50+)
- Spawn: Toutes les 10-30 secondes selon difficulté

## 🧑‍🤝‍🧑 Système PNJ

**7 variantes PNJ + 1 aide:**

### PNJ Principaux (3)
- **Marchand:** Vend potions soin, vitesse, force, knockback
- **Forgeron:** Améliore équipement (faux), dégâts/knockback, armure
- **Magicien:** Améliore stats du joueur via gloire/points

### PNJ Variantes
- **Malade (1/7):** Peut être soigné pour bonus
- **Souris Blanche (Aide):** Récupération coffres, non-combattante
- **3 autres variantes:** Rôles génériques

### Système traître
- **6 PNJ par run** avec forcément les 3 principaux + au moins 1 malade
- **2 PNJ méchants aléatoires** (invisibles au joueur)
- **Conséquences:**
  - Si PNJ attaqué → hostile immédiat (combat comme ennemi)
  - Si PNJ méchant tué → N'apparaît pas Nuit 5
  - Si PNJ méchant NON tué → Boss supplémentaire Nuit 5
  - Si PNJ innocent tué → Perd accès services + prix augmente autres PNJ

## 💬 Système dialogue

**Simple et linéaire:**
- Portrait PNJ + texte simple
- Choix: [Commerce] [Améliorer] [Indice méchant] [Attaquer] [Partir]
- Énigmes pour découvrir traîtres
- Traîtres donnent 2 noms aléatoires
- Gentils donnent noms des 2 traîtres si bonne réponse

## 🎨 Assets graphiques

**Sprites à produire:**
- Joueur (avec faux)
- 4 ennemis (rat, rat mutant, rat boss, variantes)
- 7 PNJ + 1 aide (caractères distincts)
- Environnement isométrique (tileset jour/nuit)
- UI (healthbar, dialogue box, shop, inventaire)

## 📊 Scope MVP

### MUST HAVE ✅
- Perso déplacement + attaque auto
- 3 types ennemis
- Vagues spawn automatique
- Cycle jour/nuit
- 5 nuits + boss final
- 3 PNJ commerce/upgrade
- Dialogue simple
- Système PNJ méchant aléatoire
- Progression stats persist
- Mort = relance run
- Devinette des PNJ

### NICE TO HAVE
- Son/musique
- Animations polies
- Particules effets
- Tutorial intégré
- Balancing avancé

### CUT
- ❌ Multijoueur
- ❌ Plusieurs maps
- ❌ Boss variantes multiples
- ❌ Système crafting

## 📈 Métriques succès MVP

### Jouabilité
- Run complète 5 nuits
- Mort moyenne: Nuit 2-3
- Progression visible après 3 runs

### Technique
- 0 crash critique
- 30 FPS stable mobile
- Temps chargement <5 sec

### Fun Factor
- Testeurs complètent 3+ runs volontairement
- Système PNJ méchant = surprise engagement

## 🗺️ Structure projet Godot

```
yersinia--the-great-mortality/
├── scenes/
│   ├── main.tscn
│   ├── player/
│   ├── enemies/
│   ├── npcs/
│   └── ui/
├── scripts/
│   ├── gameplay/
│   ├── npcs/
│   ├── ui/
│   └── progression/
├── assets/
│   ├── sprites/
│   ├── ui/
│   └── audio/
├── _bmad/
│   ├── gds/agents/
│   ├── gds/workflows/
│   └── gds/custom/
└── project.godot
```

## 📝 Documentation références

- **GDD complet:** Dans request utilisateur initial
- **Architecture BMAD:** _bmad/gds/custom/manifest.yaml
- **Agents disponibles:** @agent [nom-agent]
- **Contexts:** @context [context-name]

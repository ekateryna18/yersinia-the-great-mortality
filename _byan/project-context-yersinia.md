# 📋 PROJECT CONTEXT: Yersinia - The Great Mortality

**Project Name:** Yersinia: The Great Mortality
**Date Created:** 2026-02-12
**Status:** In Development
**Deadline:** 1 month (Game Jam)
**Version:** 1.0

---

## 🎮 PROJECT OVERVIEW

### Description
Jeu de survie top-down avec système de vagues d'ennemis (rats) et mécaniques de déduction sociale (identification de traîtres parmi des PNJs). Le joueur doit survivre 5 cycles jour/nuit, identifier et éliminer les traîtres, puis affronter un boss final.

### Domain
Gaming / Action / Survival / Social Deduction

### Subdomain
Wave-based survival with social deduction mechanics

### Maturity Level
**MVP / Early Development**
- Concept défini
- Glossaire créé
- Agents définis
- Prêt pour l'implémentation

---

## 🛠️ TECHNICAL STACK

### Game Engine
- **Godot 4.x** (version 4.2+)
- **GDScript** pour la logique

### Assets
- Sprites 2D (player avec 8 axes d'animation)
- Sprites ennemis (rat, rat_mutant, rat_boss)
- Sprites NPCs (6 personnages)
- UI elements

### Development Tools
- Godot Editor
- Git pour version control
- BYAN process pour documentation

### Constraints
- ✅ Seulement les fichiers `.gd` peuvent être modifiés par les agents
- ❌ Fichiers `.tscn` créés manuellement par Katy
- ⏰ Deadline: 1 mois

---

## 👥 TEAM CONTEXT

### Team Size
**Solo Developer:** Katy

### Skills
- Godot experience
- GDScript
- Game design
- 2D art/sprites

### Development Methodology
- Agile / Iterative
- BYAN process pour agents IA
- Test en continu dans Godot

### Communication Language
**Français** (pour tous les échanges)

---

## 🎯 PROJECT GOALS

### Primary Goals
1. Créer un jeu complet et jouable en 1 mois
2. Implémenter tous les systèmes core (combat, waves, NPCs, shop, cycles)
3. Livrer une expérience fun et équilibrée

### Success Criteria
- 5 cycles jour/nuit fonctionnels
- 3 types d'ennemis avec IA différente
- 6 NPCs avec système de devinettes fonctionnel
- Boss fight final avec traîtres survivants
- Balance de difficulté satisfaisante
- Pas de bugs critiques

### Metrics
- Temps de survie moyen
- Taux de réussite d'identification des traîtres
- Difficulté perçue (feedback testeurs)

---

## 📖 GLOSSAIRE (Business Domain)

### Concept 1: Player (Yersinia)
**Définition:** Personnage jouable contrôlé par le joueur. Protagoniste du jeu.

**Caractéristiques:**
- **Nom:** Yersinia
- **Type:** CharacterBody2D (Godot)
- **Stats:**
  - HP (Points de vie)
  - Speed (Vitesse de déplacement)
  - Damage (Dégâts infligés)
- **Contrôles:** WASD ou flèches pour déplacement, 8 axes de mouvement
- **Animation:** 8 sprites pour 8 directions
- **Mort:** Si HP = 0 → Game Over (fin du run)

**Synonymes:** Joueur, Character, Hero

---

### Concept 2: Enemy (Rats)
**Définition:** Ennemis hostiles qui spawnent pendant les nuits et attaquent le player.

**Types d'ennemis:**
1. **Rat (basique):**
   - HP: Faible (ex: 10-20)
   - Speed: Moyenne (ex: 100)
   - Damage: Faible (ex: 5)
   - Behavior: Suit le player directement

2. **Rat Mutant:**
   - HP: Moyenne (ex: 30-40)
   - Speed: Rapide (ex: 150)
   - Damage: Moyenne (ex: 10)
   - Behavior: Charge vers le player

3. **Rat Boss:**
   - HP: Élevé (ex: 500)
   - Speed: Lente (ex: 80)
   - Damage: Élevé (ex: 25)
   - Behavior: Attaques spéciales + summon rats ?
   - **Apparition:** Uniquement Nuit 5

**Spawn:** Via spawn points (8 fixes sur la map)

**Synonymes:** Ennemi, Monster, Mob

---

### Concept 3: Wave (Vague)
**Définition:** Groupe d'ennemis qui spawn ensemble pendant une nuit.

**Caractéristiques:**
- **Fréquence:** Plusieurs waves par nuit
- **Composition:** Type et nombre de rats
- **Progression:** Nombre et difficulté augmentent chaque nuit
- **Spawn points:** 8 positions fixes sur la map
- **Spawn aléatoire:** Rats apparaissent sur des spawn points aléatoires

**Exemple progression:**
- Nuit 1: 3-5 rats basiques par wave
- Nuit 2: 5-8 rats basiques par wave
- Nuit 3: 8-12 rats + quelques mutants
- Nuit 4: 15-20 rats + beaucoup de mutants
- Nuit 5: Boss + traîtres survivants

**Synonymes:** Horde, Spawn group

---

### Concept 4: Cycle & Run
**Définition:** Structure temporelle du jeu.

**Cycle (Jour/Nuit):**
- **1 Cycle = 1 Jour + 1 Nuit**
- **Jour:**
  - Player explore la map
  - Interagit avec NPCs (devinettes)
  - Achète upgrades au shop
  - Décide quand passer à la nuit
- **Nuit:**
  - Waves d'ennemis
  - Timer (sauf nuit 5)
  - Durée: 45-90 secondes (selon nuit)
  - Survie obligatoire pour passer au jour suivant

**Run (Partie complète):**
- **1 Run = 5 Cycles**
- Nuits 1-4: Timer + waves normales
- Nuit 5: Pas de timer + Boss fight
- Victoire: Survivre la nuit 5
- Défaite: Mort du player = Game Over

**Synonymes:** Loop, Game loop, Partie

---

### Concept 5: NPC (Personnages Non-Joueurs)
**Définition:** Personnages avec lesquels le player peut interagir pendant la journée. Certains sont des traîtres.

**Nombre:** 6 PNJ par run

**Statut:**
- **2 traîtres aléatoires** (changent chaque run)
- **4 innocents malades**

**Mécanique Jour - Système de Devinettes:**
1. Player parle avec un PNJ
2. PNJ pose une devinette
3. Player répond correctement → Débloque un choix
4. **Si player pense traître:**
   - Tuer le PNJ → Éliminé (ne combattra pas nuit 5)
5. **Si player pense innocent:**
   - Aider le PNJ (il est malade) → Player reçoit bonus

**Mécanique Nuit 5 - Boss Fight:**
- **PNJ traîtres survivants:** Combattent avec le Rat Boss
- **PNJ innocents survivants:** Pas d'impact (restent en arrière-plan)

**Objectif stratégique:**
- Identifier les 2 traîtres via les devinettes
- Les éliminer avant la nuit 5
- Aider les innocents pour bonus

**Synonymes:** Personnage, Villageois, Character, Innocent, Traître

---

### Concept 6: Shop & Upgrades (PNJ Spéciaux)
**Définition:** Système de marchands permettant au player d'acheter des améliorations.

**PNJ Marchands:**
1. **Armorer (Armurier):**
   - Vend améliorations **temporaires**
   - Ex: +HP temporaire, +armor pour 1-2 nuits

2. **Merchant (Marchand):**
   - Vend items/équipements
   - Ex: potions, armes

3. **Magicien (Magician):**
   - Vend bonus/sorts
   - Ex: sorts d'attaque, buffs magiques

**Monnaies:**
- **Gold (Or):** Gagné en tuant des ennemis
- **Gloire (Glory):** Gagné en aidant des innocents / accomplissant des objectifs

**Note:** Détails des items et prix à définir lors de l'implémentation

**Synonymes:** Marchand, Vendor, Upgrade system

---

## 👤 ACTEURS DU SYSTÈME

### Acteurs Externes

#### Acteur 1: Joueur Humain
**Type:** External
**Description:** Personne qui joue au jeu
**Permissions:**
- Contrôle le player (Yersinia)
- Prend toutes les décisions de gameplay
- Interagit avec les NPCs
- Achète au shop
- Décide quand passer à la nuit

#### Acteur 2: Player (Yersinia)
**Type:** Internal (Personnage)
**Description:** Personnage jouable dans le jeu
**Capabilities:**
- Se déplacer (8 directions)
- Attaquer les ennemis
- Interagir avec NPCs
- Acheter au shop
- Mourir (HP = 0)

### Acteurs Internes (Systèmes)

#### Système 1: Enemy System
**Type:** System
**Description:** Gère le spawning, l'IA et le comportement des ennemis
**Responsibilities:**
- Spawn rats aux spawn points
- Gestion de l'IA (pathfinding vers player)
- Gestion des stats (HP, damage)
- Détection de la mort
- Drop de gold

#### Système 2: Wave Manager
**Type:** System
**Description:** Contrôle les vagues d'ennemis par nuit
**Responsibilities:**
- Spawn des waves selon la nuit (progression difficulté)
- Timing entre waves
- Choix aléatoire des spawn points
- Détection de fin de wave (tous morts)
- Détection de fin de nuit

#### Système 3: NPC System
**Type:** System
**Description:** Gère les dialogues, devinettes et traîtres
**Responsibilities:**
- Sélection aléatoire de 2 traîtres par run
- Système de devinettes
- Détection des bonnes réponses
- Gestion des choix (tuer / aider)
- Attribution des bonus
- Spawn des traîtres vivants à la nuit 5

#### Système 4: Shop System
**Type:** System
**Description:** Gère les achats et upgrades
**Responsibilities:**
- Affichage des items disponibles
- Gestion des monnaies (gold, gloire)
- Application des upgrades au player
- Gestion de la durée (temporaire vs permanent)

#### Système 5: Cycle Manager
**Type:** System
**Description:** Gère les transitions jour/nuit et le timer
**Responsibilities:**
- Transition jour → nuit (sur demande player)
- Transition nuit → jour (après survie)
- Timer des nuits (sauf nuit 5)
- Comptage des cycles (1 à 5)
- Détection de victoire (survie nuit 5)

#### Système 6: Combat System
**Type:** System
**Description:** Gère les dégâts, collisions et mort
**Responsibilities:**
- Détection des collisions player/ennemis
- Calcul des dégâts
- Application des dégâts (HP)
- Gestion de la mort (player ou ennemi)
- Feedback visuel/audio

---

## 🔄 PROCESSUS MÉTIER CRITIQUES

### Processus 1: Cycle Jour/Nuit
**Criticité:** Critical
**Description:** Boucle de gameplay principale

**Étapes:**
1. **Jour commence** → Player explore
2. Player interagit avec NPCs (optionnel)
3. Player achète au shop (optionnel)
4. Player décide de passer à la nuit
5. **Nuit commence** → Waves d'ennemis
6. Player survit aux waves
7. Timer atteint 0 OU tous ennemis morts
8. **Jour suivant** → Retour à l'étape 1
9. Si Cycle 5 terminé → **VICTOIRE**

**Happy Path:** Player survit toutes les nuits
**Error Path:** Player meurt → Game Over

---

### Processus 2: Combat Nuit
**Criticité:** Critical
**Description:** Système de combat pendant les nuits

**Étapes:**
1. Ennemis spawn aux spawn points
2. Ennemis détectent le player
3. Ennemis se déplacent vers le player
4. Collision player/ennemi → Dégâts
5. Player attaque ennemi → Dégâts
6. Ennemi meurt (HP = 0) → Drop gold, despawn
7. Répéter jusqu'à fin de wave
8. Wave suivante spawn
9. Répéter jusqu'à fin de nuit

**Happy Path:** Player tue tous les ennemis
**Error Path:** Player HP = 0 → Game Over

---

### Processus 3: Interaction PNJ
**Criticité:** High
**Description:** Système de devinettes et choix

**Étapes:**
1. Player clique sur PNJ pour parler
2. PNJ pose une devinette
3. Player choisit une réponse
4. **Si réponse correcte:**
   - Débloque un choix: Tuer / Aider
   - **Si "Tuer":** PNJ éliminé (ne combattra pas nuit 5)
   - **Si "Aider":** Player reçoit bonus (gold, gloire, stats)
5. **Si réponse incorrecte:**
   - Pas de choix débloqué
   - PNJ reste vivant

**Happy Path:** Player devine correctement les traîtres et les tue
**Error Path:** Player tue un innocent → Perte de bonus

---

### Processus 4: Boss Fight Nuit 5
**Criticité:** Critical
**Description:** Combat final contre le Rat Boss + traîtres survivants

**Étapes:**
1. Nuit 5 commence (pas de timer !)
2. Rat Boss spawn au centre de la map
3. PNJs traîtres survivants spawn avec le Boss
4. Combat contre Boss + traîtres
5. Player doit tuer tous les ennemis
6. **Si victoire:** Boss mort → **VICTOIRE DU RUN**
7. **Si défaite:** Player mort → Game Over

**Happy Path:** Player a tué les 2 traîtres avant → combat 1v1 vs Boss
**Challenge Path:** Player n'a tué qu'1 traître → combat 1v2
**Hard Path:** Player n'a tué aucun traître → combat 1v3

---

## 📏 RÈGLES DE GESTION

### RG-001: Structure du Run
**Priority:** Critical
**Regulatory:** Non
**Description:** 1 Run = exactement 5 cycles jour/nuit. Pas plus, pas moins.

---

### RG-002: Sélection des Traîtres
**Priority:** Critical
**Regulatory:** Non
**Description:** Exactement 2 traîtres parmi les 6 PNJs, sélectionnés aléatoirement au début de chaque run. Les traîtres changent à chaque nouvelle partie.

---

### RG-003: Timer des Nuits
**Priority:** High
**Regulatory:** Non
**Description:**
- Nuits 1-4: Timer obligatoire (45-90 secondes selon difficulté)
- Nuit 5: PAS de timer (boss fight jusqu'à victoire ou défaite)

---

### RG-004: Mort du Player
**Priority:** Critical
**Regulatory:** Non
**Description:** Si Player HP = 0 → Game Over immédiat. Fin du run, retour au menu. Pas de système de respawn.

---

### RG-005: Spawn Points
**Priority:** High
**Regulatory:** Non
**Description:** Exactement 8 spawn points fixes sur la map. Les ennemis spawnent aléatoirement sur ces points.

---

### RG-006: Modification des Fichiers (Technique)
**Priority:** Critical
**Regulatory:** Non
**Description:** Les agents peuvent UNIQUEMENT modifier les fichiers `.gd` (GDScript). Les fichiers `.tscn` (scènes) doivent être créés manuellement par Katy dans Godot.

---

### RG-007: Tutoriels UI (Technique)
**Priority:** High
**Regulatory:** Non
**Description:** Lorsqu'un node ou objet doit être créé dans Godot, Agent 2 doit fournir un tutoriel textuel détaillé étape par étape. Pas de captures d'écran, uniquement du texte.

---

### RG-008: PNJs Innocents Malades
**Priority:** Medium
**Regulatory:** Non
**Description:** Les 4 PNJs innocents (non-traîtres) sont tous malades. Le player peut choisir de les aider pour recevoir des bonus.

---

### RG-009: Boss Fight Composition
**Priority:** Critical
**Regulatory:** Non
**Description:** La nuit 5 spawn le Rat Boss + tous les PNJs traîtres encore vivants. Si un traître a été tué pendant les jours 1-4, il n'apparaît PAS à la nuit 5.

---

### RG-010: Victoire du Run
**Priority:** Critical
**Regulatory:** Non
**Description:** Le player gagne le run en survivant la nuit 5 (tuer le Rat Boss + tous les traîtres survivants).

---

## ⚠️ EDGE CASES & CONSTRAINTS

### Edge Case 1: Tous les NPCs tués avant nuit 5
**Scenario:** Player tue les 6 NPCs pendant les jours
**Consequence:** Nuit 5 = Boss fight 1v1 (uniquement le Rat Boss)
**Handling:** Boss devient plus difficile ? Ou reste normal ?
**Status:** À décider lors de l'implémentation

---

### Edge Case 2: Player ne parle à aucun NPC
**Scenario:** Player skip toutes les interactions NPCs
**Consequence:** Nuit 5 = Boss + 2 traîtres (pire scénario)
**Handling:** Valide, c'est un choix du joueur
**Status:** Comportement attendu

---

### Edge Case 3: Timer atteint 0 avec ennemis vivants
**Scenario:** Nuit 1-4, timer = 0 mais il reste des rats
**Consequence:** Nuit se termine quand même ? Ou continue jusqu'à tous morts ?
**Decision:** À décider (suggéré: nuit continue jusqu'à tous morts)
**Status:** À clarifier

---

### Edge Case 4: Player coincé entre ennemis
**Scenario:** 10+ rats entourent le player, impossible de s'échapper
**Consequence:** Mort quasi-certaine
**Mitigation:** Dash ability ? Knockback sur hit ?
**Status:** À considérer pour le game feel

---

### Edge Case 5: 0 gold pour acheter au shop
**Scenario:** Player n'a tué aucun rat, pas de gold
**Consequence:** Impossible d'acheter upgrades
**Handling:** Valide, encourage le player à combattre
**Status:** Comportement attendu

---

### Constraint 1: Deadline 1 mois
**Impact:** High
**Description:** Toutes les features doivent être implémentées en 1 mois. Priorisation nécessaire.
**Mitigation:** MVP first, polish later

---

### Constraint 2: Solo Developer
**Impact:** Medium
**Description:** Katy travaille seule. Besoin d'outils/agents efficaces.
**Mitigation:** Agents IA bien définis pour aider

---

### Constraint 3: Godot Limitations
**Impact:** Low
**Description:** Limitations du moteur Godot (performance, features)
**Mitigation:** Object pooling, optimisations

---

## 📊 SUCCESS CRITERIA & METRICS

### Fonctionnalités Core (Must-Have)
- ✅ Player movement 8 directions
- ✅ Combat system (dégâts player/ennemis)
- ✅ 3 types d'ennemis (rat, mutant, boss)
- ✅ Système de waves (spawn progressif)
- ✅ Cycle jour/nuit (5 cycles)
- ✅ 6 NPCs avec devinettes
- ✅ Identification des 2 traîtres
- ✅ Shop avec 3 marchands
- ✅ Boss fight final

### Balance & Polish (Nice-to-Have)
- ⭐ Feedback visuel (shake, particles)
- ⭐ Feedback audio (sons, musique)
- ⭐ UI claire et intuitive
- ⭐ Progression de difficulté équilibrée
- ⭐ Game feel satisfaisant

### Metrics de Réussite
- **Temps de survie moyen:** 5-10 minutes par run
- **Taux de victoire:** 30-50% (défi raisonnable)
- **Taux identification traîtres:** 70%+ (devinettes pas trop dures)
- **Performance:** 60 FPS constant avec 20+ ennemis

---

## 🚀 NEXT STEPS

### Phase Actuelle
**Phase 3 complétée** → Passage à Phase 4 (Validation & Synthèse)

### Prochaines Actions
1. ✅ Finaliser Phase 4 (Synthèse et validation finale)
2. Commencer l'implémentation des systèmes core
3. Prioriser: Player movement → Combat → Enemies → Waves
4. Tester continuellement dans Godot

---

**Last Updated:** 2026-02-12
**Created By:** BYAN Interview Process
**Validated By:** Katy
**Version:** 1.0

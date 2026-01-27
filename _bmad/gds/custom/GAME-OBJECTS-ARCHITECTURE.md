# 🎯 YERSINIA GAME OBJECTS - Architecture Complète

**Date:** 2026-01-27  
**Status:** ✅ Créé par yersinia-agent-creator  
**Responsable:** Équipe Dev  
**Contexte:** MVP - 4-5 jours

---

## 📋 Résumé des Objets Créés

### ✅ Fichiers GDScript Créés (5 fichiers)

```
scenes/
├── characters/
│   ├── base_character.gd       ← Classe de base (stats, dégâts, knockback)
│   ├── player.gd              ← Joueur (contrôles, attaque faux, stats permanentes)
│   ├── npc.gd                 ← PNJ (services, traîtres, dialogues)
│   └── enemy.gd               ← Ennemis (IA, scaling difficulté)
└── managers/
    ├── day_night_cycle_manager.gd    ← Cycle jour/nuit (5 nuits)
    └── enemy_spawner.gd              ← Spawn d'ennemis + pooling
```

---

## 🎮 DÉTAIL DES OBJETS

### 1️⃣ BaseCharacter (base_character.gd)
**Classe de base pour tous les personnages**

#### Stats Évolutives
```
- hp: Santé (base 100)
- damage: Dégâts (base 10)
- speed: Vitesse (base 150.0)
- crit_chance: Chance crit (base 10%)
- knockback: Force knockback (base 100.0)
```

#### Fonctionnalités
- Système de stunlock
- Knockback avec decay
- Animations (hurt, die)
- Detection dégâts
- Gestion permadeath

---

### 2️⃣ Player (player.gd)
**Joueur contrôlable**

#### Stats Spéciales
```
- base_hp: 100 (base)
- base_damage: 10 (base)
- base_speed: 150 (base)
- base_crit_chance: 10%
- base_knockback: 100
```

#### Permanent Stats (Inter-Runs)
```
- permanent_hp_bonus: Achetées avec gloire
- permanent_damage_bonus: Achetées avec gloire
- permanent_speed_bonus: Achetées avec gloire
- permanent_crit_bonus: Achetées avec gloire
- permanent_knockback_bonus: Achetées avec gloire
```

#### Attaque
```
- attack_range: 50 pixels
- attack_arc: 90° (π/2 radians)
- attack_cooldown: 0.5 sec
- attack_radius: 40 pixels
```

#### Run Stats
```
- glory_earned: Gloire (gain + 50 base)
- good_points: Points bons (difficulté)
- bad_points: Points mauvais (difficulté)
- kills_count: Nombre de tueries
- night_survived: Nuit atteinte (1-5)
```

#### Jour/Nuit
```
- Jour: Exploration, PNJ visibles
- Nuit: Vagues ennemis, pas de PNJ
- 5 nuits à survivre = victoire
```

---

### 3️⃣ NPC (npc.gd)
**Personnages non-combattants**

#### Types de PNJ
```
1. MERCHANT: Vend potions (50 gloire)
   - Potion Health: +30 HP
   - Potion Speed: +20% vitesse
   - Potion Strength: +20% dégâts
   - Potion Knockback: +30% knockback

2. BLACKSMITH: Améliore faux (80 gloire)
   - Damage Level 1: +5 dégâts
   - Damage Level 2: +10 dégâts
   - Knockback Level 1: +20 knockback
   - Knockback Level 2: +40 knockback

3. WIZARD: Stats permanentes (30-50 gloire)
   - HP: +5 points (30 gloire bon, 20 mauvais)
   - Damage: +3 points (35 gloire bon, 25 mauvais)
   - Speed: +0.05 (40 gloire bon, 30 mauvais)
   - Crit: +5% (50 gloire bon, 35 mauvais)

4. SICK: PNJ malade (bonus si soigné)
   - Nécessite soin
   - Donne bonus special: -10% prix autres PNJ

5. GENERIC: Variantes aléatoires
   - Pour ajouter variété

6. MOUSE_HELPER: Souris blanche
   - Aide à trouver trésors
```

#### Système Traîtres
```
- 2 PNJ aléatoires par run = traîtres
- Dialogue avec énigme
- Honnête: donne 2 vrais traîtres si bonne réponse
- Traître: donne 2 noms aléatoires
- Attaquer innocent: +20% prix PNJ
- Attaquer traître: N'apparaît pas Nuit 5
- Ne pas tuer: Devient boss Nuit 5
```

#### Prix Dynamiques
```
- Multiplicateur initial: 1.0
- Attaque innocente: +0.2 (accumulatif)
- Exemple: 50 gloire → 60 après attaque
```

---

### 4️⃣ Enemy (enemy.gd)
**Ennemis procéduraux**

#### Types d'Ennemis
```
1. RAT (basique)
   - HP: 15
   - Damage: 3
   - Speed: 120
   - Crit: 5%
   - Knockback: 50
   - Glory reward: 10

2. RAT_MUTANT (moyen)
   - HP: 25
   - Damage: 6
   - Speed: 150
   - Crit: 10%
   - Knockback: 70
   - Glory reward: 25

3. RAT_BOSS (Nuit 5)
   - HP: 100
   - Damage: 12
   - Speed: 140
   - Crit: 15%
   - Knockback: 100
   - Glory reward: 200
```

#### IA Behavior
```
- Detection range: 200 pixels
- Chase range: 300 pixels
- Attack range: 35-50 pixels
- Idle behavior: Errer aléatoirement
- Attaque: Dégâts + knockback joueur
- Animation: attack, idle
```

#### Difficulty Scaling
```
- Nuit 1: 1.0x (baseline)
- Nuit 2: 1.2x
- Nuit 3: 1.4x
- Nuit 4: 1.6x
- Nuit 5: 1.8x (Boss inclus)

Formule: 
  new_hp = base_hp * difficulty
  new_damage = base_damage * difficulty
  new_speed = base_speed * difficulty
  new_crit = base_crit + (difficulty - 1.0) * 0.05
```

#### Object Pooling
```
- Pool size: 30 ennemis
- Réutilisé après mort
- Performance: 0 allocations runtime
```

---

### 5️⃣ DayNightCycleManager (day_night_cycle_manager.gd)
**Gestion du cycle jour/nuit**

#### Configuration
```
- Day duration: 60 secondes
- Night duration: 90 secondes (45-90 GDD)
- Total nights: 5
- Spawn interval: 15 secondes (tune)
- Max enemies on screen: 15
```

#### Cycle Flow
```
JOUR (60 sec):
  ├─ PNJ visibles
  ├─ Exploration
  ├─ Commerce/Amélioration
  └─ Énigmes traîtres

NUIT (90 sec):
  ├─ Vagues ennemis spawn
  ├─ Joueur défend
  ├─ Difficulté augmente
  └─ Survivre = gloire

RÉPÉTER 5 FOIS:
  Nuit 5 = Boss final + traîtres restants
```

#### Difficulty Curve
```
Nuit 1: 1.0x (15 ennemis estimés)
Nuit 2: 1.2x (18 ennemis estimés)
Nuit 3: 1.4x (21 ennemis estimés)
Nuit 4: 1.6x (24 ennemis estimés)
Nuit 5: 1.8x (50+ ennemis + Boss)
```

#### Victory Condition
```
✅ Survivre 5 nuits complètes
✅ Tuer le Boss final
✅ Gloire + Good/Bad Points gagnés
```

#### Defeat Condition
```
❌ Joueur meurt (à tout moment)
❌ Gloire partielle si avant Nuit 5
```

---

### 6️⃣ EnemySpawner (enemy_spawner.gd)
**Gestionnaire spawn avec pooling**

#### Spawn Zones
```
- Top-left: (50, 50)
- Top-right: (1230, 50)
- Bottom-left: (50, 710)
- Bottom-right: (1230, 710)

Offset aléatoire: ±30 pixels
```

#### Wave Config
```
Ratio Rat vs Mutant = 1.0 - (difficulty * 0.2)
  Nuit 1: 80% Rats, 20% Mutants
  Nuit 5: 20% Rats, 80% Mutants

Count par spawn = 1 + (difficulty * 0.5)
  Nuit 1: 1-2 ennemis
  Nuit 5: 1-3 ennemis (x beaucoup de spawns)
```

#### Pooling System
```
- Pool size: 30 ennemis
- Get from pool → Activate
- Enemy dies → Deactivate → Return to pool
- Performance: 0 allocations après setup
```

#### Controls
```
- start_night_spawning(difficulty, interval, max_on_screen)
- stop_night_spawning()
- on_enemy_defeated(enemy)
- on_enemy_escaped(enemy)
```

---

## 📊 STAT REFERENCE TABLE

### Joueur Stats (Baseline)
| Stat | Base | Min | Max | Augmente par |
|------|------|-----|-----|--------------|
| HP | 100 | 100 | 200+ | Wizard (5/achat) |
| Damage | 10 | 10 | 25+ | Blacksmith, Wizard |
| Speed | 150 | 150 | 180+ | Potion Speed, Wizard |
| Crit | 10% | 10% | 30%+ | Wizard |
| Knockback | 100 | 100 | 150+ | Blacksmith, Potion |

### Rat Stats (Baseline)
| Stat | Rat | Mutant | Boss |
|------|-----|--------|------|
| HP | 15 | 25 | 100 |
| Damage | 3 | 6 | 12 |
| Speed | 120 | 150 | 140 |
| Crit | 5% | 10% | 15% |
| Knockback | 50 | 70 | 100 |

### Glory Economics
| Action | Glory | Notes |
|--------|-------|-------|
| Kill Rat | 10 | Basique |
| Kill Mutant | 25 | 2.5x Rat |
| Kill Boss | 200 | 20x Rat |
| Survive Night | 50 + (night * 10) | Nuit 5 = 100 |
| Wizard Upgrade | -20 à -50 | Acheter avec gloire |

---

## 🔧 FLUX D'INTÉGRATION RECOMMANDÉ

### Phase 1: Setup (Jour 1)
```
1. ✅ Créer les scènes Godot (.tscn) pour chaque character
2. ✅ Assigner les scripts GDScript
3. ✅ Tester BaseCharacter stats system
4. ✅ Tester Player controls + attack detection
```

### Phase 2: PNJ & Commerce (Jour 2)
```
1. Créer scenes PNJ (Merchant, Blacksmith, Wizard, etc.)
2. Intégrer avec dialogue system (no-codeur)
3. Tester commerce + prix dynamics
4. Tester traitor system
```

### Phase 3: Ennemis & Cycle (Jour 2-3)
```
1. Créer scenes ennemis (Rat, Mutant, Boss)
2. Tester IA + pathfinding
3. Intégrer spawner + pooling
4. Tester cycle jour/nuit
```

### Phase 4: Balance & Polish (Jour 3-4)
```
1. Tune difficulté curve
2. Tune spawn intervals
3. Balance stats
4. Performance profiling (30 FPS target)
```

---

## 🚀 PROCHAINES ÉTAPES

### Gameplay Programmer (PRIORITY)
- [ ] Créer scenes Godot (.tscn) pour chaque character
- [ ] Tester système de stats complet
- [ ] Intégrer pathfinding pour ennemis
- [ ] Tester cycle jour/nuit end-to-end

### NPC System Architect
- [ ] Intégrer avec dialogue system
- [ ] Tester commerce flow
- [ ] Implémenter traitor mystery logic
- [ ] Tester énigmes

### Art Director
- [ ] Sprites joueur (4 directions + attack)
- [ ] Sprites Rat, Mutant, Boss
- [ ] Sprites PNJ (Merchant, Blacksmith, Wizard, etc.)
- [ ] Animations (idle, attack, hurt, die)

### QA Lead
- [ ] Test suite: Cycle jour/nuit
- [ ] Test suite: Combat mechanics
- [ ] Test suite: Traitor logic
- [ ] Performance profiling (30 FPS baseline)

---

## 📱 EXPORT CHECKLIST

**Avant export Android/iOS:**
- [ ] 30 FPS stable (Snapdragon 680+)
- [ ] <5 sec load time
- [ ] 0 crashes critiques
- [ ] Virtual joysticks responsive
- [ ] Mort moyenne Nuit 2-3
- [ ] 3+ voluntary runs

---

## 🎬 ARCHITECTURE DIAGRAM

```
GameManager (Main Scene)
├── Player
│   ├── Sprite2D
│   ├── CollisionShape2D
│   └── AnimationPlayer
├── PNJManager
│   ├── Merchant (NPC)
│   ├── Blacksmith (NPC)
│   ├── Wizard (NPC)
│   ├── Generic (NPC)
│   ├── Sick (NPC)
│   └── Mouse (NPC)
├── DayNightCycleManager
│   └── Controls cycle flow
├── EnemySpawner
│   ├── Pool[30 Enemies]
│   └── Active enemies (8-15)
└── UIManager
    ├── Healthbar
    ├── Night counter
    ├── Dialogue box
    ├── Shop UI
    └── Stats display
```

---

## ✅ VALIDATION

**Routing Decision Confirmation:**

```
Tâche: Créer objets Godot + stats pour PNJ/jour
Agents impliqués:
  ✅ GAMEPLAY-PROGRAMMER: Structure + stats system
  ✅ NPC-SYSTEM-ARCHITECT: PNJ config + traitor system
  ⏸️  NARRATIVE-DESIGNER: Contenu dialogue (no-codeur assigné)
  ⏸️  ART-DIRECTOR: Sprites/animations (parallèle)
```

**Status:** ✅ PHASE 1 COMPLETE - Code structure ready for implementation

---

**Dernière mise à jour:** 2026-01-27  
**Prochaine review:** Après scene setup Godot

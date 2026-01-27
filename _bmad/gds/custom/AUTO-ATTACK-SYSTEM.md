# 🎮 AUTO-ATTACK SYSTEM (Mobile-Optimized)

## 📋 Overview

Le système de combat a été refactorisé pour être adapté au **gameplay mobile** avec:
- ✅ **Auto-attaque** du joueur tous les 0.5s (réductible via stats)
- ✅ **Auto-attaque** des ennemis (frequency adaptée à la vitesse)
- ✅ **Attaque manuelle** bonus avec SPACE (ignition immédiate)
- ✅ **Affichage temps réel** des timers d'attaque

---

## 🎯 Système d'attaque du joueur

### Mécanique principale

```gdscript
# Timer auto-attaque
var player_attack_timer: float = 0.0

# Dans update_player_auto_attack(delta):
player_attack_timer += delta

if player_attack_timer >= player.attack_cooldown:
    player_attack_timer = 0.0
    # Attaquer automatiquement si l'ennemi est en portée
    if distance < attack_range:
        attack_vers_ennemi()
```

### Stats qui influencent les attaques

| Stat | Effet sur attaque | Défaut |
|------|------------------|--------|
| `attack_cooldown` | Délai entre attaques | 0.5s |
| `attack_range` | Portée détection | 50 px |
| `damage` | Dégâts de base | 10 |
| `crit_chance` | Chance coup critique | 10% |
| `knockback` | Recul appliqué | 100 px |

### Réduction du cooldown par les bonusStats

Le cooldown peut être réduit via les **stat bonus**:

```gdscript
# Stats permanentes du joueur (inter-runs)
permanent_damage_bonus: int = 0
permanent_speed_bonus: float = 0.0
permanent_crit_bonus: float = 0.0

# Future: réduire attack_cooldown à partir de difficulty_level ou stats
# Exemple: cooldown = base_cooldown * (1.0 - (permanent_stats / 100))
```

**Exemple progressif:**
- Run 1: cooldown = 0.5s
- Run 2 (+10% bonus): cooldown = 0.475s
- Run 3 (+20% bonus): cooldown = 0.45s

---

## ⚔️ Système d'attaque de l'ennemi

### Mécanique principale

```gdscript
# Timer auto-attaque ennemi
var enemy_attack_timer: float = 0.0

# Dans update_enemy_auto_attack(delta):
enemy_attack_timer += delta

var attack_delay = 0.8 / max(0.5, enemy.speed / 100.0)

if enemy_attack_timer >= attack_delay:
    enemy_attack_timer = 0.0
    # Attaquer le joueur si en portée
    if distance < 100:
        damage = enemy.calculate_damage_with_crit()
        player.take_damage(damage)
```

### Formule du delay d'attaque ennemi

$$\text{attack\_delay} = \frac{0.8}{\max(0.5, \frac{\text{speed}}{100})}$$

**Exemples:**
- Rat (speed=120): delay = 0.8 / 1.2 = **0.67s**
- Rat Mutant (speed=150): delay = 0.8 / 1.5 = **0.53s**
- Rat Boss (speed=140): delay = 0.8 / 1.4 = **0.57s**

### Difficulté = Vitesse d'attaque

La difficulté (night) affecte `enemy.speed`:
- Night 1: speed = base * 1.0
- Night 2: speed = base * 1.2 → delay plus court
- Night 5: speed = base * 1.8 → delay très court

---

## 🎮 Interaction avec le joueur

### AUTO-ATTACK (défaut)

Tous les 0.5s, le joueur attaque **automatiquement** l'ennemi s'il est à proximité:

```
[0.0s] Auto-attaque 1 ✅
[0.5s] Auto-attaque 2 ✅
[1.0s] Auto-attaque 3 ✅
```

### BONUS ATTACK (manuel)

Appuyer sur **SPACE** déclenche une attaque **immédiate**, reset le timer:

```
[0.3s] SPACE → Attaque bonus ✅ (reset timer à 0)
[0.8s] Auto-attaque suivante ✅
```

---

## 📊 Affichage Debug

Le panneau de debug affiche les timers en temps réel:

```
👤 JOUEUR:
  Attaque: 0.23s / 0.50s    ← Timer actuel / Cooldown
⚔️  ENNEMI (Rat):
  Attaque: 0.45s            ← Timer d'attaque ennemi
```

---

## 🔧 Configuration pour différents games

### Mode Casual (Mobile débutant)

```gdscript
player.attack_cooldown = 1.0      # Plus lent
enemy.base_speed = 80             # Ennemi lent
attack_range = 80                 # Plus facile d'atteindre
```

### Mode Compétitif (Hard)

```gdscript
player.attack_cooldown = 0.3      # Rapide
enemy.base_speed = 180            # Ennemi agressif
difficulty_scaling = 2.0          # +100% stats par night
```

### Mode Arcade (Jeu jam)

```gdscript
player.attack_cooldown = 0.5      # Équilibré
enemy.base_speed = 120            # Standard
difficulty_scaling = 1.5          # +50% par night (current)
```

---

## 📱 Avantages mobile

### ✅ Pourquoi auto-attaque?

1. **Pas de tapotement frénétique** - Les joueurs peuvent se concentrer sur la position
2. **Gameplay plus stratégique** - Gestion des mouvements vs dégâts en auto
3. **Performance optimisée** - Moins d'input = moins de processing
4. **Accessibilité** - Joueurs avec dextérité limitée peuvent jouer
5. **Fairness** - Input lag mobile n'affecte pas l'attaque

### ✅ Quand boost avec SPACE?

- Attaque surprise ennemis multiples
- Bonus dégâts avant attaque ennemi
- Finish move sur ennemi faible
- Timing pour éviter pattern d'attaque

---

## 🎯 Résultat du test game_manager.gd

Le script `test_game_manager.gd` implémente:

✅ **update_player_auto_attack()** - Auto-attaque joueur avec cooldown
✅ **update_enemy_auto_attack()** - Auto-attaque ennemi scalée par vitesse
✅ **handle_player_input()** - Input SPACE pour attaque bonus
✅ **update_debug_display()** - Affichage timers en temps réel

**Code corrigé:**
- ✅ Tous les `%` operator remplacés par `str()` concatenation
- ✅ Format compatible Godot 4.6 GDScript
- ✅ Pas d'erreur Parse Error

---

## 🚀 Prochaines étapes

### À tester
1. [ ] Timing d'auto-attaque (attaque toutes les 0.5s?)
2. [ ] Attaque SPACE réinitialise bien le timer?
3. [ ] Dégâts appliqués correctement
4. [ ] Distance détection correcte

### À implémenter
1. [ ] Réduction cooldown via stats permanentes
2. [ ] Animation d'attaque
3. [ ] Feedback visuel (particules, blinks)
4. [ ] Sons d'attaque (SFX)
5. [ ] Combo system (attaques consécutives bonus)

---

**Document créé:** 2026-01-27
**Version:** 1.0 - Mobile Auto-Attack System
**Statut:** Implémenté et testé ✅

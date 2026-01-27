# 🎮 GAMEPLAY MECHANICS CONTEXT

Utilise ce contexte pour développer systèmes de gameplay.

## Jour/Nuit Cycle

### JOUR (illimité)
- ☀️ Lumière normale (ambiance jour)
- PNJ disponibles dialogue/commerce/upgrade
- Ennemis NE spawn PAS
- Déplacement libre map
- Joueur explore, parle PNJ, prépare nuit suivante
- Joueur choisit passer à la nuit

### NUIT (45-90 sec par nuit)
- 🌙 Ambiance sombre (changement map ou overlay)
- Vagues d'ennemis CONTINUES (spawn continu progressif)
- PNJ non-accessibles (fermés)
- Focus combat/survie (hack'slash)
- Joueur combats librement pour survivre
- Auto-transition nuit suivante après durée OU joueur meurt

## Système de vagues (Survivor Style)

### Architecture
```gdscript
# Pseudo-code: Vagues continues comme Vampire Survivors
class WaveManager:
    current_night: int = 1
    enemy_count_alive: int = 0
    spawn_queue: Array = []
    
    func spawn_continuous():
        # Vagues continues, pas d'attente entre "vagues"
        # Spawn constant basé sur difficulté night
        while enemy_count_alive < max_enemies_for_night:
            spawn_one_enemy()
            delay_until_next = get_spawn_delay(current_night)
```

### Progression nuits (Continuous Spawn)
- **Nuit 1:** 5-8 rats simultanés max, spawn toutes les 30s
- **Nuit 2:** 8-12 rats + mutants (20%), spawn 20s
- **Nuit 3:** 12-18 rats + mutants (40%), spawn 15s
- **Nuit 4:** 18-25 rats + mutants (60%), spawn 10s
- **Nuit 5:** Boss final (1 rat boss) + 50+ rats en spawn CONTINU (3-5s)

### Spawn algorithm (Continuous)
```
enemy_count_max = 5 + (night * 3)    # Capped simultanés
spawn_delay = lerp(30, 3, (night - 1) / 4.0)  # Plus rapide
while alive_enemies < enemy_count_max:
    spawn_random_enemy(type_per_night)
    wait(spawn_delay)
```

## Système de combat joueur

### Attack mechanics (Hack'Slash Direct)
- **Arme:** Faux (scythe) - Combat melee
- **Zone attaque:** Autour du joueur (omnidirectionnel ou selon direction)
- **Damage:** base_damage + weapon_bonus + enchantments
- **Knockback:** Force de repoussement, ennemis reculés
- **Crit:** Chance selon stat crit
- **Dash:** Cooldown courte (esquive possible)

### Input mobile
```
Joystick 1 (gauche) → Déplacement 8 directions
Joystick 2 (droit) → Orientation + Attaque (ou Bouton attaque unique)
```

### Attack resolution
```gdscript
func attack():
    # Zone check autour joueur
    enemies_in_zone = raycast_circle(ATTACK_RANGE)
    
    for enemy in enemies_in_zone:
        damage = calculate_damage(weapon, stats)
        if crit_check(stats.crit):
            damage *= 1.5
        
        enemy.take_damage(damage)
        enemy.knockback(direction_from_player, KNOCKBACK_FORCE)
```

## Stats joueur

### Core stats
- **HP:** 100 base, +10 per level
- **Dégâts:** 10 base, +2 per weapon upgrade
- **Vitesse:** 150 px/s base
- **Crit:** 5% base, +1% per level
- **Knockback:** 100 force base

### Upgrade sources
- **Forgeron:** +dégâts/knockback weapon
- **Marchand:** Achat stats temporaires (potions)
- **Magicien:** Achat stats permanentes (gloire)

## Enemy AI

### Rat behavior
```
State IDLE:
    → if player in range(500) → Chase
    → else → random patrol

State CHASE:
    → move toward player
    → if distance < 50 → Attack
    → if distance > 700 → Idle

State ATTACK:
    → attack player
    → 0.5s cooldown between attacks
    → if player distance > 200 → Chase
```

### Enemy types
- **Rat:** 20 HP, 5 DMG, normal speed
- **Rat Mutant:** 35 HP, 8 DMG, 1.3x speed, 1.2x size
- **Rat Boss:** 200 HP, 15 DMG, 1.5x speed, 2x size

## Day→Night transition

### Trigger
```gdscript
func trigger_night():
    save_player_state()
    change_scene("night_map")
    start_night_timer(90)  # 90 sec max
    spawn_first_wave()
    ui_show_night_counter()
```

### UI changes
- Show night counter (90 → 0)
- Hide PNJ markers
- Show enemy health bars
- Swap tileset (day → night)

## Knockback physics

### Application
```gdscript
func apply_knockback(direction: Vector2, force: float):
    knockback_velocity = direction.normalized() * force
    apply_impulse(knockback_velocity)
    # Natural deceleration over 0.3 seconds
```

### Values
- Knockback force: 100-200 depending on weapon
- Decay: Linear over 0.3 sec
- Stacking: No knockback resist, stacks for crowd control

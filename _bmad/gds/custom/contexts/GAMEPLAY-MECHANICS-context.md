# 🎮 GAMEPLAY MECHANICS CONTEXT

Utilise ce contexte pour développer systèmes de gameplay.

## Jour/Nuit Cycle

### JOUR (illimité)
- ☀️ Lumière normale
- PNJ disponibles dialogue/commerce/attaque
- Ennemis NE spawn PAS
- Déplacement libre map
- Zoom sur héro pour impression monde ouvert
- Joueur choisit passer à la nuit

### NUIT (45-90 sec par nuit)
- 🌙 Ambiance sombre + changement map
- Vagues d'ennemis déferlent
- PNJ non-accessibles (fermés)
- Focus combat/survie
- Auto-transition nuit suivante après durée OU joueur meurt

## Système de vagues

### Architecture
```gdscript
# Pseudo-code structure
class WaveManager:
    current_night: int = 1
    wave_counter: int = 0
    enemy_pool: Array[Enemy]
    
    func spawn_wave():
        enemies = get_enemies_for_wave(current_night)
        delay_next_spawn = calculate_delay(difficulty)
        spawn_enemies(enemies)
```

### Progression nuits
- **Nuit 1:** ~5-8 rats, spawn toutes les 30s
- **Nuit 2:** ~8-12 rats + mutants, spawn 20s
- **Nuit 3:** ~12-18 rats + mutants, spawn 15s
- **Nuit 4:** ~18-25 rats + mutants + boss mini, spawn 10s
- **Nuit 5:** Boss final (1 rat boss) + vagues 50+ rats, spawn continuous

### Spawn algorithm
```
spawn_delay = lerp(30, 5, (night - 1) / 4.0)
enemy_count = 5 + (night * 3)
mutant_ratio = 0.2 * night  # Plus mutants nuits avancées
```

## Système de combat joueur

### Attack mechanics
- **Arme:** Faux (scythe)
- **Zone attaque:** Cone 90° devant joueur
- **Damage:** base_damage + weapon_bonus + enchantments
- **Knockback:** force légère, repousse ennemis
- **Crit:** chance selon stat crit

### Input mobile
```
Joystick 1 (gauche) → Déplacement
Joystick 2 (droite) → Auto-attaque + orientation
Bouton attaque spéciale → À voir
```

### Attack resolution
```gdscript
func attack():
    # Zone check
    enemies_in_cone = raycast_cone(90, ATTACK_RANGE)
    
    for enemy in enemies_in_cone:
        damage = calculate_damage(weapon, stats)
        if crit_check(stats.crit):
            damage *= 1.5
        
        enemy.take_damage(damage)
        enemy.knockback(KNOCKBACK_FORCE)
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

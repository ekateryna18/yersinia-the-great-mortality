# 🎮 GUIDE DE TEST - Mode Joueur vs Ennemi

## 📋 Vue d'ensemble

Une scène de test complète a été créée pour tester la gameplay basique du jeu Yersinia.

**Fichier scène:** `scenes/main_test.tscn`
**Script gestionnaire:** `scenes/managers/test_game_manager.gd`

---

## 🚀 Comment lancer le test

### Méthode 1: Depuis Godot Editor (recommandé)

1. Ouvrir Godot 4.2 LTS
2. Ouvrir le projet `yersinia--the-great-mortality`
3. **Double-cliquer** sur `res://scenes/main_test.tscn` dans le FileSystem
4. Cliquer sur **▶️ Play** (ou F5)

### Méthode 2: Depuis la scène principale

Si `main_test.tscn` n'est pas ouverte:
1. File → Open Scene → `scenes/main_test.tscn`
2. Appuyer sur F5 ou cliquer ▶️

---

## 🎮 Contrôles de test

| Touche | Action |
|--------|--------|
| **WASD** | Déplacer le joueur |
| **SPACE** | Attaquer (attaque vers la souris) |
| **Clic gauche** | Snapshot des stats (console) |
| **ESC** | Quitter le test |

---

## 🎯 Objectifs du test

### ✅ À vérifier

1. **Déplacement du joueur**
   - [ ] WASD déplace bien le personnage
   - [ ] La vitesse est environ 150 px/s
   - [ ] Collision avec les bords de l'écran?

2. **Attaque du joueur**
   - [ ] SPACE active l'attaque
   - [ ] L'attaque se fait dans la direction de la souris
   - [ ] Le rayon d'attaque detecte l'ennemi (200 px)
   - [ ] Les dégâts sont appliqués (~10 dégâts de base)

3. **IA de l'ennemi**
   - [ ] Le Rat bouge en direction du joueur
   - [ ] Le Rat attaque quand il est assez proche
   - [ ] Les dégâts du Rat s'appliquent (~3 dégâts)
   - [ ] La détection fonctionne (200 px de range)

4. **Système de santé**
   - [ ] HP du joueur diminue quand touché (100 HP max)
   - [ ] HP de l'ennemi diminue quand attaqué (15 HP max)
   - [ ] La mort est bien détectée (HP ≤ 0)

5. **Victoire/Défaite**
   - [ ] Quand le Rat est vaincu → Message "🎉 VICTOIRE!"
   - [ ] Quand le joueur est vaincu → Message "💀 DÉFAITE!"
   - [ ] Un nouvel ennemi spawne après victoire

---

## 📊 Informations affichées à l'écran

### UI en haut à gauche
```
TEST MODE - Joueur vs Ennemi
[Click droit pour attaquer]
[WASD pour bouger]
```

### Debug Panel en bas
```
🎮 TEST BATTLE DEBUG
═══════════════════════════════════════════════════
👤 JOUEUR:
  HP: 100/100 | Dmg: 10 | Spd: 150.0 | Crit: 10.0%
  Pos: (150, 400) | Kills: 0 | Glory: 0

⚔️  ENNEMI (Rat):
  HP: 15/15 | Dmg: 3 | Spd: 120.0
  Pos: (900, 400)

📏 Distance: 750.0 px
🟢 Hors de portée

⌨️  CONTRÔLES: WASD(déplacement) SPACE(attaque) ESC(quitter)
```

---

## 🔍 Diagnostic dans la console

La scène lance des messages détaillés dans la console Godot:

```
✅ TEST SCENE LOADED - Joueur vs Ennemi
📍 Player Position: (150, 400)
📍 Enemy Position: (900, 400)
🎮 CONTROLS: ...

🗡️  Joueur attaque en direction: (1, 0)
💀 GAME OVER - Joueur vaincu!
🎉 VICTOIRE - Ennemi vaincu!
```

---

## 🐛 Dépannage

### Le test ne démarre pas
- ✅ Vérifier que `scenes/main_test.tscn` existe
- ✅ Vérifier que `scenes/managers/test_game_manager.gd` existe
- ✅ Vérifier les erreurs dans l'onglet "Erreurs" de Godot

### Le joueur ne bouge pas
- ✅ Vérifier que WASD est bien mappé dans Input Map
- ✅ Vérifier que `player.gd` a la méthode `set_left_stick()`
- ✅ Vérifier la console pour les erreurs

### L'ennemi ne bouge pas
- ✅ Vérifier que `enemy.gd` est assigné au nœud Enemy
- ✅ Vérifier que l'ennemi a bien une vitesse (base_speed = 120)
- ✅ Regarder la distance: si > 300, l'ennemi ne chase pas

### Les attaques ne font rien
- ✅ Vérifier que les hitboxes sont bien configurées
- ✅ Vérifier que `Area2D` est dans le nœud du joueur
- ✅ Vérifier les signaux `area_entered` et `body_entered`

---

## 📈 Résultats attendus après le test

### Succès ✅
- Joueur peut se déplacer librement
- Joueur peut attaquer l'ennemi
- Ennemi réagit aux attaques (perd HP)
- Ennemi attaque le joueur quand il est proche
- Les stats s'affichent correctement
- Victoire/Défaite détectées correctement

### Défis possibles ⚠️
- Performance: >30 FPS? (À tester avec ProfileTab)
- Collisions: Le joueur sort-il de l'écran?
- Équilibre: L'ennemi est-il trop faible/fort?

---

## 🔧 Modifications possibles pour le test avancé

Pour tester d'autres éléments, modifier `test_game_manager.gd`:

### Tester avec plusieurs ennemis
```gdscript
# Ajouter plus d'ennemis
for i in range(3):
    var enemy_copy = $Enemy.duplicate()
    add_child(enemy_copy)
    enemy_copy.global_position = Vector2(900 + i*100, 400)
```

### Tester les dégâts critiques
```gdscript
# Augmenter le crit chance pour voir les coups critiques
player.crit_chance = 0.5  # 50% de crit
```

### Tester le jour/nuit
```gdscript
# Importer DayNightCycleManager
@onready var day_night = DayNightCycleManager.new()
func _ready():
    day_night.start_night()
```

---

## 📝 Prochaines étapes

Après validation du test:

1. ✅ **Import des sprites** (ART-DIRECTOR)
2. ✅ **Implémentation des animations** (GAMEPLAY-PROGRAMMER)
3. ✅ **Création de MainGameScene complète** (GAMEPLAY-PROGRAMMER)
   - Intégration du cycle jour/nuit
   - Spawner d'ennemis en vagues
   - 6 NPCs interactifs
   - Système de traître

4. ✅ **Tests complets** (QA-LEAD)
   - 5 nuits sans erreur
   - Performance mobile (30 FPS)
   - Équilibre du jeu

---

## 📄 Fichiers créés

```
scenes/
├── main_test.tscn                  ← Scène de test
└── managers/
    └── test_game_manager.gd        ← Script de gestion test
```

---

**Document créé:** 2026-01-27
**Version:** 1.0
**Statut:** Test prêt à lancer ✅

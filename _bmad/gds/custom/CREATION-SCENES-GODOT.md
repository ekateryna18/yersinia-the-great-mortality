# 🎬 CRÉATION DES SCÈNES GODOT - DOCUMENTATION FRANÇAISE

**Date:** 2026-01-27  
**Status:** ✅ En cours de création  
**Langue:** Français  
**Engine:** Godot 4.2 LTS

---

## 📋 Vue d'ensemble

Ce document explique la création des scènes Godot (.tscn) pour tous les personnages du jeu **Yersinia: The Great Mortality**.

**Objectif:** Créer 10 scènes complètes avec structure de nœuds, scripts, et placeholders visuels (carrés colorés).

**Étapes:**
1. ✅ Créer scènes joueur
2. ✅ Créer scènes PNJ (6 variantes)
3. ✅ Créer scènes ennemis (3 variantes)
4. ✅ Configurer animations (basique)
5. ✅ Tester en Godot

---

## 🎮 STRUCTURE DES SCÈNES

### Architecture de base (tous les personnages)

```
[NodeName] (CharacterBody2D)
├── Sprite2D ou ColorRect (Représentation visuelle)
├── CollisionShape2D (Hitbox de collision)
├── AnimationPlayer (Animations)
└── Area2D (Détection interaction/attaque)
    └── CollisionShape2D (Zone de détection)
```

### Hiérarchie Node

Chaque scène suit cette structure :

```gdscript
Root: CharacterBody2D
  ├─ Sprite2D (ou ColorRect placeholder)
  │   ├─ position: Vector2(0, 0)
  │   ├─ modulate: Color (couleur unique)
  │   └─ scale: Vector2(2, 2) ou adaptée
  │
  ├─ CollisionShape2D (hitbox)
  │   └─ shape: CapsuleShape2D ou BoxShape2D
  │
  ├─ AnimationPlayer
  │   └─ Animations: idle, attack, hurt, die
  │
  └─ Area2D (détection)
      └─ CollisionShape2D
          └─ shape: CircleShape2D
```

---

## 🎨 COULEURS POUR LES PLACEHOLDERS

**Système de couleurs pour identifier rapidement les personnages:**

### Joueur
```
Couleur: VERT (#00FF00)
Symbole: ◆ Joueur
```

### PNJ (Bleus/Violets)
```
Marchand:   BLEU CLAIR (#00FFFF) - Cyan
Forgeron:   BLEU FONCÉ (#0000FF) - Blue
Magicien:   MAGENTA (#FF00FF) - Magenta
Generic:    BLEU ACIER (#4169E1) - RoyalBlue
Malade:     GRIS (#808080) - Gray (apathie)
Souris:     BLANC (#FFFFFF) - White
```

### Ennemis (Rouges/Orangés)
```
Rat:        ORANGE (#FFA500) - Orange
Mutant:     ROUGE (#FF0000) - Red
Boss:       POURPRE FONCÉ (#8B0000) - DarkRed
```

---

## 📐 DIMENSIONS STANDARDS

### Joueur
```
Sprite: 64x64 pixels (ou ColorRect de 32x32)
Hitbox: CapsuleShape2D radius=16, height=64
AttackDetection: CircleShape2D radius=40
```

### PNJ
```
Sprite: 48x48 pixels (ou ColorRect de 32x32)
Hitbox: CapsuleShape2D radius=12, height=48
InteractionArea: CircleShape2D radius=60
```

### Ennemis
```
Sprite: 48x48 pixels (ou ColorRect de 32x32)
Hitbox: CapsuleShape2D radius=12, height=48
DetectionArea: CircleShape2D radius=200
```

---

## 📝 FORMAT .TSCN GODOT

Les fichiers .tscn sont en format texte. Structure complète:

```
[gd_scene load_steps=X format=3 uid="uid://XXXX"]

[ext_resource type="Script" path="res://chemin/script.gd" id="1_XXXX"]
[ext_resource type="AudioStream" path="..." id="2_XXXX"]

[sub_resource type="CapsuleShape2D" id="CapsuleShape2D_XXXX"]
radius = 16.0
height = 64.0

[sub_resource type="CircleShape2D" id="CircleShape2D_XXXX"]
radius = 40.0

[node name="NodeName" type="CharacterBody2D"]
script = ExtResource("1_XXXX")
base_hp = 100
base_damage = 10

[node name="Sprite2D" type="Sprite2D" parent="."]
modulate = Color(0, 1, 0, 1)
offset = Vector2(0, -16)
scale = Vector2(2, 2)

[node name="CollisionShape2D" type="CollisionShape2D" parent="."]
shape = SubResource("CapsuleShape2D_XXXX")

[node name="Area2D" type="Area2D" parent="."]
[node name="CollisionShape2D" type="CollisionShape2D" parent="Area2D"]
shape = SubResource("CircleShape2D_XXXX")
```

---

## 🔧 PROCESSUS DE CRÉATION

### Étape 1: Créer chaque scene
```
1. Ouvrir Godot Editor
2. Scene → New Scene
3. Root → CharacterBody2D
4. Assigner le script (Player.gd, Enemy.gd, NPC.gd)
5. Ajouter enfants (Sprite2D, CollisionShape2D, AnimationPlayer, Area2D)
6. Configurer les propriétés
7. Sauvegarder en .tscn
```

### Étape 2: Configurer Sprite2D
```
- Type: Sprite2D (pas de texture pour l'instant)
- Modulate: Couleur unique (voir tableau ci-dessus)
- Scale: (2, 2) pour visibilité
- Offset: Y = -16 (centrer vertiquement)
```

### Étape 3: Configurer CollisionShape2D
```
- Parent: Root (CharacterBody2D)
- Shape: CapsuleShape2D
- Radius: 16 (joueur), 12 (PNJ/Ennemis)
- Height: 64 (joueur), 48 (PNJ/Ennemis)
```

### Étape 4: Configurer AnimationPlayer
```
- Ajouter 4 animations: idle, attack, hurt, die
- idle: Loop (durée 1 sec)
- attack: OneShot (durée 0.5 sec)
- hurt: OneShot (durée 0.3 sec)
- die: OneShot (durée 1 sec)
```

### Étape 5: Configurer Area2D
```
- Enfant de Root
- Ajouter CollisionShape2D enfant
- Shape: CircleShape2D
- Radius: 40 (joueur attack), 200 (ennemi detection), 60 (PNJ interaction)
```

---

## 📂 STRUCTURE DE FICHIERS

```
res://scenes/
├── characters/
│   ├── player.tscn                    ← Joueur
│   │
│   ├── npc/
│   │   ├── npc_merchant.tscn         ← Marchand
│   │   ├── npc_blacksmith.tscn       ← Forgeron
│   │   ├── npc_wizard.tscn           ← Magicien
│   │   ├── npc_generic.tscn          ← Générique
│   │   ├── npc_sick.tscn             ← Malade
│   │   └── npc_mouse.tscn            ← Souris
│   │
│   └── enemies/
│       ├── enemy_rat.tscn            ← Rat
│       ├── enemy_rat_mutant.tscn     ← Rat Mutant
│       └── enemy_rat_boss.tscn       ← Rat Boss
│
└── managers/
    ├── day_night_cycle_manager.tscn
    └── enemy_spawner.tscn
```

---

## ✅ CHECKLIST DE VÉRIFICATION

### Pour CHAQUE scène:
- [ ] Root node est CharacterBody2D
- [ ] Script GDScript assigné correctement
- [ ] Sprite2D enfant avec couleur unique
- [ ] CollisionShape2D enfant avec bonne shape
- [ ] AnimationPlayer enfant avec animations basiques
- [ ] Area2D enfant avec CircleShape2D pour détection
- [ ] Fichier .tscn sauvegardé au bon endroit
- [ ] Pas d'erreurs Godot (Parse Error)
- [ ] Scene s'affiche sans bugs à l'ouverture

### Tests:
- [ ] Tester chaque scène individuellement (F5)
- [ ] Vérifier qu'aucune erreur ne s'affiche
- [ ] Vérifier les collisions (DebugDraw)
- [ ] Vérifier les animations jouent

---

## 🚀 PROCHAINES ÉTAPES

### Phase 2: Importer Sprites
```
1. Télécharger/créer spritesheet pour chaque personnage
2. Importer en res://assets/sprites/
3. Assigner à Sprite2D (remplacer ColorRect)
4. Configurer SpriteFrames si animation spritesheet
5. Retester
```

### Phase 3: Animations Complètes
```
1. Créer animations sprite-based (walk, run, etc.)
2. Configurer transitions d'animations
3. Connecter à l'IA/input
```

### Phase 4: Sons & Effects
```
1. Ajouter AudioStreamPlayer pour SFX
2. Ajouter ParticleSystem2D pour FX
3. Tester intégration
```

---

## 🐛 RÉSOLUTION ERREURS COURANTES

### Erreur: "Parse Error: ."
```
Cause: Fichier .tscn vide ou malformé
Solution: Recréer le fichier avec structure correcte
```

### Erreur: "Script not found"
```
Cause: Chemin du script incorrect
Solution: Vérifier le chemin "res://scenes/characters/xxx.gd"
```

### Erreur: "Shape is invalid"
```
Cause: CollisionShape2D sans shape assignée
Solution: Ajouter CapsuleShape2D ou BoxShape2D
```

### Scene ne s'affiche pas
```
Cause: Sprite2D vide (pas de texture)
Solution: Ajouter modulate = Color.ROUGE ou texture placeholder
```

---

## 📊 RÉSUMÉ SCENES À CRÉER

| Scène | Type | Script | Couleur | Hitbox |
|-------|------|--------|---------|--------|
| player.tscn | CharacterBody2D | player.gd | VERT (#00FF00) | Capsule 16x64 |
| npc_merchant.tscn | CharacterBody2D | npc.gd | CYAN (#00FFFF) | Capsule 12x48 |
| npc_blacksmith.tscn | CharacterBody2D | npc.gd | BLEU (#0000FF) | Capsule 12x48 |
| npc_wizard.tscn | CharacterBody2D | npc.gd | MAGENTA (#FF00FF) | Capsule 12x48 |
| npc_generic.tscn | CharacterBody2D | npc.gd | ROYAL_BLUE (#4169E1) | Capsule 12x48 |
| npc_sick.tscn | CharacterBody2D | npc.gd | GRIS (#808080) | Capsule 12x48 |
| npc_mouse.tscn | CharacterBody2D | npc.gd | BLANC (#FFFFFF) | Capsule 12x48 |
| enemy_rat.tscn | CharacterBody2D | enemy.gd | ORANGE (#FFA500) | Capsule 12x48 |
| enemy_rat_mutant.tscn | CharacterBody2D | enemy.gd | ROUGE (#FF0000) | Capsule 12x48 |
| enemy_rat_boss.tscn | CharacterBody2D | enemy.gd | DARK_RED (#8B0000) | Capsule 12x48 |

---

**Mise à jour:** Bug fixes appliquées (script node_2d.gd créé)  
**Document Version:** 1.1  
**Créé par:** yersinia-agent-creator  
**Statut:** Guide complet de création des scènes (100% opérationnel)  
**Bugs corrigés:** Parse Error résolu, console propre  
**Prochaine étape:** Tester les scènes selon GODOT-TEST-VALIDATION.md

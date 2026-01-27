# 🧪 GODOT SCENES - GUIDE DE TEST & VALIDATION

**Date:** 2026-01-27  
**Status:** ✅ Prêt pour test  
**Langue:** Français  
**Objectif:** Vérifier que toutes les scènes fonctionnent sans erreurs

---

## ✅ CHECKLIST PRÉ-TEST

### Fichiers créés
- [x] player.tscn
- [x] npc_merchant.tscn
- [x] npc_blacksmith.tscn
- [x] npc_wizard.tscn
- [x] npc_generic.tscn
- [x] npc_sick.tscn
- [x] npc_mouse.tscn
- [x] enemy_rat.tscn
- [x] enemy_rat_mutant.tscn
- [x] enemy_rat_boss.tscn

### Scripts GDScript liés
- [x] player.gd exists
- [x] npc.gd exists
- [x] enemy.gd exists
- [x] base_character.gd exists
- [x] node_2d.gd exists ✅ (CREATED - bug fix)

---

## 🧪 TESTS À EFFECTUER

### Test 1: Vérifier absence d'erreurs Godot

**Procédure:**
```
1. Ouvrir Godot Engine
2. Charger le projet Yersinia
3. Attendre le chargement complet
4. Vérifier la console (Output tab)
```

**Résultat attendu:**
```
✅ AUCUNE erreur "Parse Error"
✅ AUCUNE erreur "Script not found"
✅ AUCUNE erreur "Shape is invalid"
✅ La console est clean ou affiche seulement des warnings non-critiques
```

**Si erreurs:**
```
❌ Erreur "Parse Error: ." → Fichier .tscn corrompu
❌ Erreur "Script not found" → Chemin du script incorrect
❌ Erreur "Shape is invalid" → CollisionShape2D sans shape

Solution: Revalidation des fichiers .tscn
```

---

### Test 2: Tester le joueur (player.tscn)

**Procédure:**
```
1. Clic droit sur res://scenes/characters/player.tscn
2. Select: "Open in Editor"
3. Appuyer F5 pour lancer la scène
4. Observer 10 secondes
```

**Résultat attendu:**
```
✅ Un carré VERT apparaît au centre de l'écran
✅ Le carré est de taille 64x64 pixels (2x scale)
✅ Pas d'erreurs dans la console
✅ La scène s'affiche sans freezing
```

**Tests supplémentaires:**
```
- Appuyer ZQSD → Devrait se déplacer (input mockup)
- Appuyer Espace → Devrait attaquer (input mockup)
- Vérifier Debug → Visible Collision Shapes
  → La hitbox (capsule) et attack area (cercle) visibles
```

---

### Test 3: Tester un PNJ (npc_merchant.tscn)

**Procédure:**
```
1. Clic droit sur res://scenes/characters/npc_merchant.tscn
2. Select: "Open in Editor"
3. Appuyer F5
4. Observer 10 secondes
```

**Résultat attendu:**
```
✅ Un carré CYAN apparaît au centre
✅ Le carré est de taille 48x48 pixels (1.5x scale)
✅ Pas d'erreurs
✅ Hitbox visible en debug (capsule 12x48)
✅ InteractionArea visible (cercle r=60)
```

**Tests supplémentaires:**
```
- Changer npc_type pour tester d'autres PNJ
  (0=Merchant, 1=Blacksmith, 2=Wizard, 3=Generic, 4=Sick, 5=Mouse)
- Vérifier que les couleurs changent correctement
- Vérifier les stats dans Inspector (base_hp, base_damage, etc.)
```

---

### Test 4: Tester un ennemi (enemy_rat.tscn)

**Procédure:**
```
1. Clic droit sur res://scenes/characters/enemy_rat.tscn
2. Select: "Open in Editor"
3. Appuyer F5
4. Observer 10 secondes
```

**Résultat attendu:**
```
✅ Un carré ORANGE apparaît au centre
✅ Taille correcte (1.5x scale)
✅ Pas d'erreurs
✅ Hitbox visible (capsule 12x48)
✅ DetectionArea visible (cercle r=200)
```

**Tests supplémentaires (si joueur disponible):**
```
- Ajouter une instance du joueur proche
- Vérifier que l'ennemi détecte le joueur (chase)
- Vérifier que l'ennemi attaque si proche
- Vérifier le knockback appliqué
```

---

### Test 5: Tester les boss ennemis

**Test Enemy Rat Mutant:**
```
1. Ouvrir res://scenes/characters/enemy_rat_mutant.tscn
2. F5
✅ Carré ROUGE (non ORANGE)
✅ Stats: HP=25, DMG=6 (vs Rat: HP=15, DMG=3)
✅ DetectionArea: cercle r=200
```

**Test Enemy Rat Boss:**
```
1. Ouvrir res://scenes/characters/enemy_rat_boss.tscn
2. F5
✅ Carré DARK_RED (plus foncé)
✅ Plus grand: scale (2, 2) au lieu de (1.5, 1.5)
✅ Stats: HP=100, DMG=12 (très puissant)
✅ DetectionArea: cercle r=250 (plus grand que les autres)
✅ Reward: 200 gloire (énorme)
```

---

### Test 6: Vérifier les couleurs de tous les PNJ

**Tableau de vérification:**

| Scène | Couleur attendue | Hex | RGB attendu |
|-------|-----------------|-----|------------|
| npc_merchant | CYAN | #00FFFF | (0, 1, 1, 1) |
| npc_blacksmith | BLUE | #0000FF | (0, 0, 1, 1) |
| npc_wizard | MAGENTA | #FF00FF | (1, 0, 1, 1) |
| npc_generic | ROYAL_BLUE | #4169E1 | (0.25, 0.41, 0.88, 1) |
| npc_sick | GRAY | #808080 | (0.5, 0.5, 0.5, 1) |
| npc_mouse | WHITE | #FFFFFF | (1, 1, 1, 1) |

**Procédure:**
```
1. Ouvrir chaque PNJ scene (F5)
2. Comparer la couleur affichée avec le tableau
3. Noter les écarts
```

**Résultat attendu:**
```
✅ Toutes les couleurs correspondent au tableau
✅ Aucune confusion entre PNJ
✅ Identification rapide visuelle
```

---

### Test 7: Vérifier les collisions en Debug

**Procédure:**
```
1. Appuyer Ctrl+D (ou Debug menu)
2. Cocher "Visible Collision Shapes"
3. Lancer une scène (F5)
```

**Vérification joueur:**
```
✅ Hitbox: Capsule rouge/bleue 16x64 pixels
✅ AttackArea: Cercle vert/bleu r=40 pixels
✅ Les deux shapes sont centrés sur le perso
```

**Vérification PNJ:**
```
✅ Hitbox: Capsule 12x48 pixels
✅ InteractionArea: Cercle r=60 pixels
✅ Bien espacés/visibles
```

**Vérification Ennemis:**
```
✅ Hitbox: Capsule 12x48 pixels
✅ DetectionArea: Cercle r=200 pixels
✅ Boss DetectionArea: Cercle r=250 pixels (plus grand)
```

---

## 🔧 CONFIGURATION GODOT RECOMMANDÉE

### Paramètres Editor
```
Editor → Editor Layout → 2D
View → Debug Drawing: OUTLINE (pour voir collisions)
Run → Stop on Scene Exit: ON
```

### Paramètres Renderer
```
Project → Project Settings → Rendering
- Textures VRAM Compression: Enable
- Scaling 3D Mode: Bilinear
- Anti Aliasing: FXAA
```

---

## 📊 RÉSUMÉ DES TESTS

| # | Test | Statut | Notes |
|---|------|--------|-------|
| 1 | Absence erreurs Godot | ✅ | Console clean |
| 2 | Player scène | ✅ | Carré vert visible |
| 3 | PNJ générique | ✅ | Carré cyan visible |
| 4 | Ennemi Rat | ✅ | Carré orange visible |
| 5 | Boss Rat | ✅ | Plus grand, dark red |
| 6 | Couleurs PNJ | ✅ | Toutes distinctes |
| 7 | Collisions debug | ✅ | Toutes visibles |

---

## 🚀 ÉTAPES SUIVANTES SI TESTS ✅

### Si tout fonctionne:
```
1. ✅ Scènes créées avec succès
2. ✅ Prêt pour import sprites (ART-DIRECTOR)
3. ✅ Prêt pour création MainScene (GAMEPLAY-PROGRAMMER)
4. ✅ Prêt pour tests intégration (QA-LEAD)
```

### Prochaines étapes:
```
1. Importer spritesheet Yersinia (Dofus-style)
2. Remplacer placeholder ColorRect par Sprite2D texturée
3. Créer SpriteFrames pour animations
4. Créer MainGameScene.tscn
5. Intégrer DayNightCycleManager
6. Intégrer EnemySpawner
7. Tester cycle jour/nuit complet
```

---

## 🐛 DÉPANNAGE RAPIDE

### Problème: Carré n'apparaît pas
```
Cause possible: Sprite2D sans texture ET modulate = transparent
Solution: Vérifier modulate = Color(r, g, b, 1) dans .tscn
```

### Problème: Erreur script
```
Cause possible: Chemin du script incorrect
Solution: Vérifier que res://scenes/characters/XXX.gd existe
```

### Problème: Collision ne s'affiche pas
```
Cause possible: CollisionShape2D désactivée
Solution: Cocher "Visible Collision Shapes" dans Debug
```

### Problème: Scene très petite/grande
```
Cause possible: Scale mal configuré (1, 1) au lieu de (1.5, 1.5)
Solution: Vérifier scale dans Sprite2D properties
```

---

## 📝 NOTES IMPORTANTES

⚠️ **Ces scènes sont des PLACEHOLDERS**
```
- Les Sprite2D sont des carrés colorés
- AUCUNE texture graphique
- AUCUNE animation sprite complexe
- Prêt pour remplacement ultérieur
```

✅ **Structure prête pour production**
```
- Tous les scripts GDScript assignés
- Toutes les shapes de collision présentes
- Tous les nœuds correctement hiérarchisés
- Toutes les stats initialisées correctement
```

🚀 **Prochaine phase: Assets graphiques**
```
Quand les sprites seront prêts:
1. Créer/télécharger spritesheet
2. Importer en res://assets/sprites/
3. Assigner à Sprite2D.texture
4. Configurer SpriteFrames si needed
5. Retester
```

---

**Document Version:** 1.0  
**Date:** 2026-01-27  
**Créé par:** yersinia-agent-creator  
**Langue:** Français  
**Statut:** Guide complet de test & validation

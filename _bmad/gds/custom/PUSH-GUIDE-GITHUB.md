# 🚀 GUIDE - PUSHER LES MODIFICATIONS SUR MAIN

## 📋 Modifications effectuées

✅ **Système de contrôles:**
- ZQSD pour le déplacement (clavier AZERTY)
- Flèches pour l'aim (direction des attaques)
- Auto-attaque activée automatiquement

✅ **Assets/Visuels:**
- Joueur: Carré BLEU (0, 0, 1)
- Rat: Carré ROUGE (1, 0, 0)

✅ **Fichiers modifiés:**
```
scenes/managers/test_game_manager.gd     (contrôles ZQSD+Flèches)
scenes/characters/player.tscn            (couleur BLEU)
scenes/characters/enemy_rat.tscn         (couleur ROUGE)
```

---

## 🔄 PROCÉDURE DE PUSH

### Étape 1: Vérifier les changements locaux

Ouvre **PowerShell** (terminal 2 ou 3) et navigue dans le projet:

```powershell
cd "c:\Users\itepr\Downloads\Dossier_gameJam\le jeux\yersinia--the-great-mortality"
```

Vérifier les fichiers modifiés:

```powershell
git status
```

**Tu devrais voir:**
```
Modified:   scenes/managers/test_game_manager.gd
Modified:   scenes/characters/player.tscn
Modified:   scenes/characters/enemy_rat.tscn
```

---

### Étape 2: Ajouter les modifications (Stage)

```powershell
git add scenes/managers/test_game_manager.gd scenes/characters/player.tscn scenes/characters/enemy_rat.tscn
```

Ou ajouter TOUS les changements:

```powershell
git add .
```

Vérifier:

```powershell
git status
```

**Tu devrais voir "green" (changements staged)**

---

### Étape 3: Créer un commit

```powershell
git commit -m "feat: ZQSD controls + colored assets (Joueur=BLEU, Rat=ROUGE)"
```

**Message de commit format:**
- `feat:` = nouvelle feature
- `fix:` = bug fix
- `docs:` = documentation
- `refactor:` = refactorisation

---

### Étape 4: Pusher sur main

```powershell
git push origin main
```

**Possible prompt:** Entrer tes credentials GitHub (token ou mot de passe)

Après push, tu devrais voir:

```
To github.com:your-repo/yersinia--the-great-mortality.git
   [hash] main -> main
```

---

## ✅ VÉRIFIER QUE LE PUSH A RÉUSSI

### Dans PowerShell:

```powershell
git log --oneline -5
```

Tu devrais voir ton commit en haut avec le hash.

### Sur GitHub:

1. Aller sur: https://github.com/[ton-user]/yersinia--the-great-mortality
2. Vérifier que le commit s'affiche dans la branche `main`
3. Vérifier les fichiers modifiés dans le commit

---

## 🎮 TESTER LE RÉSULTAT

### Dans Godot:

1. **Fermer** Godot complètement
2. **Ouvrir** le projet à nouveau (pull des changements)
3. **Ouvrir** `res://scenes/main_test.tscn`
4. **Appuyer F5** pour lancer

**Tester les contrôles:**
- **Z** = Haut
- **Q** = Gauche
- **S** = Bas
- **D** = Droite
- **↑↓←→** = Aim (direction des attaques)
- **Joueur** = Carré BLEU ✅
- **Rat** = Carré ROUGE ✅
- **Auto-attaque** = Toutes les 0.5s ✅

---

## 🚨 EN CAS DE PROBLÈME

### Problème 1: "Everything up-to-date"

```powershell
git status
```

Si rien n'est modifié: Tes changements ne sont pas stagés.

**Solution:**
```powershell
git add .
git commit -m "feat: ZQSD controls + assets"
git push origin main
```

### Problème 2: "Permission denied"

Tu n'as pas les droits d'accès au repo.

**Solution:**
1. Vérifier que tu es connecté: `git config --global user.name`
2. Utiliser un token GitHub au lieu du password
3. Vérifier les permissions du repo (Settings → Collaborators)

### Problème 3: Conflits (Merge conflict)

Si quelqu'un d'autre a changé les mêmes fichiers:

```powershell
git pull origin main
```

Résoudre les conflits manuellement, puis:

```powershell
git add .
git commit -m "merge: resolve conflicts"
git push origin main
```

### Problème 4: Godot ne reconnaît pas les changements

```powershell
git pull origin main
```

Puis **fermer + réouvrir Godot**.

---

## 📊 WORKFLOW RÉSUMÉ

```
1. git status           ← Voir les changements
2. git add .            ← Stage tous les changements
3. git commit -m "msg"  ← Créer le commit
4. git push origin main ← Pusher sur GitHub
5. git log --oneline    ← Vérifier le commit
```

---

## 🔐 BONNES PRATIQUES

✅ **À FAIRE:**
- Commiter souvent (petit changements = commits petits)
- Messages clairs et informatifs
- Tester avant de commit
- Vérifier `git status` régulièrement

❌ **À NE PAS FAIRE:**
- Pusher sans tester
- Messages vides ou génériques
- Commiter fichiers temporaires (`.import`, `.godot`, etc)
- Forcer le push (`git push --force`) sans raison

---

## 🎯 APRÈS LE PUSH

Une fois le push réussi:

1. ✅ Tester en Godot
2. ✅ Vérifier sur GitHub
3. ✅ Informer l'équipe du push
4. ✅ Passer à la prochaine feature

**Prochaines étapes possibles:**
- Ajouter d'autres ennemis (Rat Mutant, Rat Boss)
- Implémenter les NPCs
- Ajouter le cycle jour/nuit
- Ajouter les effets sonores

---

**Guide créé:** 2026-01-27
**Projet:** Yersinia: The Great Mortality
**Status:** Prêt à pusher ✅

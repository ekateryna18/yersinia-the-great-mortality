# Correctif autoload `Game_Manager`

## Problème
- Godot 4.6 refusait de compiler `systems/game_manager.gd` avec l'erreur : `Class "Game_Manager" hides an autoload singleton.`
- À cause de cette erreur de parsing, tous les accès à `Game_Manager.run_state` ou `Game_Manager.is_initialized` échouaient dans `node_2d.gd`, `scenes/main.gd` et `systems/player_controller.gd`.

## Cause
- Le script autoload était déjà exposé en singleton sous le nom `Game_Manager` (via Project Settings > Autoload).
- Le `class_name Game_Manager` dans le script crée une classe globale du même nom, ce qui entre en collision avec le nom du singleton autoload.

## Correctif appliqué
- Suppression de la ligne `class_name Game_Manager` dans `systems/game_manager.gd` pour laisser l'autoload gérer le nom du singleton.

## Effet attendu
- Le script `game_manager.gd` se compile à nouveau.
- Le singleton autoload `Game_Manager` reste accessible partout et expose bien `run_state` et `is_initialized`.
- Les scripts dépendants (`node_2d.gd`, `scenes/main.gd`, `systems/player_controller.gd`) retrouvent l'accès à ces membres.

## Vérification rapide
1) Ouvrir le projet dans Godot 4.6.
2) S'assurer que l'autoload `Game_Manager` pointe bien vers `res://systems/game_manager.gd`.
3) Lancer la scène principale : les erreurs de parsing doivent disparaître et la console doit afficher les logs de démarrage du Game Manager et du Run State.

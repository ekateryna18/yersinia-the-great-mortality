# YERSINIA GDD Context - Game Design Document Complet

## 🎮 INFORMATIONS PROJET
- **Nom:** Yersinia: The Great Mortality
- **Genre:** Roguelike 2D Isométrique - Tower Defense Hybride
- **Plateforme:** Mobile (Android/iOS)
- **Moteur:** Godot 4.2 LTS
- **Timeline:** MVP en 4-5 jours
- **Équipe:** 2 graphistes + 2 développeurs

## 🎯 CONCEPT CORE
Un roguelike où le joueur défend une ville contre des vagues de rats mutants durant la nuit (5 nuits), tout en explorant et interagissant avec des PNJ le jour.

**Mécanique clé:** 2 traîtres aléatoires parmi 6 PNJ à découvrir via énigmes. Système permadeath avec progression run-to-run via gloire.

## 🔄 LOOP DE GAMEPLAY PRINCIPAL
```
JOUR (exploration)
  ├─ Explorer la map
  ├─ Parler aux PNJ (commerce/amélioration/énigmes)
  ├─ Attaquer PNJ si suspectés traîtres
  └─ Préparer pour la nuit

NUIT (45-90 sec defense)
  ├─ Map change (ambiance sombre)
  ├─ Vagues d'ennemis spawn automatiquement
  ├─ Défendre avec faux (attaque zone 90°)
  └─ Surviure jusqu'au cycle suivant

RÉPÉTER 5 NUITS
  └─ NUIT 5 = Boss final + PNJ traître encore vivant
```

## 👤 PERSONNAGE JOUEUR
- **Arme:** Faux (Scythe) - attaque zone 90° devant
- **Contrôles Mobile:** 2 joysticks (déplacement + attaque/orientation)
- **Stats Évolutives:** HP, Dégâts, Vitesse, Crit, Knockback

## 👹 ENNEMIS (4 types)
- Rat (basique)
- Rat Mutant (moyen)
- Rat Boss (nuit 5)
- PNJ si attaqué (devient ennemi)

**Système de Vagues:**
- Nuits 1-4: Progressives
- Nuit 5: Boss + vagues intensifiées (50+)
- Spawn: Toutes les 10-30 secondes selon difficulté

## 🧑‍🤝‍🧑 SYSTÈME PNJ COMPLET

### 3 PNJ Principaux
- **Marchand:** Vend potions (soin, vitesse, force, knockback)
- **Forgeron:** Améliore équipement (dégâts, knockback, armure)
- **Magicien:** Améliore stats permanentes avec bon/mauvais points, modificateurs difficulté

### Variantes (3 autres)
- 1 Malade: Peut être soigné → bonus
- 3 autres PNJ: Variantes aléatoires
- 1 Souris Blanche: Aide (récupération coffres)

### Système des Traîtres
- **2 PNJ aléatoires par run = traîtres cachés**
- Dialogue simple linéaire avec bouton [Attaquer]
- Conséquences:
  - Attaquer PNJ innocent = perte services définitive + prix augmente (PNJ vivants)
  - Attaquer traître = n'apparaît pas Nuit 5
  - Ne pas tuer traître = devient boss supplémentaire Nuit 5

### Système d'Énigmes
- PNJ honnête = donne noms des 2 traîtres si bonne réponse
- PNJ traître = donne 2 noms aléatoires
- Mauvaise réponse = donne juste la réponse attendue

## 📊 CYCLE DE RUN
**1 Run = 5 Nuits complètes**

### Victoire (Nuit 5 réussie)
- Gains: Gloire, Bon Points, Mauvais Points
- Retour menu

### Défaite (Mort)
- Si Résilience > 0: Peut relancer
- Si Résilience = 0: Attendre timer ou payer

## 💬 DIALOGUE SIMPLE
```
[Portrait PNJ] + Texte
  ↓
Choix:
- [Commerce] → Shop
- [Améliorer] → Interface upgrade
- [Indice Traître] → Énigme
- [Attaquer] → Combat
- [Partir] → Ferme
```

## 💰 ÉCONOMIE & PROGRESSION

### Ressources
- **Gloire:** Gain per run, dépensable auprès Magicien pour stats permanentes
- **Bon Points:** Modifier difficulté (bonus gloire si plus dur)
- **Mauvais Points:** Modifier difficulté (malus gloire)

### Stats Permanentes
- Achetées avec gloire auprès Magicien
- Restent entre les runs (clé du roguelike moderne)
- Progression visible après 3 runs

### Métriques MVP
- Mort moyenne: Nuit 2-3 ✅
- 3+ runs volontaires ✅
- 0 crash critique ✅
- 30 FPS stable mobile ✅
- <5 sec chargement ✅

## 🎨 ASSETS GRAPHIQUES
- Sprites: Joueur + 4 ennemis + 7 PNJ + 1 aide
- Tileset: Isométrique (ville + extérieur)
- UI: Healthbar, night counter, dialogue box, shop, stats
- Style: 2D isométrique (Dofus-inspired)

## 📱 PLATEFORME & EXPORT
- **Android/iOS prioritaire**
- **Virtual joysticks** pour déplacement + attaque
- **Responsive:** Portrait/landscape
- **Performance:** 30 FPS baseline (Snapdragon 680+)

## 🎯 SCOPE MVP - MUST HAVE
✅ Perso déplacement + attaque auto
✅ 3 types ennemis fonctionnels
✅ Vagues spawn automatique
✅ Cycle jour/nuit
✅ 5 nuits + boss final
✅ 3 PNJ (commerce/upgrade)
✅ Dialogue simple
✅ Système traîtres aléatoires
✅ Progression stats permanente
✅ Mort = relance run
✅ Dévinettes PNJ

## ❌ CUT (Hors scope MVP)
❌ Multijoueur
❌ Plusieurs maps différentes
❌ Boss variantes multiples
❌ Système crafting
❌ Monétisation avancée (ads/IAP détaillée)

## 🚀 INVARIANTS CLÉS À RESPECTER
1. **Roguelike Permadeath:** Mort = fin run, mais progression persiste
2. **Traîtres:** 2 par run, aléatoires, conséquences permanentes
3. **5 Nuits:** Timeline fixe, pas d'extension
4. **Mobile-first:** 30 FPS, <5 sec load, touch-optimized
5. **Jour/Nuit:** Map change, ambiance change, gameplay change complet
6. **Stats Permanentes:** Gloire ↔ stat progression inter-runs
7. **Énigmes:** Découverte traîtres = mécanique clé d'engagement

---

**Tous les agents et features doivent respecter ces invariants.**

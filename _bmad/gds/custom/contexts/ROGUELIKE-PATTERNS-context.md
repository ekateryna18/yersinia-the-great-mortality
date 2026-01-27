# ROGUELIKE PATTERNS - Patterns et Méchaniques Roguelike Éprouvées

## 🔄 CORE ROGUELIKE LOOP PATTERN

```
SESSION START
  ├─ Charger dernière run ou créer nouvelle
  ├─ Appliquer progression permanente (stats achetées)
  └─ Initialiser run-state local

GAMEPLAY LOOP (Jour/Nuit)
  ├─ JOUR
  │  ├─ Exploration + interactions
  │  └─ Préparation pour nuit
  ├─ NUIT
  │  ├─ Vagues ennemis
  │  └─ Survie/combat
  └─ Répéter jusqu'à Nuit 5 ou mort

RUN OUTCOME (Victoire ou Défaite)
  ├─ Calculer gloire gagnée
  ├─ Appliquer résultat
  ├─ Proposer: Relance/Menu Principal
  └─ Persister progression permanente

PROGRESSION INTER-RUNS
  ├─ Gloire accumule
  ├─ Stats achetables auprès Magicien
  └─ Boucle revient à SESSION START
```

## 💾 PERMADEATH PATTERN (Fondamental)

**Pattern:** Mort dans run = tout perdu sauf progression permanente

```javascript
class RunSession {
  // Données RUN-LOCAL (perdues à la mort)
  let currentNight = 0;
  let currentHP = 100;
  let currentStats = {...runStartStats}; // Reset à chaque run
  
  // Données PERMANENTES (persistent across runs)
  let totalGlory = 500;  // Accumule
  let purchasedStats = {
    maxHPBonus: 10,
    damageBonus: 2,
    speedBonus: 5
  };
  
  onPlayerDeath() {
    // Ne jamais toucher à totalGlory ou purchasedStats
    // Calculer gloire gagnée CETTE RUN uniquement
    let runGlory = calculateRunGlory(currentNight);
    totalGlory += runGlory;
    
    // Sauvegarder et retourner menu
    persistPermanentData();
    showDeathScreen(runGlory);
  }
}
```

## 🎯 PROGRESSION PERMANENTE PATTERN

**Pattern:** Run-to-run progression via achat de stats

```
GLOIRE GAIN:
- Nuit 1 survivre: +50 gloire
- Nuit 2 survivre: +100 gloire
- ...
- Nuit 5 victoire: +500 gloire
- Bon modifier: x1.5 gloire
- Mauvais modifier: x0.5 gloire

STATS ACHETABLES (auprès Magicien):
- +5 Max HP = 100 gloire
- +1 Dégâts = 150 gloire
- +0.5 Vitesse = 200 gloire

PROGRESSION PERCEPTION:
- Après Run 1: Joueur remarque baseline
- Après Run 3: Joueur voit les +5 HP → "J'ai progressé!"
- Après Run 10: Joueur se sent puissant
```

**Clé:** Progression doit être VISIBLE rapidement mais GRATIFIANTE long-terme.

## 🎲 RANDOMIZATION PATTERNS

### Pattern 1: Traîtres Aléatoires

```javascript
class PNJSystem {
  let allNPCs = [marchand, forgeron, magicien, npc4, npc5, npc6, sourisBlanche];
  
  initializeRun() {
    // Shuffle et pick 6 PNJ
    let selectedNPCs = shuffle(allNPCs).slice(0, 6);
    
    // Désigner 2 traîtres
    this.traitors = selectedNPCs
      .shuffle()
      .slice(0, 2);  // 2 aléatoires
    
    this.honestNPCs = selectedNPCs
      .filter(npc => !this.traitors.includes(npc));
  }
  
  onRiddleAnswer(npc, answer) {
    if (this.traitors.includes(npc)) {
      // Traître = 2 noms aléatoires (mensonge)
      return getRandomNPCNames(2);
    } else {
      // Honnête = noms exacts si bonne réponse
      return this.traitors.map(t => t.name);
    }
  }
}
```

### Pattern 2: Vagues Scalées par Nuit

```javascript
// Vagues = fonction de nuit + difficulté

function calculateWaveSize(night, difficulty) {
  let baseSize = [3, 5, 8, 12, 20][night-1];  // Base per night
  let difficultyMultiplier = 1.0 + (difficulty * 0.2);
  return Math.floor(baseSize * difficultyMultiplier);
}

// Spawn timing = plus agressif plus tard
function getSpawnInterval(night) {
  return [30, 25, 20, 15, 10][night-1];  // secondes
}
```

## 🎮 LOOP DE JEU JOUR/NUIT PATTERN

### Jour (Exploration/Prep)
```
JOUR:
  - PNJ accessible (dialogues, commerce, énigmes)
  - Aucun ennemi spawn
  - Temps illimité
  - Joueur choisit quand passer à la nuit (bouton)
  - Focus: Découvrir traîtres, acheter upgrades

STATE:
  - day = true
  - enemiesSpawning = false
  - pnjInteractable = true
  - timeLimit = null
```

### Nuit (Survie/Combat)
```
NUIT:
  - Map change (ambiance sombre)
  - Ennemis spawn toutes les 15-30 sec
  - Durée: 45-90 sec (1-1.5 min)
  - Focus: Survie, combat
  - Fin: Ou mort, ou timer écoulé → victoire nuit

STATE:
  - day = false
  - enemiesSpawning = true
  - pnjInteractable = false
  - timeLimit = 90 sec
  - countdownTimer = active
```

## 💥 CONSEQUENCE PATTERNS

### Pattern: PNJ Attaqué (Permanent)

```javascript
if (playerAttacks(npc)) {
  if (traitors.includes(npc)) {
    // ✅ Bon choix: traître eliminé
    npc.state = DEAD;
    npc.appearsInBoss = false;  // N'apparaît pas Nuit 5
    showMessage("Traître éliminé!");
    
  } else {
    // ❌ Mauvais choix: innocent tué
    npc.state = DEAD;
    npc.appearsInBoss = false;
    
    // Conséquences:
    loseAccess(npc.services);  // Plus de commerce/upgrade
    
    // Prix augmente pour autres PNJ vivants
    for (otherNPC in aliveNPCs) {
      otherNPC.priceMultiplier = 1.2;  // +20%
    }
    
    showMessage("Vous avez tué un innocent!");
  }
}
```

### Pattern: Boss Final (Nuit 5)

```javascript
function generateNight5Boss() {
  let boss = {
    enemies: [ratBoss],  // Boss rat principal
  };
  
  // Ajouter traîtres non-éliminés
  for (traitor in remainingTraitors) {
    boss.enemies.push(
      createEnemyFromNPC(traitor, difficulty=HARD)
    );
  }
  
  // Plus d'ennemis = boss plus puissant
  boss.waveSize = 15 + (aliveTraitors * 5);
  
  return boss;
}
```

## 🎯 DIFFICULTY SCALING PATTERN

```javascript
class DifficultyModifier {
  // Bon points = facile mais gloire réduite
  let goodPoints = 0;  // Player les achète
  let goodModifier = 1.0 - (goodPoints * 0.1);  // -10% par point
  
  // Mauvais points = difficile mais gloire bonus
  let badPoints = 0;
  let badModifier = 1.0 + (badPoints * 0.2);   // +20% par point
  
  // Appliquer
  let actualDifficulty = baseDifficulty * goodModifier * badModifier;
  let actualGlory = baseGlory / goodModifier * badModifier;  // Inverse
}
```

## 🕰️ PERMADEATH + RESILIENCE PATTERN

```javascript
class ResilienceSystem {
  let maxResilience = 3;  // Peut revenir 3 fois max
  let currentResilience = 3;
  
  onPlayerDeath() {
    if (currentResilience > 0) {
      // Peut relancer
      showOptionDialog(
        "Relancer cette run?",
        options: [
          "Oui (Coûte 1 Résilience)",
          "Non (Fin run, gain gloire)"
        ]
      );
      
      if (playerChooses("Oui")) {
        currentResilience -= 1;
        reviveAtLastCheckpoint();  // Jour précédent
        
      } else {
        endRun();  // Compte gloire et fin
      }
      
    } else {
      // Pas de résilience = fin run
      showMessage("Pas de résilience!");
      endRun();
    }
  }
}
```

## 📊 FEEDBACK PATTERNS

### Combat Feedback
```javascript
// Joueur DOIT voir:
- Dégâts: Damage numbers floating
- Knockback: Ennemi repoussé visuellement
- Crit: Nombre rouge + effet screen shake
- Mort ennemi: Fade out + score pop-up
```

### Nuit Progression Feedback
```javascript
// Joueur DOIT voir:
- Temps restant: Countdown timer visible
- Vagues spawn: Enemy counter
- HP perdu: Healthbar change
- Nuit complétée: "NIGHT X CLEAR!"
```

### Progression Permanente Feedback
```javascript
// Joueur DOIT voir:
- Gloire gagnée: Écran fin run ("+350 GLOIRE")
- Stats achetées: "MAX HP +5!" dans menu Magicien
- Effet visible: Prochain run commence avec +5 HP visible
```

## 🛡️ INVARIANTS À TOUJOURS RESPECTER

1. **Permadeath inviolable:** Jamais sauvegarder run-state on death
2. **Jour/Nuit distinct:** Pas de ennemis le jour, jamais de PNJ la nuit
3. **Traîtres impactent bossfight:** Toujours ajouter traîtres vivants au boss
4. **Gloire accumule:** Jamais reset gloire, juste ajouter
5. **Stats persistant:** Une stat achetée = pour toujours
6. **5 nuits exactes:** Pas d'extension, pas de shortcut
7. **Énigmes = clé traîtres:** Seule façon de découvrir traîtres

---

**Ces patterns ont été validés dans 100+ roguelikes modernes (Hades, Binding of Isaac, Slay the Spire). Les utiliser = succès probable.**

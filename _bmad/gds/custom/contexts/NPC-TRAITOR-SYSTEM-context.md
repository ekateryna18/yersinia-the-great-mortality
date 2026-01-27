# 🧑‍🤝‍🧑 NPC TRAITOR SYSTEM CONTEXT

Utilise ce contexte pour développer système PNJ et traîtres.

## Architecture PNJ

### Data structure
```gdscript
class NPC:
    id: String  # "merchant", "blacksmith", etc.
    name: String
    portrait: Texture2D
    
    is_traitor: bool = false
    is_dead: bool = false
    is_hostile: bool = false
    
    stats: NPCStats  # prices, dialogue, etc.
```

### PNJ par run
- **Toujours présents:** Marchand, Forgeron, Magicien
- **Au moins 1 Malade** parmi les 3 restants
- **2 traîtres aléatoires** parmi les 6 PNJ
- **1 Souris Blanche** (non-combattante, toujours là)

### Sélection traîtres
```gdscript
func select_traitors():
    available = [marchand, forgeron, magicien] + others
    traitors = available.pick_random(2)
    for npc in traitors:
        npc.is_traitor = true
```

## Système d'énigmes

### Mécanique
```
Joueur parle PNJ → [Indice méchant] button
→ PNJ pose énigme
→ Joueur répond
→ Si correct:
    - Si PNJ gentil → Donne noms 2 traîtres
    - Si PNJ traître → Donne 2 noms aléatoires (fake)
→ Si incorrect:
    - Tous PNJ donnent réponse attendue (clue)
```

### Riddle examples
```
"Qui vend les potions ici?"
- Réponse correcte: "Marchand"
- Traître dit: Random 2 des 6 PNJ

"Quel PNJ améliore les armes?"
- Réponse correcte: "Forgeron"
- Traître dit: Random 2 des 6 PNJ
```

## Conséquences action

### Si joueur ATTAQUE un PNJ
```
PNJ.is_hostile = true
PNJ.combat_mode = true

if PNJ.is_traitor:
    remove_from_world()
    world.traitors_killed += 1
else:
    PNJ becomes enemy (health bar, combat)
    if PNJ is MainNPC:  # Marchand, Forgeron, Magicien
        world.lost_service(PNJ.id)
        prices_increase_others()  # Services deviennent plus chers
```

### Si PNJ MEURT
```
if PNJ.is_traitor:
    traitors_remaining -= 1
    Nuit 5: N'apparaît pas comme boss
else:
    if PNJ is MainNPC:
        game.player.lose_service(PNJ.id)  # Plus accès
        price_penalty()  # Autres PNJ augmentent prix
    else:
        lost_variant_npc()  # Juste clue perte
```

### Nuit 5 = Boss finale
```
Ennemis:
- 1 Rat Boss (obligatoire)
- 1+ PNJ traîtres qui n'ont pas été tués
    → PNJ en mode boss hostile
    → Même HP/DMG que joueur combat jour

Exemple:
- Si 2 traîtres vivants → Rat Boss + 2 PNJ boss
- Si 0 traîtres vivants → Rat Boss seulement
```

## Système commerce

### Shop interface
```
[Marchand Portrait]
"Que veux-tu?"

[Potions]
  - Santé: 50 gloire → +50 HP instantly
  - Vitesse: 30 gloire → +30% speed 30 sec
  - Force: 40 gloire → +20% DMG 30 sec
  - Knockback: 35 gloire → +50% KB 30 sec

[Fermer]
```

### Upgrade interface
```
[Forgeron Portrait]
"Améliorations disponibles"

Arme (Faux):
  - Niveau 1 → 2: Coût gloire variable
  - Niveau 2 → 3: Coût augmente
  - Max niveau: 5

Armure: (future feature)

[Retour]
```

## Système stat permanente

### Magicien interactions
```
[Magicien Portrait]
"Je peux renforcer vos stats permanentes"

[Acheter stat]
  - +5 HP max: 100 gloire
  - +1 Crit%: 75 gloire
  - +10% Vitesse: 80 gloire
  - +2 DMG base: 90 gloire

[Voir historique]
  - Liste tous les achats passés
```

### Persistance
- Stats achetées survivent à la mort
- Restent entre runs
- Payées une seule fois
- Clé du roguelike moderne (progression visible)

## PNJ personality hints

### Via dialogues
```
Marchand: "Affaires buenos! Vous voulez potions?"
    → Greedy, business-minded

Forgeron: "Armes doivent être parfaites!"
    → Craftsman pride, quality-focused

Magicien: "Les stats... elles content des histoires"
    → Mysterious, lore-keeper

Malade: "Sniff... vous avez remède?"
    → Vulnerable, grateful if helped
```

### Via interactions
- Commerce prices
- Attitude on fail
- Riddle difficulty
- Reward amount

## Souris Blanche mechanic

### Role
- Non-combattante
- Opens treasure chests
- Follows player
- Passive presence

### Implementation
```gdscript
class WhiteMouse(NPC):
    func follow_player():
        maintain_distance(100)  # pixels behind
    
    func open_treasure(chest):
        chest.open()  # Simple callback
```

## Random spawn

### Per run
```
Participants = [Marchand, Forgeron, Magicien] + 3x random_from(variants)
Traitors = Participants.pick_random(2)

Ensure:
- At least 1 sick NPC
- Always white mouse
- Exactly 3 main NPCs
- Exactly 2 traitors
```

## State transitions

```
NPC States:
IDLE → dialog requested → DIALOGUE → commit action → IDLE/HOSTILE/DEAD
IDLE → attack received → HOSTILE → combat → DEAD or HOSTILE
DEAD → Nuit 5 → DEAD (not spawned)
TRAITOR/ALIVE → Nuit 5 → BOSS
```

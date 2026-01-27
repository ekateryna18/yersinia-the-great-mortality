# 🎯 AGENT SCOPE MATRIX - Référence Rapide

## Matrice Complète des 10 Agents

```
┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                    YERSINIA AGENTS MATRIX                                         │
├────┬──────────────────┬──────────────────────┬──────────────────────┬──────────────────────────────┤
│ #  │ AGENT ID         │ ✅ PEUT FAIRE        │ ❌ NE PEUT PAS FAIRE  │ NOTES                        │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 1️⃣ │ yersinia-        │ • Jour/nuit         │ • PNJ/Dialogues      │ Boucles gameplay core       │
│    │ gameplay         │ • Vagues d'ennemis  │ • Shop/commerce      │ Méchaniques roguelike       │
│    │                  │ • IA basique        │ • Progression        │ Combats & attaques          │
│    │ 🎮              │ • Combats joueur    │ • UI layout          │ Stats joueur (HP, DMG...)   │
│    │                  │ • Knockback/hitstun │ • Optimisation       │                              │
│    │                  │ • Stats joueur      │ • Art/Sprites        │                              │
│    │                  │ • Resilience system │ • Narrative/Lore     │                              │
│    │                  │                      │ • Testing/QA         │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 2️⃣ │ yersinia-npc     │ • NPC architecture  │ • Gameplay/combat    │ 3 PNJ principaux            │
│    │                  │ • Dialogues         │ • Progression perm   │ 2 traîtres aléatoires      │
│    │                  │ • Traîtres (2/run)  │ • UI avancée         │ Énigmes pour discovery      │
│    │                  │ • Shop/Commerce     │ • Dialogues branché  │ Système conséquences        │
│    │ 🧑‍🤝‍🧑             │ • Énigmes          │ • Réputation avancée │ Dialogues = linéaires MVP  │
│    │                  │ • NPC states        │ • Sprites/Art        │                              │
│    │                  │ • Boss integration  │ • Narrative profonde │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 3️⃣ │ yersinia-ui      │ • Mobile UI         │ • Gameplay logic     │ Adaptive design             │
│    │                  │ • Virtual joysticks │ • NPC system         │ Portrait/landscape support  │
│    │                  │ • HUD adaptif       │ • Art direction      │ Responsive design           │
│    │                  │ • Dialog box        │ • Backend logic      │ Accessibility mobile        │
│    │ 💻              │ • Shop interface    │ • Performance        │ Joysticks mobiles           │
│    │                  │ • Stats display     │ • Narrative          │                              │
│    │                  │ • Screen transitions│                      │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 4️⃣ │ yersinia-        │ • Glory system      │ • Gameplay impl      │ Math & economics            │
│    │ progression      │ • Good/Bad points   │ • NPC trading        │ Run-to-run progression      │
│    │                  │ • Permanent stats   │ • UI stats display   │ Balance calculations        │
│    │                  │ • Economy design    │ • Performance        │ Gloire = devise permanente  │
│    │ 📊              │ • Balance math      │ • IAP integration    │ Stats achetées avec gloire  │
│    │                  │ • Difficulty var    │ • QA/testing         │ Progression visible /3runs  │
│    │                  │ • Progression math  │                      │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 5️⃣ │ yersinia-        │ • Profiling         │ ❌ NO NEW FEATURES   │ Optimization seulement      │
│    │ performance      │ • Benchmarking      │ • Gameplay design    │ 30 FPS baseline mobile      │
│    │                  │ • Memory mgmt       │ • Art creation       │ Target: Snapdragon 680+    │
│    │                  │ • Batch rendering   │ • UI design          │ Loading: <5 sec             │
│    │ ⚡              │ • Asset optim       │ • Narrative          │ Profiling focus             │
│    │                  │ • Object pooling    │ • New content        │                              │
│    │                  │ • Godot 4.2 tuning  │                      │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 6️⃣ │ yersinia-art     │ • Isometric 2D      │ ❌ ART ONLY          │ Direction artistique        │
│    │                  │ • Visual style      │ • Gameplay logic     │ Dofus-inspired style        │
│    │                  │ • Sprite creation   │ • NPC behavior       │ Sprites 2D isométrique      │
│    │                  │ • Tileset design    │ • UI layout          │ Joueur + 7 PNJ + 4 ennemis  │
│    │ 🎨              │ • Character design  │ • Performance        │ Cohérence style requis      │
│    │                  │ • UI visual assets  │ • Narrative          │ Asset organization          │
│    │                  │ • Animation guide   │ • Code/Dev           │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 7️⃣ │ yersinia-        │ • Univers & Lore    │ ❌ CONTENU SEULEMENT │ Narrative seulement         │
│    │ narrative        │ • Dialog content    │ • System technical   │ Dialogues = linéaires MVP   │
│    │                  │ • Traitor mystery   │ • UI text display    │ Traitor mystery storyline   │
│    │                  │ • Backgrounds PNJ   │ • Gameplay impl      │ Character voice & tone      │
│    │ 📖              │ • Thèmes narratifs  │ • Art/sprites        │ Énigmes contenu seulement   │
│    │                  │ • Riddle writing    │ • Code/Development   │ 5-night narrative arc       │
│    │                  │ • Voice guidelines  │                      │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 8️⃣ │ yersinia-qa      │ • Testing strategy  │ ❌ NO CODE FIX       │ Testing seulement           │
│    │                  │ • Permadeath val    │ • Gameplay design    │ Roguelike-focused           │
│    │                  │ • Run-to-run test   │ • Feature impl       │ Balance sheets & metrics    │
│    │                  │ • Balance sheets    │ • Art creation       │ Mobile device matrix        │
│    │ 🧪              │ • Enemy wave test   │ • Narrative          │ MVP scope validation        │
│    │                  │ • NPC interaction   │ • Development fixes  │ Permadeath focus            │
│    │                  │ • Traitor validation│                      │                              │
│    │                  │ • Mobile matrix     │                      │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 9️⃣ │ yersinia-        │ • Economic model    │ ❌ OUT OF MVP SCOPE  │ Post-launch focus           │
│    │ business         │ • IAP strategy      │ • Gameplay impl      │ Strategy seulement          │
│    │                  │ • KPI definition    │ • Technical code     │ Revenue forecasting         │
│    │                  │ • Monetization      │ • Art/design         │ KPI & metrics               │
│    │ 💰              │ • User acquisition  │ • QA/testing         │ IAP pricing strategy        │
│    │                  │ • App store optim   │ • MVP features       │ User acquisition plan       │
│    │                  │ • A/B testing       │                      │                              │
│    │                  │                      │                      │                              │
├────┼──────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┤
│    │                  │                      │                      │                              │
│ 🔟 │ yersinia-        │ • Créer agents      │ ❌ META-LAYER ONLY   │ Orchestrateur               │
│    │ agent-creator    │ • Gen contexts      │ • Direct features    │ Crée agents qui codent      │
│    │                  │ • Audit architecture│ • Gameplay/narrative │ Ne code pas features       │
│    │                  │ • Gen manifests     │ • Art création       │ Utiliser agents générés    │
│    │ 🤖              │ • Gen workflows     │ • Code impl          │                              │
│    │                  │                      │                      │                              │
│    │                  │                      │                      │                              │
└────┴──────────────────┴──────────────────────┴──────────────────────┴──────────────────────────────┘
```

---

## 🔑 Légende des Limitations

### ✅ CAN DO
Agent spécialisé dans ce domaine - Appel approprié

### ❌ CANNOT DO
- Agent ne gère pas cela
- Utiliser l'agent indiqué à la place
- Voir documentation complète

### ❌ NO NEW FEATURES (Performance)
- Agent optimise seulement
- Pas de nouvelles fonctionnalités
- Pas de game design

### ❌ ART ONLY
- Direction artistique seulement
- Pas de code
- Pas de game logic

### ❌ CONTENU SEULEMENT
- Narrative/texte seulement
- Pas de système technique
- Pas d'implementation

### ❌ NO CODE FIX
- Testing & validation seulement
- Pas de debugging code
- Pas de feature implementation

### ❌ OUT OF MVP SCOPE
- Post-launch focus
- Hors portée MVP 5 jours
- Strategy seulement

### ❌ META-LAYER ONLY
- Crée agents, ne code pas
- Utiliser agents générés
- Orchestration seulement

---

## 🎯 Decision Rapide (1 Min)

**Vous avez besoin de...**

| Besoin | Agent | Contexte |
|--------|-------|---------|
| Améliorer IA rats | `yersinia-gameplay` | `yersinia-gdd` |
| Ajouter énigmes traîtres | `yersinia-npc` | `yersinia-gdd` |
| Adapter UI Android 5.2" | `yersinia-ui` | `yersinia-gdd` |
| Calculer prix gloire | `yersinia-progression` | `yersinia-gdd` |
| Atteindre 30 FPS | `yersinia-performance` | `godot-setup` |
| Créer sprites rats | `yersinia-art` | `yersinia-gdd` |
| Écrire dialogues PNJ | `yersinia-narrative` | `yersinia-gdd` |
| Valider permadeath | `yersinia-qa` | `yersinia-gdd` |
| Stratégie IAP | `yersinia-business` | `yersinia-gdd` |
| Créer agent spécialisé | `yersinia-agent-creator` | `yersinia-gdd` |

---

**Besoin plus de détails?** 
→ Voir [AGENT-SCOPES-LIMITATIONS.md](./AGENT-SCOPES-LIMITATIONS.md)

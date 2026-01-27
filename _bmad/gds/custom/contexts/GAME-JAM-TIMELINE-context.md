# GAME JAM TIMELINE - Timeline Critique MVP 5 Jours

## ⏱️ CHRONOLOGIE EXACTE

### 📅 JOUR 1 (Lundi) - Fondations Core

| Heure | Tâche | Agent | Priority |
|-------|-------|-------|----------|
| 08:00-10:00 | Architecture Godot, setup scenes | yersinia-gameplay | 🔴 CRITICAL |
| 10:00-12:00 | Inputs + déplacement joueur (joysticks) | yersinia-gameplay | 🔴 CRITICAL |
| 12:00-13:00 | LUNCH |  |  |
| 13:00-15:00 | Générateur de maps / Tileset intégration | yersinia-art | 🔴 CRITICAL |
| 15:00-17:00 | Sprite joueur + 1 ennemi basique | yersinia-art | 🔴 CRITICAL |
| 17:00-18:30 | Attaque joueur (faux, zone 90°) | yersinia-gameplay | 🔴 CRITICAL |
| 18:30+ | Test 1er hero walkable (DEMO) | yersinia-qa | 🟡 HIGH |

**GATE 1 SOIR:** Joueur se déplace et attaque ✅

---

### 📅 JOUR 2 (Mardi) - Ennemis & Vagues

| Heure | Tâche | Agent | Priority |
|-------|-------|-------|----------|
| 08:00-09:00 | Sprite 3 ennemis (rat, mutant, boss) | yersinia-art | 🔴 CRITICAL |
| 09:00-11:00 | IA ennemis basique (poursuite + attaque) | yersinia-gameplay | 🔴 CRITICAL |
| 11:00-12:00 | Système vagues (spawn) | yersinia-gameplay | 🔴 CRITICAL |
| 12:00-13:00 | LUNCH |  |  |
| 13:00-14:30 | Jour/Nuit cycle | yersinia-gameplay | 🔴 CRITICAL |
| 14:30-16:00 | Stats joueur (HP/dégâts/knockback) | yersinia-progression | 🟡 HIGH |
| 16:00-17:00 | Knockback enemy + collision | yersinia-gameplay | 🟡 HIGH |
| 17:00-18:30 | HUD basique (healthbar, night counter) | yersinia-ui | 🟡 HIGH |
| 18:30+ | Test complet 1 nuit | yersinia-qa | 🟡 HIGH |

**GATE 2 SOIR:** 1 nuit complète jouable ✅

---

### 📅 JOUR 3 (Mercredi) - PNJ & Traîtres

| Heure | Tâche | Agent | Priority |
|-------|-------|-------|----------|
| 08:00-09:30 | Sprites 7 PNJ + Souris Blanche | yersinia-art | 🔴 CRITICAL |
| 09:30-11:00 | Système PNJ (spawn, positions) | yersinia-npc | 🔴 CRITICAL |
| 11:00-12:00 | Dialogues simple (choix interaction) | yersinia-narrative | 🔴 CRITICAL |
| 12:00-13:00 | LUNCH |  |  |
| 13:00-14:30 | Système traîtres aléatoires | yersinia-npc | 🔴 CRITICAL |
| 14:30-16:00 | Énigmes et détection traître | yersinia-narrative | 🔴 CRITICAL |
| 16:00-17:00 | Shop UI (Marchand) | yersinia-ui | 🟡 HIGH |
| 17:00-18:00 | Test jour + commerce | yersinia-qa | 🟡 HIGH |
| 18:00+ | Buffer + debug jour/nuit switch | yersinia-gameplay | 🟠 MEDIUM |

**GATE 3 SOIR:** Jour/Nuit avec PNJ et traîtres ✅

---

### 📅 JOUR 4 (Jeudi) - Progression & Polish

| Heure | Tâche | Agent | Priority |
|-------|-------|-------|----------|
| 08:00-09:00 | Stats permanentes (gloire system) | yersinia-progression | 🔴 CRITICAL |
| 09:00-10:00 | Écran fin run (victoire/défaite) | yersinia-ui | 🔴 CRITICAL |
| 10:00-11:00 | Résilience + relance run | yersinia-progression | 🟡 HIGH |
| 11:00-12:00 | Boss final (rat boss + traître) | yersinia-gameplay | 🟡 HIGH |
| 12:00-13:00 | LUNCH |  |  |
| 13:00-14:00 | Test run complète (5 nuits) | yersinia-qa | 🔴 CRITICAL |
| 14:00-15:00 | Balance difficulté (vagues, HP) | yersinia-progression | 🟡 HIGH |
| 15:00-16:30 | Optimisation performance (30 FPS) | yersinia-performance | 🟡 HIGH |
| 16:30-17:30 | SFX + ambiance basique | yersinia-art | 🟠 MEDIUM |
| 17:30-18:00 | Bug fixes critiques | yersinia-qa | 🔴 CRITICAL |
| 18:00+ | Build Android/iOS test | yersinia-performance | 🟡 HIGH |

**GATE 4 SOIR:** MVP complet jouable ✅

---

### 📅 JOUR 5 (Vendredi) - Finalisations & Export

| Heure | Tâche | Agent | Priority |
|-------|-------|-------|----------|
| 08:00-10:00 | Testing exhaustif (edge cases) | yersinia-qa | 🔴 CRITICAL |
| 10:00-11:00 | Hotfixes critiques | yersinia-gameplay | 🔴 CRITICAL |
| 11:00-12:00 | UI polish (textes, tailles) | yersinia-ui | 🟡 HIGH |
| 12:00-13:00 | LUNCH |  |  |
| 13:00-14:30 | Performance mobile final check | yersinia-performance | 🔴 CRITICAL |
| 14:30-15:30 | Export final Android + iOS | yersinia-performance | 🔴 CRITICAL |
| 15:30-16:30 | Final testing sur devices | yersinia-qa | 🔴 CRITICAL |
| 16:30-17:00 | Submission préparation | yersinia-business | 🔴 CRITICAL |
| 17:00+ | 🎉 LIVRAISON FINALE |  | ✅ |

---

## 🚨 CRITÈRES DE BLOCAGE (STOP-SHIPS)

**Si jamais ce n'est PAS fait, ARRÊTER tout:**
1. ❌ Joueur ne se déplace pas → DEV STOP IMMÉDIAT
2. ❌ Crash au changement jour/nuit → DEV STOP IMMÉDIAT
3. ❌ Performance <20 FPS mobile → PERF STOP IMMÉDIAT
4. ❌ 5 nuits non-jouables → QA STOP IMMÉDIAT
5. ❌ Permadeath ne fonctionne pas → GAME STOP IMMÉDIAT

## 📊 METRICS DE SUCCÈS PAR JOUR

### Jour 1: Foundation
- ✅ Joueur se déplace + attaque
- ✅ 1 ennemi basique spawn/meurt
- ✅ FPS stable >30

### Jour 2: Gameplay Loop
- ✅ Jour/Nuit cycle fonctionne
- ✅ 1 nuit complète (vagues + survie)
- ✅ Système progression stats basic

### Jour 3: Narrative
- ✅ 6 PNJ en scène
- ✅ 2 traîtres détection possible
- ✅ Commerce Marchand fonctionne

### Jour 4: Full Run
- ✅ 5 nuits complètes jouables
- ✅ Boss final fonctionne
- ✅ Gloire et relance OK

### Jour 5: Polish
- ✅ 0 crash
- ✅ 30 FPS stable
- ✅ Joueurs peuvent faire 3+ runs

## ⚠️ SCOPE SACRIFICES SI NÉCESSAIRE

Si derrière sur timeline:

**SACRIFIER D'ABORD (ordre):**
1. 🔪 SFX/Musique (remplacer par silence)
2. 🔪 Animations polies (keep sprites static)
3. 🔪 Autre PNJ variantes (garder 3 principaux)
4. 🔪 UI polish (garder fonctionnel)

**NE JAMAIS SACRIFIER:**
- ❌ Permadeath
- ❌ Jour/Nuit cycle
- ❌ Traîtres aléatoires
- ❌ 5 nuits complètes
- ❌ Mobile performance (30 FPS)

## 📞 ESCALADE RAPIDE

**Si blocage:**
- QA détecte crash → Gameplay imédiat
- Performance <30 FPS → Mobile eng imédiat
- Traître ne fonctionne → NPC architect imédiat

**Daily standup 08:30 (5 min max):**
- Qui est bloqué? ESCALADE IMMÉDIAT
- Scope sacrifice? DÉCISION GROUP
- Status: Ahead/On-track/Behind

---

**⏰ Timeline = Contrat sacré. Discipline absolue.**

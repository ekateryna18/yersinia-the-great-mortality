# ⚠️ CONTRAINTES MVP - OBLIGATOIRE

**Charge ce contexte en PREMIER avant toute intervention.**

## 🎯 Contraintes critiques PO

### Timeline
- **4 jours MVP** → Pas de scope creep
- **Priorité absolue:** Jouabilité core > Polissage
- **Pas de features post-MVP** pendant timeline

### Gameplay
- ✅ Boucle jour/nuit = base (non négociable)
- ✅ 5 nuits = durée run complète (non négociable)
- ✅ Système traître aléatoire = engagement clé
- ❌ Pas de multijoueur
- ❌ Pas de plusieurs maps
- ❌ Pas de boss variantes

### Technical constraints
- **30 FPS minimum** Android mid-range (Snapdragon 680+)
- **<5 sec chargement** level
- **0 crash critique** avant release
- **Pas de particules complexes** MVP
- **Memory budget:** <200MB total

### UI/UX
- **Mobile first** (portrait + landscape)
- **Touch targets:** 44x44px minimum
- **Lisibilité:** Petit écran prioritaire
- **Pas d'animations complexes** MVP

### Assets
- **2 graphistes** = pipeline efficace requis
- **Sprites perso + free assets** = hybride
- **Pas de cinématiques** = dialogues simples
- **Style cohérent:** Isométrique type Dofus

### Progression/Économie
- ✅ Gloire + points bon/mauvais (dépensables)
- ✅ Stats achetées restent entre runs
- ✅ Mort moyenne Nuit 2-3 = difficulté OK
- ✅ 3+ runs volontaires = engagement OK
- ❌ Pas d'IAP paywall MVP
- ❌ Cooldown optionnel seulement

## 🚫 Anti-patterns interdits

### Gameplay
- ❌ Pas de progression infinit → Permadeath design
- ❌ Pas de boss faciles → Challenger amusant
- ❌ Pas de 10+ nuits → Keep MVP 5 nuits
- ❌ Pas de 50+ PNJ → 6 PNJ max

### Code
- ❌ Pas de complex state machine → Simple states
- ❌ Pas de 3000+ lignes script → Split concerns
- ❌ Pas de asset loading blocker → Async loading
- ❌ Pas de memory leaks → Test profiling

### Design
- ❌ Pas de UI overwhelming → Clear hierarchy
- ❌ Pas de dialogue 10000 mots → Max 2-3 phrases
- ❌ Pas de feature bloat → Core loop only
- ❌ Pas de balancing forever → "Good enough" MVP

## ✅ Patterns validés

### Gameplay
- ✅ Roguelike cycle day/night → Engagement proven
- ✅ Random traitor system → Replayability spike
- ✅ Simple riddle mechanic → Mystery element
- ✅ Knockback + area attack → Satisfying feedback

### Code
- ✅ Object pooling enemies → Performance boost
- ✅ State-based NPC AI → Manageable complexity
- ✅ Config-driven balance → Tuning sans code
- ✅ Scene instancing → Memory efficient

### Design
- ✅ Virtual joystick mobile → Accessible control
- ✅ Persistent progression → Motivation carrot
- ✅ Glory system → Safe choice mechanic
- ✅ Simple dialogue tree → Clear communication

## 📊 Priorities d'implémentation

### Priority 1 (Day 1-2)
1. Gameplay loop (jour/nuit cycle)
2. Perso déplacement + attack
3. Vagues ennemis spawn
4. Combat basique

### Priority 2 (Day 2-3)
5. UI HUD basique
6. 3 PNJ principaux + shop
7. Système traître aléatoire
8. Progression stats

### Priority 3 (Day 3-4)
9. Énigmes PNJ
10. Boss final Nuit 5
11. Écrans fin run
12. Polish + bugfixes

### Post-MVP
- ❌ Sons/musique (post-launch)
- ❌ Animations polies (post-launch)
- ❌ Particules avancées (post-launch)
- ❌ Tutorial intégré (v1.1)

## 🔍 Definition of Done (MVP)

- ✅ Run complète 5 nuits playable
- ✅ Mort moyenne = Nuit 2-3
- ✅ 0 crash sur test suite
- ✅ 30 FPS stable (30 min session)
- ✅ <5 sec chargement
- ✅ Système traître fonctionne
- ✅ Testeurs font 3+ runs volontairement
- ✅ Code documenté + commits atomiques

## ⏰ Check-in points

**EOD Day 1:** Gameplay loop jour/nuit + perso mvmt + vagues spawn  
**EOD Day 2:** Combat + 3 PNJ + Shop + Traître system  
**EOD Day 3:** UI complète + Énigmes + Boss final  
**EOD Day 4:** Polish + Bugfixes + Performance pass  

## 🎮 Test checklist EOF

- [ ] 5 runs complètes sans crash
- [ ] Mort moyenne Nuit 2-3 (5 runs moyenne)
- [ ] Traître system fonctionne 100%
- [ ] Shop transactions correctes
- [ ] Stats persistance entre runs
- [ ] UI responsive sur Android 480x800 (min)
- [ ] Performance: 30 FPS constant
- [ ] Chargement <5 sec
- [ ] Audio loading non-blocker
- [ ] PNJ dialogues affichés correctement
- [ ] Énigmes valident réponse correctement
- [ ] Boss final killable
- [ ] Gloire/points tally correct
- [ ] No memory leaks 30 min session

---

**🚨 RAPPEL:** Ces contraintes ne sont pas suggestions. Elles définissent le MVP. Avant d'ajouter feature, demander: "Est-ce dans MVP ou post-MVP?"

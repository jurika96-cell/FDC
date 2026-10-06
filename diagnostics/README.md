# FDC javításjelölt – 20261006-B

Ág: `codex/fix-dialog-lifecycle-20261006`.
Kiinduló main commit: `7d7b353ed3a8a0fcc0db8bf32047b6f1568c2879`.

## Változtatások

- Mind a négy dialog az `onLoad` által átadott kijelzővel hívja az inicializáló
  függvényét. Az inicializálók nem keresik többé `findDisplay`-jel a még betöltődő
  kijelzőt.
- A Koordináta inicializáló ugyanazt a kijelzőt adja tovább a mezők elrendezésének.
  A helymeghatározás továbbra is a tűzfeladatból következik, a választó egy elemű
  és letiltott. A felesleges kiválasztás-esemény helyett az elrendezés egyszer fut,
  a Jobbra/Balra és Közelebb/Távolabb listák feltöltése után.
- A Kapcsolatfelvétel listáját kizárólag az `initContactDialog` tölti fel.
  Az inline `spawn` és a koordinátamentés utáni második háttérfolyamat megszűnt.
- A mentések a kattintott gomb szülőkijelzőjét kapják meg. Mentés történik a
  kijelző bezárása előtt; a következő kijelző a saját `onLoad` alatt inicializál.
- Érvényes tűzfeladat nélkül a Tovább gomb a Kapcsolatfelvételen marad, és választást
  kér. A korábbi mentett választást nem írja felül üres szöveggel.
- Az MTO egységlista feltöltés előtt törlődik, így ismételt inicializálás sem
  duplázza meg az egyetlen helyőrző sort. Az MTO továbbra is helyőrző funkció.

Az alap állapotadatok (`FDC_missionType`, `FDC_locationValues`,
`FDC_shiftDirections`, `FDC_targetData`, `FDC_MTOData`) nevei változatlanok.
A mentett koordinátaértékek továbbra is közösek a különböző tűzfeladattípusok
között; ez a javítás nem vezet be külön adattárolást minden típushoz.

## Otthoni próba

1. Erről az ágról készíts PBO-t a szokásos módon, és indítsd újra az Armát.
   A Kapcsolatfelvétel címében `[FIX B]` jelzésnek kell lennie.
2. Belövés → Tovább: csak Y, X, magasság és irányszög látható.
   Írj be négy megkülönböztethető értéket.
3. Vissza: a lista hat elemes és nyitható, a Belövés marad kiválasztva.
   Tovább: az előző négy beírt érték megmarad. Ismételd meg kétszer.
4. Belövés polárisan esetén irányszög, távolság és magasság jelenjen meg.
   Tűzáthelyezés ismert pontról esetén az ismert pont koordinátái, magasság és
   eltérések mellett a két iránylista jelenjen meg; a választások maradjanak meg.
5. A Cél jellege oldalon a három lista legyen feltöltve; onnan a Koordinátára
   visszatérve a megfelelő mezők és beírt adatok maradjanak meg.
6. Ha bármi hibás: a legfrissebb `%LOCALAPPDATA%\Arma 3\*.rpt` fájlt küldd el.
   A jelölt `[FDC FIX 20261006-B]` sorokat ír.

Ez a javításjelölt váltja az előző `[DEBUG A]` diagnosztikai változatot az otthoni
próbában. Nem szükséges mindkettőt futtatni.

## Ellenőrzés és korlát

- `git diff --check`.
- SQF-VM `v2026.04.03-ed9f5f5`, `--parse-only`: a teljes `config.cpp`, az összes
  SQF-fájl és a dialogok összes SQF eseménykezelője szintaktikai hibák nélkül
  feldolgozható. A config relatív include-ját `/FDC` virtuális útvonalon ellenőriztük.
- A kijelzőátadásokat és a mentés → bezárás → új dialog sorrendet átnéztük.

A parser nem futtatja az Arma 3 felületét. A listák tényleges megjelenítését,
a PBO betöltését és a navigáció működését a játékon belüli próba igazolja majd.

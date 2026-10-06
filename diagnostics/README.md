# Kapcsolatfelvétel / visszalépés diagnosztika

Kiinduló verzió: `7d7b353ed3a8a0fcc0db8bf32047b6f1568c2879`.
Diagnosztikai azonosító: `20261006-A`.

Ez a változat naplózást ad az eredeti kódhoz. Megtartja a `findDisplay` használatát,
az eredeti `call`/`spawn` hívásokat, a várakozásokat és az állapotmentést.
Nem tartalmaz működési javítást. A naplózás megváltoztathatja a háttérfolyamatok
időzítését, ezért egy sikeres próba önmagában nem igazolja, hogy a hiba megszűnt.

## Amit a forrás alapján megállapítottunk

- A Koordináta, Cél jellege és MTO `onLoad` közvetlenül hívja az inicializálást.
  A függvények `findDisplay`-jel keresik a még betöltődő kijelzőt, majd `displayNull`
  esetén csendben kilépnek. Ez konkrét életciklus-kockázat. Az `onLoad` már átadja
  a kijelzőt `_this select 0` formában, de az eredeti kód ezt nem használja.
- A Kapcsolatfelvétel külön `spawn` alatt vár a `findDisplay 9100` eredményére.
  Ebből az előző kockázatból önmagában nem következik az első lista üressége.
- A `saveCoordinate` minden mentésnél indít még egy háttérfolyamatot, amely egy
  másodpercig vár a Kapcsolatfelvételre. Visszalépéskor ez és az inline `onLoad`
  is törölheti/újratöltheti ugyanazt a listát. Tovább gombnál is elindul a várakozás.
- `FDC_missionType` csak érvényes és nem üres kiválasztásból kap új értéket.
  A repóban nem találtunk ezt törlő vagy alaphelyzetbe állító utasítást.
- Belövés esetén a mezők logikája Y, X, magasság és irányszög; az ötödik és
  hatodik mezőt, illetve az oldal/távolság irányválasztókat elrejti.
  Ha az inicializálás korán kilép, ez a megjelenítési logika nem fut le.

Bohemia dokumentáció:
- https://community.bistudio.com/wiki/Arma_3:_Event_Handlers/User_Interface
- https://community.bohemia.net/wiki/findDisplay
  A findDisplay oldal közösségi megjegyzése szerint a keresés az onLoad befejezése
  előtt még nem adja vissza az új kijelzőt; ezt a próba a tényleges futásban méri meg.

## Próba Windows alatt

1. Ezt a branch-et csomagold az eddigi módon PBO-ba. Indítsd újra az Arma 3-at
   a diagnosztikai PBO-val, az FDC és ACE szokásos tesztküldetésével.
2. A Kapcsolatfelvétel címében meg kell jelennie a `[DEBUG A]` jelzésnek.
   Ha hiányzik, még nem ezt a konfigurációt futtatod; ilyenkor ne értékeld a próbát.
3. Nyisd meg a Kapcsolatfelvételt. Válaszd a Belövést, majd Tovább.
4. A Koordináta oldalon csak Y, X, magasság és irányszög legyen látható.
5. Vissza: a Kapcsolatfelvételben maradjon Belövés, és a lista legyen nyitható.
   Ismételd meg kétszer. Ha a lista már az első megnyitásnál üres, azt is rögzítsd.
6. Küldd el a legfrissebb `.rpt` fájlt a `%LOCALAPPDATA%\Arma 3` mappából.
   A `[FDC DEBUG 20261006-A]` sorok előtti/közötti SQF- és konfigurációs hibák is
   kellenek, ezért lehetőleg a teljes fájlt küldd.

Ha a napló nem ad elég információt, a `snapshot.sqf` tartalmát az üres felület
nyitva tartása mellett a debug konzolban helyileg futtasd. Ez a betöltött `onLoad`
kódot, a függvények elérhetőségét, a tényleges listaelemeket és vezérlőket is kiírja.

## A napló értelmezése

| Napló | Következtetés |
| --- | --- |
| Az `onLoad` valós `eventDisplay` mellett null `foundDisplay` értéket ír, majd `EXIT displayNull` következik | Az inicializálás túl korán keresi a kijelzőt. |
| `inline contact worker done size=6` | A feltöltés lefutott és hat elem volt a listában ezen a ponton. |
| `inline contact worker enter`, de nincs `found` | A folyamat még a kijelzőre vár, vagy hiba szakította meg; az RPT hibasorait is ellenőrizni kell. |
| `saveContact ... size=0` vagy `sel=-1` | Nem volt érvényes kiválasztás, a korábbi mentett érték marad. |
| Két feltöltés ugyanazzal az `instance` azonosítóval | Ugyanazt a kijelzőpéldányt két folyamat inicializálta. |
| Új `onLoad` eltérő `instance` értékkel | Visszalépéskor új kijelzőpéldány jött létre. |
| `[DEBUG A]` nincs a címben / a snapshot régi onLoad-ot mutat | Másik vagy régi konfiguráció van betöltve. |

Helyi ellenőrzés: diff és szövegszerkezeti ellenőrzés. Arma 3 futtatókörnyezet
nincs itt, ezért a PBO betöltését, a kezelőfelület működését és a diagnózist a
fenti játékon belüli próbával kell igazolni.

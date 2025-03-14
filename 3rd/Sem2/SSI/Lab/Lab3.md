# Criptografie - Rezolvări

# Cerințele pentru acest laborator: [Cerinte Lab 3](./SSI_L3.pdf)

## 1. One Time Pad

### 1.1 
- **Mesaj criptat:** `o9/khC3Pf3/9CyNCbdzHPy5oorccEawZSFt3mgCicRnihDSM8Obhlp3vviAVuBbiOtCSz6husBWqhfF0Q/8EZ+6iI9KygD3hAfFgnzyv9w==`
- **Cheie secretă:** `ecb181a479a6121add5b42264db9b44b4b48d7d93c62c56a3c3e1aba64c7517a90ed44f8919484b6ed8acc4670db62c249b9f5bada4ed474c9e4d111308b614788cd4fbdc1e949c1629e12fa5fdbd9`
- **Proces de decriptare:**
  1. Convertim mesajul criptat din Base64 în hex: `a3dfe4842dcf7f7ffd0b23426ddcc73f2e68a2b71c11ac19485b779a00a27119e284348cf0e6e1969defbe2015b816e23ad092cfa86eb015aa85f17443ff0467eea223d2b2803de101f1609f3caff7`
  3. Aplicăm XOR între mesajul în hex și cheie: `4f6e652054696d6520506164206573746520756e2073697374656d20646520637269707461726520706572666563742073696775722064616361206573746520666f6c6f73697420636f726563742e`
  4. Convertim din hex în text clar
     
    **Mesaj clar:** `One Time Pad este un sistem de criptare perfect sigur daca este folosit corect.`

### 1.2 Există o cheie care ar fi decriptat același text criptat de la pct.1 în textul clar următor? Care este această cheie?

Da, este posibil folosind One Time Pad

Text clar: `Orice text clar poate obtinut dintr-un text criptat cu OTP dar cu alta cheie..`

Pași:
- Aplicăm XOR între mesajul cifrat și textul clar iar rezultatul va fi noua cheie
- **Mesajul cifrat in hex:** `a3dfe4842dcf7f7ffd0b23426ddcc73f2e68a2b71c11ac19485b779a00a27119e284348cf0e6e1969defbe2015b816e23ad092cfa86eb015aa85f17443ff0467eea223d2b2803de101f1609f3caff7`
- **Textul clar in hex:** `4F72696365207465787420636C617220706F617465206F6274696E75742064696E74722D756E20746578742063726970746174206375204F54502064617220637520616C74612063686569652E2E`
- **Cheia rezultată prin XOR:** `a39096ed4eaa5f0b987357620eb0a64d0e18cdd668748c762a2f1ef475d6517d8bea40fedd938fb6e98ac65435db648b4aa4f3bb880dc535e5d1a154279e76478dd703b3def45cc1629905f65981d9`

### 1.3 Ce impact are refolosirea cheii de la pct.1 pentru o altă criptare?
Refolosirea cheii de la punctul 1 pentru o alta criptare ar fi un lucru rau pentru securitate. Nu ar mai respecta proprietatea One Time Pad-ului de a avea key One-Time (de unica folosinta). Daca un adversar are doua mesaje criptate cu aceeasi cheie K, ar putea face XOR pe ele si sa obtina in final plain text. (c1 XOR c2) = (p1 XOR k) XOR (p2 XOR k) = p1 XOR p2

---

## 2. Sisteme de criptare istorice

### 2.1 Cifrul lui Cezar
- **Exemplu criptare:** `Mara Spataru` → `Qeve Wtexevy` (cheie: 4)
- **Exemplu decriptare:** `Ivlzmmi` → `Andreea` (cheie: 8)
- **Explicatie:** Folosind cheia 4 (sau 8 pentru decriptare) vom face shift la toate literele din mesajul plain la dreapta cu 4 pozitii, respectiv 8 pozitii la stânga folosind alfabetul.


- **Securitate:** Foarte slabă, doar 25 de chei posibile, ușor de spart folosind brute-force.
- **Tehnici de criptanaliză:** Brute-force, analiza frecvenței literelor.

### 2.2 Cifrul prin transpoziție pe coloane
- **Text inițial:** `facultatea`
- **Cheie:** `cheie`
  1. Aranjez pe randuri (primul rand = cheia, apoi umplu tabelul cu literele textului criptat)
     CHEIE
     
     FACUL
     
     TATEA
  3. Sortam coloanele in ordinea alfabetica in functie de literele din cheie
     
     CEEHI
     
     FCLAU
     
     TTAAE
  4. Citim pe coloane pentru a avea mesajul criptat
     
	**Mesaj criptat:** `FTCTLAAAUE`

- **Exemplu decriptare:**
  1. Așezăm mesajul în grid
     
     CEEHI
     
     FCLAU
     
     TTAAE
  2. Rearanjăm coloanele astfel încât pe prima linie vom avea cheia noastra

     CHEIE
     
     FACUL
     
     TATEA
  3. Citim pe rânduri și aflăm mesajul
      **FACULTATEA**

- **Securitatea sistemului:** mai sigură decât cifrul lui Cezar, însă depinde de cheie. În cazul acesta, având mai multe chei Brute Force devine mai greu de folosit, dar rămâne încă un atac posibil.
- **Tehnici de criptanaliză:** Reordonarea literelor pentru identificarea cuvintelor comune.

---

## 3. Analiza de frecvență
- **Text criptat analizat:**
```
ENHFJ EWK LML EOJ GDJ BMONKC PMCG YEPMAC FOVQGMROEQDHF FMAQNJ. CHWFJ
GDJHO HWUJWGHMW HW 1978, GDJV DEUJ EG MWFJ LJJW FENNJK HWCJQEOELNJ, EWK
DEUJ LJJW GDJ CALXJFG MY WAPJOMAC KHUMOFJC, GOEUJNC, EWK GMOPJWGC. HW GDJ
JWCAHWR VJEOC, MGDJO FDEOEFGJOC DEUJ XMHWJK GDJHO FOVQGMROEQDHF YEPHNV.
GDJOJC JUJ, GDJ QECCHUJ EWK CALPHCCHUJ JEUJCKOMQQJO, PENNMOV GDJ PENHFHMAC
EGGEFTJO, EWK GOJWG, GOACGJK LV ENN, XACG GM WEPJ E YJB. BDHNJ ENHFJ, LML, EWK
GDJHO JSGJWKJK YEPHNV BJOJ MOHRHWENNV ACJK GM JSQNEHW DMB QALNHF TJV
FOVQGMROEQDV BMOTC, GDJV DEUJ CHWFJ LJFMPJ BHKJNV ACJK EFOMCC MGDJO
CFHJWFJ EWK JWRHWJJOHWR KMPEHWC. GDJHO HWYNAJWFJ FMWGHWAJC GM ROMB
MAGCHKJ MY EFEKJPHE EC BJNN: ENHFJ EWK LML EOJ WMB E QEOG MY RJJT NMOJ, EWK
CALXJFG GM WEOOEGHUJC EWK UHCAEN KJQHFGHMWC GDEG FMPLHWJ QJKERMRV
BHGD HW-XMTJC, MYGJW OJYNJFGHWR MY GDJ CJSHCG EWK DJGJOMWMOPEGHUJ
JWUHOMWPJWGC HW BDHFD GDJV BJOJ LMOW EWK FMWGHWAJ GM LJ ACJK. PMOJ GDEW
XACG GDJ BMONKC PMCG YEPMAC FOVQGMROEQDHF FMAQNJ, ENHFJ EWK LML DEUJ
LJFMPJ EW EOFDJGVQJ MY KHRHGEN JSFDEWRJ, EWK E NJWC GDOMARD BDHFD GM UHJB
LOMEKJO KHRHGEN FANGAOJ. I.KAQMWG EWK E.FEGGEQEW FOVQGMFMAQNJ
```
- **Descifrare parțială prin analiză de frecvență:**
  - `GDJ` apare frecvent → probabil `THE`
  - `EWK` → probabil `AND`
  - `GM` → probabil `TO`
  - Se înlocuiesc și se verifică restul literelor pentru a reconstitui textul original.
- **Mesaj descifrat:** `ALICE AND BOB ARE THE WORLDS MOST FAMOUS CRYPTOGRAPHIC COUPLE. SINCE THEIR INVENTION IN 1978, THEY HAVE AT ONCE BEEN CALLED INSEPARABLE, AND HAVE BEEN THE SUBJECT OF NUMEROUS DIVORCES, TRAVELS, AND TORMENTS. IN THE ENSUING YEARS, OTHER CHARACTERS HAVE JOINED THEIR CRYPTOGRAPHIC FAMILY. THERES EVE, THE PASSIVE AND SUBMISSIVE EAVESDROPPER, MALLORY THE MALICIOUS ATTACKER, AND TRENT, TRUSTED BY ALL, JUST TO NAME A FEW. WHILE ALICE, BOB, AND THEIR EXTENDED FAMILY WERE ORGINALLY USED TO EXPLAIN HOW PUBLIC KEY CRYPTOGRAPHY WORKS, THEY HAVE SINCE BECOME WIDELY USED ACROSS OTHER SCIENCE AND ENGINEERING DOMAINS. THEIR INFLUENCE CONTINUES TO GROW OUTSICE OF ACADEMIA AS WELL: ALICE AND BOB ARE NOW A PART OF GEEK LORE, AND SUBJECT TO NARRATIVES AND VISUAL DEPICTIONS THAT COMBINE PEDAGOGY WITH IN-JOKES, OFTEN REFLECTING OF THE SEXIST AND HETERONORMATIVE ENVIRONMENTS IN WHICH THEY WERE BORN AND CONTINUE TO BE USED. MORE THAN JUST THE WORLDS MOST FAMOUS CRYPTOGRAPHIC COUPLE, ALICE AND BOB HAVE BECOME AN ARCHETYPE OF DIGITAL EXCHANGE, AND A LENS THROUGH WHICH TO VIEW BROADER DIGITAL CULTURE. Q.DUPONT AND A.CATTAPAN CRYPTOCOUPLE
`

---

## 4. Enigma
### 4.1 Configurația folosită (cheia zilei 1 mai 1941)
- **Rotoare:** V I IV
- **Ring Settings:** P L Y (16 12 25)
- **Plugboard:** AU BY CH DQ EF IO JN KL MR PW
- **Poziția inițială:** WZA

### 4.2 Criptare
- **Text inițial:** `MARAANDREEA`
- **Rezultat criptare:** `ENQFN FIGIH L`

### 4.3 Decriptare
- **Pentru a decripta textul ”ENQFNFIGIHL” și a obține numele meu am procedat astfel:**
  1. Am configurat mașina Enigma cu aceleași stări folosite pentru criptare
     
       Rotoare: V I IV
     
       Ring Settings: P L Y (16 12 25)
     
       Plugboard: AU BY CH DQ EF IO JN KL MR PW
     
       Initial Position: WZA
  3. Am introdus textul criptat `ENQFNFIGIHL`
  4. Mașina a generat textul decriptat `MARAA NDREE A`


### 4.4 Exemplu de text criptat de aceeași lungime, dar care nu ar putea fi criptarea numelui `MARA ANDREEA`
- **Exemplu:** `MARABNCGHQW`
- **Motiv:** Enigma nu criptează niciodată o literă în ea însăși din cauza modului în care Plugboard-ul este proiectat.


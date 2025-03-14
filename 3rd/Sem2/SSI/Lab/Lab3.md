# Criptografie - Rezolvări

## 1. One Time Pad

### 1.1 
- **Mesaj criptat:** `o9/khC3Pf3/9CyNCbdzHPy5oorccEawZSFt3mgCicRnihDSM8Obhlp3vviAVuBbiOtCSz6husBWqhfF0Q/8EZ+6iI9KygD3hAfFgnzyv9w==`
- **Cheie secretă:** `ecb181a479a6121add5b42264db9b44b4b48d7d93c62c56a3c3e1aba64c7517a90ed44f8919484b6ed8acc4670db62c249b9f5bada4ed474c9e4d111308b614788cd4fbdc1e949c1629e12fa5fdbd9`
- **Proces de decriptare:**
  1. Convertim mesajul criptat din Base64 în hex: `a3dfe4842dcf7f7ffd0b23426ddcc73f2e68a2b71c11ac19485b779a00a27119e284348cf0e6e1969defbe2015b816e23ad092cfa86eb015aa85f17443ff0467eea223d2b2803de101f1609f3caff7`
  3. Aplicăm XOR între mesajul în hex și cheie: `4f6e652054696d6520506164206573746520756e2073697374656d20646520637269707461726520706572666563742073696775722064616361206573746520666f6c6f73697420636f726563742e`
  4. Convertim din hex în text clar
- **Mesaj clar:** `One Time Pad este un sistem de criptare perfect sigur daca este folosit corect.`

### 1.2 
Există o cheie care ar fi decriptat același text criptat de la pct.1 în textul clar următor?
Care este această cheie?

Da, este posibil folosind One Time Pad

Text clar: `Orice text clar poate obtinut dintr-un text criptat cu OTP dar cu alta cheie..`

Pași de urmat:
- Aplicăm XOR între mesajul cifrat și textul clar iar rezultatul va fi noua cheie
- **Mesajul cifrat in hex:** `a3dfe4842dcf7f7ffd0b23426ddcc73f2e68a2b71c11ac19485b779a00a27119e284348cf0e6e1969defbe2015b816e23ad092cfa86eb015aa85f17443ff0467eea223d2b2803de101f1609f3caff7`
- **Textul clar in hex:** `4F72696365207465787420636C617220706F617465206F6274696E75742064696E74722D756E20746578742063726970746174206375204F54502064617220637520616C74612063686569652E2E`
- **Cheia rezultată prin XOR:** `a39096ed4eaa5f0b987357620eb0a64d0e18cdd668748c762a2f1ef475d6517d8bea40fedd938fb6e98ac65435db648b4aa4f3bb880dc535e5d1a154279e76478dd703b3def45cc1629905f65981d9`

### 1.3 Ce impact are refolosirea cheii de la pct.1 pentru o altă criptare?
Refolosirea cheii de la punctul 1 pentru o alta criptare ar fi un lucru rau pentru securitate. Nu ar mai respecta proprietatea One Time Pad-ului de a avea key One-Time (de unica folosinta). Daca un adversar are doua mesaje criptate cu aceeasi cheie K, ar putea face XOR pe ele si sa obtina in final plain text-ul. (c1 XOR c2) = (p1 XOR k) XOR (p2 XOR k) = p1 XOR p2

---

## 2. Sisteme de criptare istorice

### 2.1 Cifrul lui Cezar
- **Exemplu criptare:** `Mara Spataru` → `Qeve Wtexevy` (cheie: 4)
- **Exemplu decriptare:** `Ivlzmmi` → `Andreea` (cheie: 8)
- **Explicatie:** Folosind cheia 4, vom face shift la toate literele din mesajul plain la dreapta cu 4 pozitii folosind alfabetul.

- **Exemplu de decriptare:**
- **Securitate:** Foarte slabă, doar 25 de chei posibile, ușor spargibil prin brute-force.
- **Tehnici de criptanaliză:** Brute-force, analiza frecvenței literelor.

### 2.2 Cifrul prin transpoziție pe coloane
- **Text inițial:** `facultatea`
- **Cheie:** `cheie`
- **Mesaj criptat:** `FTCTLAAAUE`
- **Proces de criptare:**
  1. Se scrie textul pe rânduri sub cheie.
  2. Se sortează coloanele conform ordinii alfabetice a cheii.
  3. Se citește pe coloane.
- **Tehnici de criptanaliză:** Reordonarea literelor pentru identificarea cuvintelor comune.

---

## 3. Analiza de frecvență
- **Text criptat analizat:**
```
ENHFJ EWK LML EOJ GDJ BMONKC PMCG YEPMAC ...
```
- **Descifrare parțială prin analiză de frecvență:**
  - `GDJ` apare frecvent → probabil `THE`
  - `EWK` → probabil `AND`
  - `GM` → probabil `TO`
  - Se înlocuiesc și se verifică restul literelor pentru a reconstitui textul original.
- **Mesaj descifrat:** `ALICE AND BOB ARE THE WORLDS MOST FAMOUS CRYPTOGRAPHIC COUPLE...`

---

## 4. Enigma
### 4.1 Configurația folosită
- **Rotoare:** V I IV
- **Ring Settings:** P L Y (16 12 25)
- **Plugboard:** AU BY CH DQ EF IO JN KL MR PW
- **Poziția inițială:** WZA

### 4.2 Criptare
- **Text inițial:** `MARAANDREEA`
- **Rezultat criptare:** `ENQFNFIGIHL`

### 4.3 Decriptare
- **Rezultatul după decriptare:** `MARAANDREEA`

### 4.4 Exemplu de text criptat invalid
- **Exemplu:** `MARABNCGHQW`
- **Motiv:** Enigma nu criptează niciodată o literă în ea însăși.


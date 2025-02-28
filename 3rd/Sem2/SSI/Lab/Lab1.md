# LAB 1 SSI

# Cerințele pentru acest laborator: [Cerinte Lab 1](./cerinte_lab1.pdf)

## 1. Potrivire răspunsuri

- A - 3  
- B - 1  
- C - 5  
- D - 2  
- E - 4  

## 2. Reflecție asupra interviului

Dupa vizionarea interviului am înțeles că există două aspecte importante în securitate: **cum gândește un atacator** și **care sunt limitele etice și legale**.

1. Pentru a securiza un sistem trebuie să gândești ca un atacator, adică să nu vezi lucrurile doar cum ar trebui să funcționeze normal, ci să te gândești și la **edge-case-uri**, locuri unde pot apărea probleme. Atacatorii caută mereu nu doar punctele slabe, ci pe cele **mai slabe**.
2. Mai importantă este mentalitatea de a te pune în pielea unui atacator, deoarece *tehnicalitățile* se pot învăța ulterior. Este esențial să poți anticipa problemele care pot apărea.

Din punct de vedere etic, este justificat să gândești ca un atacator atât timp cât scopul final este **protejarea sistemelor**.

---

## 3. Conversii numerice

### Conversia 23 din baza 10 în baza 2

23 / 2 → **1**  
11 / 2 → **1**  
5 / 2 → **1**  
2 / 2 → **0**  
1 / 2 → **1**  
0  

**23 în baza 10 = 10111 în baza 2**

### Conversia inversă (binar → zecimal)

| Puteri ale lui 2 | 4 | 3 | 2 | 1 | 0 |
|-----------------|---|---|---|---|---|
| Binar          | 1 | 0 | 1 | 1 | 1 |

**1 × 2⁴ + 0 × 2³ + 1 × 2² + 1 × 2¹ + 1 × 2⁰**  
= 16 + 0 + 4 + 2 + 1 = **23**

### Conversia A3F7 din hexa în binar

| Hexa | Decimal | Binar |
|------|---------|-------|
| A    | 10      | 1010  |
| 3    | 3       | 0011  |
| F    | 15      | 1111  |
| 7    | 7       | 0111  |

**A3F7 = 1010 0011 1111 0111 în binar**

### Conversia inversă (binar → hexa)

| Binar  | Decimal | Hexa |
|--------|---------|------|
| 1010   | 10      | A    |
| 0011   | 3       | 3    |
| 1111   | 15      | F    |
| 0111   | 7       | 7    |

Deci **1010 0011 1111 0111 în binar = A3F7 în hexa**.

---

## 4. Codificare ASCII

### Transformare text → ASCII

- **MARA** → 77 65 82 65
- **ASCII 66 82 65 86 79** → **BRAVO**

---

## 5. Codificare Base64

### Transformare „SPATARU” în Base64

| Litera | ASCII | Binar |
|--------|-------|-------|
| S      | 83    | 1010011 |
| P      | 80    | 1010000 |
| A      | 65    | 1000001 |
| T      | 84    | 1010100 |
| A      | 65    | 1000001 |
| R      | 82    | 1010010 |
| U      | 85    | 1010101 |

Binar grupat în câte 6 biți:

```
010100 110101 000001 000001 | 010101 000100 000101 010010 | 010101 01xxxx
```

Conversie în Base64:

**SPATARU = U1BBVEFSVVEg**

### Decodificare Base64

**„U3VudCBzdHVkZW50IGxhIEZNSS4=”**

Transformăm din Base64 în binar, apoi grupăm în octeți și transformăm în caractere ASCII:

**„Sunt student la FMI.”**

---

## 6. Tipuri de malware

- **Malware** - bucata de program sau hardware inclus intenționat cu scopuri rele
- **Virus** - program care infectează alte fișiere/programe
- **Dropper** - instalează malware fără permisiune
- **Downloader** - descarcă malware de pe internet
- **Trojan** - pare inofensiv, dar ascunde funcții malițioase
- **Spyware** - colectează date fără consimțământ
- **Riskware** - software legitim, dar exploatabil
- **Ransomware** - blochează fișierele și cere bani
- **Adware** - afișează reclame nedorite
- **Worm** - se răspândește automat în rețea
- **Obfuscare** - face codul mai greu de înțeles

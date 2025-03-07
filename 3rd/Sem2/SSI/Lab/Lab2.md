# LAB 2 SSI - Introducere în criptologie

# Cerințele pentru acest laborator: [Cerinte Lab 2](./SSI_L2.pdf)


## 1. Noțiuni generale
- A - 4
- B - 2
- C - 5
- D - 1
- E - 6
- F - 3

## 2. Triada CIA
1. Salariile angajaților nu trebuie făcute publice.  
   **Confidențialitate**
2. Biroul casierie trebuie să aibă acces la salariile angajaților (pentru a realiza plățile).  
   **Disponibilitate**
3. Un angajat nu își poate modifica singur suma primită ca salariu pe luna în curs.  
   **Integritate**
4. Un angajat nu ar trebui să afle cât câștiga un coleg fără acordul acestuia (ex. să îi spună direct).  
   **Confidențialitate**
5. Biroul casierie trebuie să aibă certitudinea că suma pe care o înmânează angajatului de plată este cea corectă.  
   **Integritate**

Primitive criptografice pentru confidențialitate: criptare simetrică (AES)  
Primitive criptografice pentru integritate: funcții hash

## 3. Adversar Probabilistic Polinomial în Timp (PPT)
1. Un adversar care are la dispoziție un timp infinit pentru criptanaliza unui sistem este un adversar PPT.  
   **Fals** - PPT are doar timp polinomial
2. Un adversar PPT are dreptul de a „ghici" cheia.  
   **Adevărat** - de aici vine probabilistic
3. Un adversar PPT are la dispoziție algoritmi exponențiali în timp.  
   **Fals** - dacă ar avea ar ghici cam toate cheile

## 4. Funcții neglijabile
1. f(n) = 2  
   **Nu e neglijabilă**
2. f(n) = 1/2000  
   **Nu e neglijabilă**
3. f(n) = 1/n²⁰⁰⁰  
   **Nu e neglijabilă**
4. f(n) = 1/2ⁿ  
   **E neglijabilă**
5. f(n) = f1(n) + f2(n), unde f1(n) și f2(n) sunt neglijabile  
   **E neglijabilă**
6. f(n) = f1(n) + f2(n), unde f1(n) este neglijabilă și f2(n) este ne-neglijabilă  
   **Nu e neglijabilă**

## 5. Securitate computațională
De ce preferăm securitatea computațională față de cea perfectă?
- Securitatea perfectă e imposibilă din cauza că ar fi nevoie de chei la fel de lungi ca mesajele.
- Securitatea computațională permite utilizare de chei de dimensiuni decente, rezonabile.
- Astfel, sistemele cu securitate computațională sunt mai eficiente.
- Securitatea computațională oferă un compromis între nivelul de securitate și eficiența resurselor și deși nu dă șanse 0% unui adversar pentru atac, oferă șanse foarte mici de reușită (atât de mici încât e foarte improbabil a fie realizate).

## 6. Atac prin forță brută
Pentru un sistem cu o cheie de 512 biți:
- Numărul de chei posibile distincte: 2^512 
- Timp necesar pentru găsirea cheii corecte dacă testează 2^30 chei pe secundă: 2^512/2^30 = 2^(512-30) = 2^482 secunde. Asta ar însemna 3.9569742 × 10^137 ani - foarte mult
- În general poate fi, dar în acest caz categoric nu, deoarece timpul necesar pentru a testa toate cheile este atât de mare încât depășește un timp practicabil pentru un atac.

# Laborator 6 - Generatoare de numere pseudo-aleatoare (PRNG)

# Cerințele pentru acest laborator: [Cerinte Lab 6](./SSI_L6.pdf)

### 1. Noțiuni introductive

**De ce secventele de cod nu definesc un PRNG?**

**Candidate 1**:

- Folosește o operație simplă de putere (seed*seed) care creează pattern-uri previzibile
- Va duce rapid la overflow sau va converge la 0 pentru multe valori inițiale
- Secvența nu are o distribuție uniformă
- Perioada este foarte scurtă înainte de a se repeta sau de a ajunge la valori degenerate

**Candidate 2**:

- Funcția este prea simplă și previzibilă (adăugarea a jumătate din valoarea curentă)
- Creează un pattern de creștere liniară în loc de ceva pseudo-aleator
- Are proprietăți statistice slabe pentru a fi aleator
- Secvența va crește rapid peste limite sau va converge

**Candidate 3**:

- Nu generează o secvență, doar efectuează o singură deplasare la dreapta cu 2 biți
- Nu se menține nicio stare între apeluri
- Produce un singur output deterministic bazat pe input

### 2. Secrets.py

```python
import secrets
import string
import hashlib
import base64

#1 generarea unei parole securizate
def genereaza_parola(lungime=10):
    #Genereaza o parola securizata care include cel putin o litera mare, o litera mica, o cifra si un caracter special
    
    caractere = string.ascii_lowercase + string.ascii_uppercase + string.digits + ".!$@"
    
    #ne asiguram ca avem cel putin unul din fiecare tip
    parola = []
    parola.append(secrets.choice(string.ascii_uppercase))  #litera mare
    parola.append(secrets.choice(string.ascii_lowercase))  #litera mica
    parola.append(secrets.choice(string.digits))           #o cifra
    parola.append(secrets.choice(".!$@"))                  #caracter special
    
    #completam pana la lungimea dorita
    for i in range(lungime - 4):
        parola.append(secrets.choice(caractere))
    
    #amestecam caracterele
    secrets.SystemRandom().shuffle(parola)
    
    return ''.join(parola)


#2 generarea unui string URL-safe
def genereaza_url_safe(lungime=32):
    #genereaza un string URL-safe de lungimea specificata
    return secrets.token_urlsafe(lungime)


#3 generarea unui token hexazecimal
def genereaza_token_hex(lungime=32):
    #genereaza un token hexazecimal de lungimea specificata
    #lungimea in bytes (2 char hex = 1 byte)
    return secrets.token_hex(lungime // 2)


#4 verificare securizata impotriva atacurilor de timp
def compara_secvente(secv1, secv2):
    #compara 2 secvente in mod securizat impotriva atacurilor de timp
    return secrets.compare_digest(secv1, secv2)


#5 generarea unei chei fluide binare
def genereaza_cheie(lungime=32):
    #Genereaza o cheie binara pentru criptare
    return secrets.token_bytes(lungime)


#6 stocarea parolelor in mod securizat
def stocheaza_parola(parola, username):
    #stocheaza o parola in mod securizat folosind salt si hash
    #generam un salt aleator
    salt = secrets.token_bytes(16)
    
    #combinam parola cu salt-ul si aplicam hash
    hash_parola = hashlib.pbkdf2_hmac(
        'sha256',                #alg de hash
        parola.encode('utf-8'),  #convertim parola in bytes
        salt,                    #salt-ul aleator
        100000                   #numarul de iteratii
    )
    
    #return salt-ul & hash-ul
    return salt, hash_parola


#use cases
if __name__ == "__main__":
    
    #1
    parola = genereaza_parola(12)
    print(f"Parola generata: {parola}")
    
    #2
    url_token = genereaza_url_safe()
    print(f"Token URL-safe: {url_token}")
    
    #3
    hex_token = genereaza_token_hex()
    print(f"Token hexazecimal: {hex_token}")
    
    #4
    str1 = "string_de_test"
    str2 = "string_de_test"
    str3 = "string_diferit"
    print(f"Comparaie securizata '{str1}' cu '{str2}': {compara_secvente(str1, str2)}")
    print(f"Comparatie securizata '{str1}' cu '{str3}': {compara_secvente(str1, str3)}")
    
    #5
    cheie = genereaza_cheie()
    print(f"Cheie binara generata (base64): {base64.b64encode(cheie).decode('utf-8')}")
    
    #6
    username = "student_info"
    salt, hash_parola = stocheaza_parola(parola, username)
    
    print(f"\nStocarea parolei pentru utilizatorul '{username}'")
    print(f"Salt (base64): {base64.b64encode(salt).decode('utf-8')}")
    print(f"Hash parola (base64): {base64.b64encode(hash_parola).decode('utf-8')}")
```

**Funcționalitățile implementate:**

1. **Generarea unei parole securizate**:
   - Scenariu de utilizare: Înregistrarea utilizatorilor noi într-un site web, unde sistemul oferă o parolă inițială sigură.
   - Importanță: Ajută utilizatorii să folosească parole puternice și diverse.
     
2. **Generarea unui string URL-safe**:
   - Scenariu de utilizare: Crearea link-urilor pentru resetarea parolei sau confirmarea contului prin email.
   - Importanță: Asigură că link-urile sunt unice și nu pot fi ghicite.

3. **Generarea unui token hexazecimal**:
   - Scenariu de utilizare: Generarea de chei de API pentru integrări cu servicii externe.
   - Importanță: Permite autentificarea sigură a aplicațiilor care folosesc API-ul.

4. **Compararea securizată împotriva atacurilor de timp**:
   - Implementare: Folosirea secrets.compare_digest() pentru compararea securizată
   - Importanță: Previne atacurile care măsoară timpul de răspuns pentru a ghici parole sau token-uri.

5. **Generarea unei chei fluide binare**:
   - Implementare: Folosirea secrets.token_bytes() pentru generarea unei chei aleatorii.
   - Importanță: Asigură confidențialitatea și integritatea datelor transmise.

6. **Stocarea securizată a parolelor**:
   -Implementare: Folosirea PBKDF2 cu salt și iterații multiple.
   - Alegerea acestei metode: Este recomandată de experți în securitate deoarece:
     - Salt pentru a preveni atacurile precalculate.
     - Iterații multiple pentru a încetini atacurile brute force
     - Este un standard testat si acceptat in industrie

### 3. CVE, CWE, CAPEC

**Problemele identificate în secvențele de cod:**
- În exemplul din Java (Figura 1), programul folosește mereu același număr (1234567890) ca punct seed pentru generarea numere aleatorii.
- În exemplul din PHP (Figura 2), programul folosește ID-ul utilizatorului ca punct de start pentru generarea numerelor aleatorii.

**De ce sunt probleme de securitate:**
- Dacă folosim mereu același număr ca punct de start, vom obține mereu aceeași secvență de numere "aleatorii", ceea ce nu e random.
- Dacă folosim ID-ul utilizatorului, care este ușor de ghicit, atacatorul poate prezice ce numere "aleatorii" vom genera.

**CWE ID asociat:**
- CWE-336: "Același Seed în Generator de Numere Pseudo-Aleatoare (PRNG)" - această vulnerabilitate apare când folosim mereu același punct de start (seed) pentru generarea numerelor aleatorii.

**Ce se întâmplă dacă seed-ul se schimbă, dar poate avea doar valori dintr-un set mic:**
- CWE ID asociat: CWE-335: "Utilizare Incorectă a Seed-urilor în Generator de Numere Pseudo-Aleatoare" - această vulnerabilitate apare când avem un număr prea mic de valori posibile pentru seed.
- Acest ID clasifică problema când folosim un seed care, deși se schimbă, poate lua valori dintr-un set prea mic de opțiuni.

**Mențiuni despre seed în CAPEC:**
- CAPEC este un catalog de tehnici de atac.
- În CAPEC-112 (Brute Force) și CAPEC-307 (Variabile de Stare Predictibile), se descrie cum atacatorii pot exploata seed-uri slabe.
- Aceste cataloage explică cum un atacator poate încerca toate seed-urile posibile dacă sunt puține, sau poate prezice valorile generate dacă seed-ul este predictibil.

**Alte probleme cu generatoarele de numere aleatorii (PRNG):**
- CWE-338: "Utilizarea unui Generator de Numere Pseudo-Aleatoare (PRNG) Criptografic Slab" - când algoritmul folosit pentru generare nu este suficient de sigur pentru scopuri de securitate.
- CWE-331: "Entropie Insuficientă" - când nu avem suficient random real în sistem pentru a genera numere cu adevărat imprevizibile.
- CWE-337: "Seed Predictibil în Generator de Numere Pseudo-Aleatoare" - când seed-ul poate fi ghicit de un atacator.

**Vulnerabilități reale (CVE) legate de PRNG:**
- CVE (Common Vulnerabilities and Exposures) sunt probleme concrete descoperite în produse software reale.
- În ultimul an, s-au descoperit aproximativ 5-10 vulnerabilități care implică implementări defectuoase ale generatoarelor de numere aleatorii.
- Aceste probleme apar în special în sisteme de autentificare, librării criptografice și generatoare de token-uri de securitate.

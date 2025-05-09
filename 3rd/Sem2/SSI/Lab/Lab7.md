# Laborator - Funcții Hash și Stocarea Parolelor

# Cerințele pentru acest laborator: [Cerinte Lab 7](./SSI_L7.pdf)

## 1. Noțiuni introductive - Răspunsuri adevărat/fals

a) Amestecarea ingredientelor pentru realizarea unei prăjituri poate fi considerată one-way function.
**Adevărat** - Procesul este ireversibil, similar cu o funcție one-way.

b) Funcția hash MD5 este considerată sigură la coliziuni.
**Fals** - MD5 a fost compromisă în ceea ce privește rezistența la coliziuni, fiind găsite coliziuni practice încă din anii 2000.

c) SHA256 este o funcție hash cu output pe 256 biți.
**Adevărat** - SHA256 produce o valoare hash de exact 256 biți.

d) Valoarea hash SHA-1 pentru cuvantul „laborator" este 0x4bcc6eab9c4ecb9d12dcb0595e2aa5fbc27231f3.
**Adevărat** - Aceasta este valoarea corectă a hash-ului SHA-1 pentru cuvântul "laborator".

e) Este corect să afirmăm că „o funcție hash criptează".
**Fals** - Funcțiile hash nu criptează informația, ci o transformă într-o amprentă digitală de dimensiune fixă. Criptarea presupune o chei și posibilitatea de decriptare.

f) O funcție hash folosită pentru stocarea parolelor trebuie să fie rapidă (i.e., să se calculeze rapid H(x) pentru x dat).
**Fals** - Funcțiile hash folosite pentru parole ar trebui să fie deliberat lente pentru a face atacurile prin forță brută mai dificile.

g) Hash-ul (fără salt) - 095b2626c9b6bad0eb89019ea6091bd9 – corespunde unei parole sigure, care nu ar fi susceptibilă spre exemplu la un atac de tip dicționar.
**Fals** - Acest hash MD5 corespunde parolei "password", care este una dintre cele mai comune și slabe parole. Un atac de tip dicționar ar găsi-o imediat.

## 2. Securitatea funcției hash PHOTON-80/20/16

## Etape de rezolvare

Am urmat pașii aceștia pentru a analiza securitatea funcției hash PHOTON-80/20/16 și a verifica posibilitatea găsirii coliziunilor:

### 1. Compilarea implementării

Am compilat implementarea PHOTON-80 folosind optimizarea bazată pe tabele, conform cerințelor din laborator:

```bash
gcc -D_PHOTON80_ -D_TABLE_ photon.c photondriver.c -o photon80 sha2.c timer.c helper.c -O3
```

### 2. Testarea vitezei de execuție

Am executat programul cu opțiunea `-s` pentru a măsura performanța funcției hash:

```bash
./photon80 -s
```

Rezultatul arată o viteză de aproximativ 323 de cicluri per byte, ceea ce indică o implementare eficientă a funcției hash. 

### 3. Generarea datelor de intrare

Pentru a testa rezistența la coliziuni, am creat un script Python pentru a genera aproximativ 10 milioane de valori de intrare distincte:

```python
with open('input.txt', 'w') as f:
    # Generăm 10 milioane de intrări unice de forma "photon" + contor
    for i in range(10000000):
        f.write(f"photon{i}\n")
```

### 4. Calculul valorilor hash

Am executat programul cu opțiunea `-f` pentru a calcula valorile hash pentru toate valorile de intrare generate:

```bash
./photon80 -f
```

Procesul a creat fișierul `output.txt` care conține pentru fiecare linie de intrare valoarea sa hash corespunzătoare.

### 5. Verificarea coliziunilor

Am implementat un script Python pentru a verifica dacă există coliziuni între hash-urile calculate:

```python
#fctie pentru a citi hash-urile din fisier
def read_hashes(filename):
    hashes = {}
    with open(filename, 'r') as f:
        lines = f.readlines()
        # Sărim prima linie (header)
        for line in lines[1:]:
            parts = line.strip().split(' ::::: ')
            if len(parts) == 2:
                input_val = parts[0]
                hash_val = parts[1]
                if hash_val in hashes:
                    print(f"COLIZIUNE GASITA!")
                    print(f"Input 1: {hashes[hash_val]}")
                    print(f"Input 2: {input_val}")
                    print(f"Valoare hash: {hash_val}")
                    return True, hash_val, hashes[hash_val], input_val
                hashes[hash_val] = input_val
    return False, None, None, None, len(hashes)

# Verifica coliziunile in output.txt
collision, hash_val, input1, input2, count = read_hashes('output.txt')
if not collision:
    print(f"Nu au fost găsite coliziuni în cele {count} valori hash")

# Verifica daca exista coliziuni fata de valorile din output_test.txt
print("\nVerificam coliziuni cu valorile din output_test.txt...")
test_hashes = {}
with open('output_test.txt', 'r') as f:
    lines = f.readlines()
    # Sărim prima linie (header)
    for line in lines[1:]:
        parts = line.strip().split(' ::::: ')
        if len(parts) == 2:
            input_val = parts[0]
            hash_val = parts[1]
            test_hashes[hash_val] = input_val

# acum verificam daca vreun hash din output.txt exista si în output_test.txt
collision_count = 0
with open('output.txt', 'r') as f:
    lines = f.readlines()
    # sarim prima linie (header)
    for line in lines[1:]:
        parts = line.strip().split(' ::::: ')
        if len(parts) == 2:
            input_val = parts[0]
            hash_val = parts[1]
            if hash_val in test_hashes:
                collision_count += 1
                print(f"COLIZIUNE cu testul!")
                print(f"Input nostru: {input_val}")
                print(f"Input test: {test_hashes[hash_val]}")
                print(f"Valoare hash: {hash_val}")

if collision_count == 0:
    print("Nu au fost gasite coliziuni cu valorile de test")
```

## Rezultate și analiză

### Rezultatele obținute

După verificarea celor 10 milioane de valori hash generate, **nu am găsit nicio coliziune**. De asemenea, nu am găsit coliziuni între valorile noastre și cele din fișierul `output_test.txt`.

### Analiza matematică a probabilității de coliziune pentru PHOTON-80

**Date inițiale:**

- PHOTON-80 generează un hash de 80 de biți
- Spațiul posibil de valori este de 2^80 (aproximativ 1.2 × 10^24)
- Am generat aproximativ 10 milioane (10^7) de valori

Probabilitatea de coliziune:
Conform **principiului zilei de naștere**, probabilitatea de a găsi o coliziune între 10^7 valori într-un spațiu de 2^80 este extrem de mică, aproximativ 4.1 × 10^-11 (sau 0.000000000041%). Această probabilitate este practic neglijabilă.

**Numărul de valori necesare pentru o coliziune:**
Pentru a avea o **șansă de 50% de a găsi o coliziune** pentru o funcție hash de 80 de biți, ar trebui să generăm aproximativ 2^40 (circa 1 trilion) de valori diferite. Acest număr este de aproximativ 100.000 de ori mai mare decât cele 10 milioane de valori pe care le-am generat.
Deci, era de așteptat să nu găsim nicio coliziune, deoarece am testat doar o fracțiune foarte mică din numărul de valori necesare.

## Concluzie

Nu am reușit să găsesc nicio coliziune în cele aproximativ 10.000.000 de valori generate. Acest rezultat era de așteptat din următoarele motive:

1. Spațiul de hash pentru PHOTON-80 este de 2^80 (aproximativ 1.2 × 10^24) valori posibile
2. Pentru a avea o șansă de 50% de a găsi o coliziune (conform teoremei zilei de naștere), am avea nevoie de aproximativ 2^40 (aproximativ 1.1 × 10^12) valori
3. 10.000.000 de valori reprezintă doar o fracțiune minusculă din 2^40, astfel încât probabilitatea de a găsi o coliziune este extrem de mică (~4.1 × 10^-11)
4. Spațiul de hash (2^80) este de aproximativ 10^10 ori mai mare decât pătratul numărului de valori generate (10^14)

Pentru a găsi o coliziune, ar trebui să generăm mai multe valori și să folosim algoritmi eficienți de detectare a coliziunilor, ceea ce ar necesita resurse computaționale semnificativ mai mari.

Această analiză demonstrează că funcția hash PHOTON-80, cu un output de 80 de biți, oferă o rezistență bună la coliziuni pentru volumul de date testate, în concordanță cu principiile teoretice ale securității funcțiilor hash.


## 3. Stocarea parolelor

### Exemplul 1
```java
@PostMapping("/url")
public ArrayList<String> crypt(@RequestBody Users json) {
    final String secretKey = "bettysuper";
    Iterable<Users> all_users = getAllUsers();
    for (Users user:all_users) {
        uncrypted_message = user.getPassword();
        encryptedmessage = enc.encrypt(uncrypted_message,secretKey);
        list_of_enc_passw.add(encryptedmessage);
    }
    return list_of_enc_passw;
}
```

**Vulnerabilități identificate:**
1. **Cheie hardcodată**: Cheia secretă "bettysuper" este direct în cod, e expusă în cazul accesului la cod
2. **Utilizarea criptării în loc de hashing**: Parolele sunt criptate, nu hașuite, ceea ce este greșit în stocarea parolelor
3. **Lipsa salt-ului**: Nu se folosește salt, ceea ce face parolele vulnerabile la unele atacuri
4. **Expunerea parolelor criptate**: Lista de parole criptate este returnată ca răspuns API, expunând potențial informații sensibile

### Exemplul 2
```python
def creeazaCont():
    userName = input("Username: ")
    password = input("Password: ")
    hashedUsername = bcrypt.hashpw(userName.encode('utf-8'), bcrypt.gensalt())
    hashedPassword = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    existaDeja = 0
    for i in range(len(listaConturi)):
        if bcrypt.checkpw(userName.encode('utf-8'), listaConturi[i].userName):
            existaDeja = 1
            print("acest user exista deja!")
            meniu()
    if existaDeja == 0:
        print("Contul a fost creat cu succes")
        listaConturi.append(cont(hashedUsername, hashedPassword))
        meniu()
```

**Vulnerabilități identificate:**
1. **Hashing incorect al numelui de utilizator**: Numele de utilizator este hașuit cu bcrypt, ceea ce este ineficient și inutil - numele de utilizator ar trebui stocate în text clar pentru autentificare
2. **Verificare incorectă a unicității**: Se compară username-ul introdus cu hash-urile stocate, ceea ce va eșua aproape întotdeauna

### Exemplul 3
```csharp
[HttpPost]
[AllowAnonymous]
[ValidateAntiForgeryToken]
public async Task<ActionResult> Register(RegisterViewModel model)
{
    if (ModelState.IsValid)
    {
        var user = new ApplicationUser { UserName = model.Name, Email = model.Email, Name = model.Name };
        SHA256 sha = SHA256.Create();
        
        //transformam in binar si criptam
        byte[] binar = sha.ComputeHash(Encoding.UTF8.GetBytes(model.Password));
        
        //transformam textul criptat in hexadecimal
        StringBuilder b = new StringBuilder();
        for(int i=0; i<binar.Length; i++)
            b.Append(binar[i].ToString("x2"));
        string pass = b.ToString();
        
        var result = await UserManager.CreateAsync(user, pass);
        if (result.Succeeded)
            return RedirectToAction("Index", "Home");
        AddErrors(result);
    }
    return View(model);
}
```

**Vulnerabilități identificate:**
1. **Algoritm de hash inadecvat**: SHA256 este rapid și vulnerabil la atacuri de forță brută pentru parole
2. **Lipsa salt-ului**: Nu se folosește salt, făcând hash-urile vulnerabile la unele atacuri
3. **Implementare incorectă**: Hash-ul hexadecimal este folosit ca parolă pentru creare (nu pentru verificare), ceea ce este conceptual greșit

### Exemplul 4
```
# Security settings
app.config['SECURITY_CHANGEABLE'] = True
app.config['SECURITY_CONFIRMABLE'] = False
app.config['SECURITY_EMAIL_SENDER'] = ('TOIT', 'contact@toit.ro')
app.config['SECURITY_RECOVERABLE'] = True
app.config['SECURITY_PASSWORD_HASH'] = 'bcrypt'
app.config['SECURITY_PASSWORD_SALT'] = '       '

# Security email settings
app.config['SECURITY_EMAIL_SUBJECT_REGISTER'] = 'Bine ai venit!'
app.config['SECURITY_EMAIL_SUBJECT_CONFIRM'] = 'Parola ta a fost schimbata'
app.config['SECURITY_EMAIL_SUBJECT_PASSWORD_RESET'] = 'Reseteaza-ti parola'
app.config['SECURITY_EMAIL_SUBJECT_PASSWORD_CHANGE_NOTICE'] = 'Parola ta a fost schimbata'
```

**Vulnerabilități identificate:**
1. **Salt static**: Salt-ul pentru bcrypt este hardcodat în loc să fie generat aleator pentru fiecare parolă
2. **Configurare slabă**: Confirmarea prin email este dezactivată (SECURITY_CONFIRMABLE = False), permițând crearea de conturi fără validarea email-ului
3. **Salt global**: Se folosește același salt pentru toate parolele, în loc de un salt unic pentru fiecare parolă

### Exemplul 5
```csharp
public static string MD5Hash(string parola)
{
    //calculeaza hash
    MD5 md5 = new MD5CryptoServiceProvider();
    md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(parola));
    
    //stocheaza parola
    // ...
}
```

**Vulnerabilități identificate:**
1. **Algoritm nesigur**: MD5 este nesigur pentru stocarea parolelor, fiind vulnerabil la coliziuni și atacuri
2. **Encoding limitat**: Se folosește ASCIIEncoding în loc de UTF8, limitând caracterele posibile în parole
3. **Lipsa salt-ului**: Nu se folosește salt, făcând hash-urile vulnerabile la atacuri de tip rainbow table
4. **Implementare incorectă**: Rezultatul operației hash nu este utilizat (nici returnat, nici stocat)


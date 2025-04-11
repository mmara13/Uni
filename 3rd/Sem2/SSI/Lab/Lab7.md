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

### Analiza matematică a probabilității de coliziune pentru PHOTON-80

**Date inițiale:**
- PHOTON-80 generează un hash de 80 de biți
- Spațiul posibil de valori este de 2^80 ≈ 1.2 × 10^24
- Generate aproximativ 10 milioane (10^7) de valori

**Principiul zilei de naștere:**
Acest principiu ne ajută să calculăm probabilitatea de coliziune când selectăm aleatoriu valori dintr-un set. Pentru o funcție hash ideală, probabilitatea de a găsi o coliziune după generarea a k valori este aproximativ:

P(coliziune) ≈ 1 - e^(-k²/(2n))

Unde:
- k = numărul de valori generate
- n = dimensiunea spațiului de valori posibile (2^80 în cazul nostru)

**Calculul:**
Pentru k = 10^7 și n = 2^80:

P(coliziune) ≈ 1 - e^(-(10^7)²/(2×2^80))
P(coliziune) ≈ 1 - e^(-(10^14)/(2×2^80))

Conversia în aceeași bază:
2^80 ≈ 1.2 × 10^24
10^14 ≈ 2^46.5

P(coliziune) ≈ 1 - e^(-(2^46.5)/(2×2^80))
P(coliziune) ≈ 1 - e^(-(2^46.5)/(2^81))
P(coliziune) ≈ 1 - e^(-2^(46.5-81))
P(coliziune) ≈ 1 - e^(-2^(-34.5))

Deoarece 2^(-34.5) este extrem de mic:
P(coliziune) ≈ 1 - (1 - 2^(-34.5)) = 2^(-34.5) ≈ 4.13 × 10^(-11)

**Interpretare:**
Probabilitatea de a găsi o coliziune după generarea a 10 milioane de valori este aproximativ 4.13 × 10^(-11), sau 0.0000000000413. Foarte mică, deci nu ar trebui să existe coliziuni.

**Pentru a avea o șansă de 50% de a găsi o coliziune:**
Conform principiului zilei de naștere, ar trebui să generăm aproximativ √(n × ln(2)) valori.

Pentru n = 2^80: √(2^80 × ln(2)) ≈ √(2^80 × 0.693) ≈ 0.833 × 2^40 ≈ 9.2 × 10^11

Deci, pentru a avea o probabilitate de 50% de a găsi o coliziune, ar trebui să generăm aproximativ 2^40 ≈ 1.1 × 10^12 valori, care este cu mai multe ordine de magnitudine mai mare decât cele 10 milioane generate.

**Intuitiv:**
Spațiul de hash (2^80) este de aproximativ 10^10 ori mai mare decât pătratul numărului de valori generate (10^14), ceea ce face ca probabilitatea de coliziune să fie extrem de mică. Deci, la volumul acesta de date este de așteptat să nu existe coliziuni.

### Concluzie pentru întrebarea: "Ați reușit să găsiți o coliziune? Vă așteptați la acest rezultat? De ce/de ce nu?"

Nu, nu am reușit să găsesc o coliziune în cele aproximativ 10.000.000 de valori generate. Acest rezultat era de așteptat din următoarele motive:

1. Spațiul de hash pentru PHOTON-80 este de 2^80 (aproximativ 1.2 × 10^24) valori posibile
2. Pentru a avea o șansă de 50% de a găsi o coliziune (conform teoremei zilei de naștere), am avea nevoie de aproximativ 2^40 (aproximativ 1.1 × 10^12) valori
3. 10.000.000 de valori reprezintă doar o fracțiune minusculă din 2^40, astfel încât probabilitatea de a găsi o coliziune este extrem de mică (~4.1 × 10^-11)
4. Spațiul de hash (2^80) este de aproximativ 10^10 ori mai mare decât pătratul numărului de valori generate (10^14)

Pentru a găsi o coliziune, ar trebui să generăm multe ordine de magnitudine mai multe valori și să folosim algoritmi eficienți de detectare a coliziunilor, ceea ce ar necesita resurse computaționale semnificativ mai mari.

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


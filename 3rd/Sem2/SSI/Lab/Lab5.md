# Laboratorul 5 - Analiză de Scripturi

# Cerințele pentru acest laborator: [Cerinte Lab 5](./SSI_L5.pdf)

## Exercițiul 1: Analiza fișierului sample1.js folosind NodeJS

### a. Ce face acest cod?
Codul folosește o tehnică de obfuscare pentru a crea un mesaj ascuns. După interpretare, afișează 3 linii de text: numele facultății, al universității și un link de YouTube care duce către "rickroll, but it never starts 10 HOURS".

### b. Cum am ajuns la această concluzie?
Am observat că în urma executării în interpretorul Node.js, codul generează output-ul:
```
Facultatea de Matematica si Informatica
Universitatea din Bucuresti
https://www.youtube.com/watch?v=HIcSWuKMwOw
```
Practic, codul folosește obfuscarea pentru ascunderea mesajului real.

### c. Care este mesajul ascuns?
Mesajul ascuns este:
```
Facultatea de Matematica si Informatica
Universitatea din Bucuresti
https://www.youtube.com/watch?v=HIcSWuKMwOw
```

### d. Cine a realizat acest cod (în acest format)?
Dacă analizăm codul, se poate observa că mesajul a fost obfuscat folosind tehnica "jjencode" creată de Yosuke Hasegawa. Acest tip de obfuscator este recunoscut prin utilizarea simbolului "$".

## Exercițiul 2: Analiza fișierului sample2.js

### a. Ce face acest cod? Justificați!
Codul arată un mesaj fals că utilizatorul a fost "hacked" și încearcă să scrie un fișier pe disc. Este un exemplu de script care folosește o tehnică de obfuscare folosind funcția `eval` și un decodor personalizat.

La executare, scriptul:
1. Afișează mesaje de avertizare false ("You have been hacked!")
2. Încearcă să creeze un fișier numit "fmi.txt" cu textul "Bun venit la acest laborator :)"
3. Încearcă să modifice atributele acestui fișier
4. Dacă procesul eșuează, afișează "Do not worry. Ghosts do not exist!"

Codul care face aceste operații:
```javascript
var obj = new ActiveXObject("Scripting.FileSystemObject");
var out = obj.OpenTextFile("./fmi.txt", 2, true, 0);
out.WriteLine("Bun venit la acest laborator :)");
out.Close();
var fle = obj.GetFile("./fmi.txt");
fle.attributes = 2
```

### b. Putem să considerăm că acest fișier este malware?
Nu, nu poate fi considerat un fișier malware adevărat deoarece doar imită comportamentul unui malware, iar operațiile de fișier sunt inofensive. Scriptul conține și mesajul "Acesta nu este un malware. Dispozitivul nu este compromis".

### c. Cine a realizat acest cod?
Codul conține stringuri care indică că a fost creat de Facultatea de Matematică și Informatică, Universitatea din București.

## Exercițiul 3: Analiza fișierului sample3.js

### a. Ce face acest cod? Justificați!
Acest cod este similar cu cel anterior, dar folosește o metodă diferită de obfuscare. Încearcă să afișeze mesaje false de "hacking" și să creeze un fișier text pe disc.

Funcționalitatea este aceeași:
1. Afișează mesaje de avertizare false
2. Încearcă să creeze un fișier "fmi.txt" cu textul "Bun venit la acest laborator :)"
3. Încearcă să modifice atributele fișierului
4. Dacă operațiunea eșuează, afișează un mesaj de liniștire

### b. Explicați conținutul de tipul '\x$$'. Ce sunt aceste valori?
Aceste valori sunt șiruri de caractere codificate în format hexa. '\x' este prefixul în JavaScript pentru reprezentarea caracterelor folosind codul lor hexa. De ex, '\x59' reprezintă caracterul 'Y'.

Această metodă de codare hexazecimală este folosită pentru a ascunde textul simplu și a face codul mai dificil de citit pentru oameni. În acest fișier, toate mesajele scriptului sunt stocate în array-ul `_0x1d78` folosind această reprezentare hexa.

### c. În urma unei analize dinamice observăm un comportament asemănător cu primul sample. Care este diferența dintre cele două sample-uri?
Diferența principală dintre sample3.js și sample1.js constă în metoda de obfuscation folosită:

1. Fișierul sample1.js folosește o metodă de obfuscare bazată pe encodări folosind caractere precum `[]()!+$` (tehnica jjencode)
2. Fișierul sample3.js folosește o metodă bazată pe array-uri și caractere în format hexazecimal ('\x$$')

De asemenea, sample3.js încearcă să interacționeze cu sistemul de fișiere (similar cu sample2.js), în timp ce sample1.js doar afișează mesaje și un link.

## Exercițiul 4: Analiza fișierului sample4.js

### a. Ce face acest script?
Acest script încearcă să downloadeze și să execute un fișier DLL potențial dăunător. Scriptul:
1. Conține multe comentarii codificate în Base64 pentru a ascunde adevărata intenție
2. Creează un obiect ActiveX pentru a interacționa cu sistemul
3. Definește funcții pentru a decoda și scrie un fișier binar (libmingwex-0.dll) în directorul temporar
4. Încearcă să execute un fișier "hello.exe" din directorul temporar
5. Afișează "Hello!" dacă execuția eșuează

### b. Cum putem extrage payload-ul fără să rulăm scriptul (doar din analiză statică)?
Putem extrage payload-ul prin decodarea stringului lung Base64 care începe cu "TVqQAAMAAAAEAAAA".

Prin folosirea unui decoder Base64 se poate observa că acest fișier rezultat pare a fi un DLL care folosește MinGW. DLL-ul conține strings precum "hello world!". Analiza payload-ului confirmă că acest fișier încearcă să scrie un fișier DLL pe disc și apoi să execute un program.

### c. Putem considera acest script că este malware?
Da, acest script poate fi considerat malware deoarece:
1. Încearcă să decodeze și să scrie un fișier DLL în directorul temporar
2. Execută un fișier executabil potențial dăunător
3. Folosește tehnici de obfuscation pentru a ascunde adevărata intenție (comentarii Base64)

### d. Căutați/Încărcați acest fișier pe VirusTotal. Ce observați? În urma raportului de pe VirusTotal cum încadrați acest sample până la urmă (malware/benign)?
În urma raportului obținut, fișierul a fost identificat ca malware de 26 din 69 de motoare de scanare.

Observații importante:
1. Cele mai multe detecții îl clasifică ca fiind un troian sau downloader
2. Etichetele populare sunt "trojan.cbum/xibow"
3. Categoriile de amenințare identificate sunt "trojan" și "downloader"
4. Familiile de malware identificate sunt "cbum" și "xibow"

Detalii specifice despre detecții:
- Microsoft îl identifică ca "TrojanDownloader:JS/Xibow.J"
- Kaspersky îl identifică ca "HEUR:Trojan.Script.Generic"
- Avast/AVG îl identifică ca "VBS:Downloader-ANE [Trj]"

Analiza arată clar că acest fișier este malware.

### e. Folosiți tool-ul pentru a obfusca scriptul. Salvați rezultatul într-un fișier javascript și încărcați acest fișier pe VirusTotal. Ce observații notabile puteți face? Explicați!
Pe baza raportului obținut după obfuscarea fișierului, pot face următoarele observații:

1. Scriptul obfuscat este detectat doar de 5 din 69 de motoare (față de 26/69 cum era anterior)
2. Multiple motoare importante nu mai detectează malware-ul (Microsoft, Avast, AVG, BitDefender, etc.)
3. Există și motoare care sunt persistente în detectarea malware-ului (Google, Kaspersky, Ikarus, DrWeb, Kingsoft)
4. S-au schimbat categoriile: scriptul original avea etichete clare cbum/xibow, versiunea obfuscată are doar eticheta generică "Trojan"

Explicație:
Diferența semnificativă în detectare dintre cele două versiuni demonstrează eficiența tehnicilor de obfuscare în evadarea sistemelor antivirus. Obfuscarea modifică aspectul codului (semnăturile) păstrând funcționalitatea.
În concluzie, obfuscarea a redus semnificativ rata de detecție a malware-ului, demonstrând că aceeași funcționalitate malițioasă poate evada multe sisteme de securitate doar prin modificarea aspectului său, fără schimbarea comportamentului efectiv.

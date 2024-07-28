//ALG GENETIC - max polinom
#include <bits/stdc++.h>
using namespace std;

ifstream fin("f.in");

int d1,d2; //capetele domeniului
int a,b,c; //parametrii pentru polinom
int dim; //dimensiunea populatiei
double p,pc,pm;//probabilitati - discretizare, crossover+ incrucisare si mutatie
int nr_gen; //nr de generatii la care ne oprim
vector<double> X; //vectorul cu valorile x
vector<string> binary_val; //vectorul cu codificarile binare
string best_binary_val; //codul binar al individului cu best fit
double best_X; //numarul (x) al best fit individual
int l; //nr subintervale



double f_random(double min, double max, double precision) //functie pt random ca sa
//ne dea numere reale din range ul min max cu precizie setata
{
    random_device rd; //seed din hardware ca sa produca valori cat mai random
    mt19937 gen(rd()); //initializam Mersenne Twister PRNG
    uniform_real_distribution<double> dist(min,max); //definim distributia
    double random = dist(gen);
    return round(random*pow(10,precision)) / pow(10,precision);
} 

double fitness(int a, int b, int c, double x){ //functia de fitness (polinomul) cu parametri dati
    double result = a*pow(x,2)+b*x+c;
    return result;
}

string toBinary(double nr, int l, double a, double b){
    //calculam pasul de discretizare
    double step = (b-a)/(pow(2,l)-1);

    //convertim nr real la un int care reprez subintervalul caruia apartine numarul
    long long x = round((nr-a)/step);

    //convertim int la binary folosind bitset
    bitset<64> binary(x);
    //daca x e 0 returnam sir de 0
    if(x==0) return string(l, '0');
    //returnam sirul binar - pastrand doar ultimii l biti
    return binary.to_string().substr(64-l, l);
}

double fromBinary(string binary, double a, double b, int l){
    //convertim cromozomul inapoi la int
    long long x = 0;
    for(int i = 0; i<binary.length(); i++){
        if(binary[i] == '1')
            x += pow(2,binary.length() - i - 1);
    }
    //calculam pasul de discretizare
    double step = (b-a)/(pow(2,l) -1);
    //convertire inapoi la nr real
    double nr = a+x*step;
    return nr;
}

pair<vector<pair<double, string>>,pair<string,double>> selection(vector<double>& X, vector<string>& binary_val, int a, int b, int c, int dim, int nr_pas){
    //calculam fitnessul total al populatiei
    double total_fitness = 0;
    for(int i = 0; i < dim; i++){
        total_fitness += fitness(a,b,c,X[i]);
    }

    //calculam probab de selectie ca fiind fitnesul individului curent / fitnessul total
    vector<double> selection_prob(dim);
    for(int i = 0; i < dim; i++)
        selection_prob[i] = fitness(a,b,c,X[i])/total_fitness;

    //daca suntem la prima generatie dupa cea random afisam detalii
    if(nr_pas == 1) {
        cout<<"Probabilitati selectie\n";
        for(int i = 0; i < dim; i++){
            cout<<"cromozom "<<i+1<<" probabilitate "<<selection_prob[i]<<'\n';
        }

        cout<<"\nIntervale probabilitati selectie\n";
        double cum_prob = 0; //intervalele de selectie incep de la 0 apoi se aduna probabilitatea individului
        for(int i = 0;i < dim; i++){
            cout<<cum_prob<< " " << cum_prob + selection_prob[i]<<" ";
            cum_prob += selection_prob[i];
        }
        cout<<'\n';
    }

    //selectia cu criteriul ruletei
    //vectori pt indivizii noii populatii
    vector<double> X_new(dim-1); // dim-1 ptc salvam best individual separat
    vector<string> binary_val_new(dim-1);
    for (int i = 0; i < dim-1; i++){   //selectam doar n-1 indivizi pentru ca pe cel cu best fit il pastram intr-o copie separata
        double r = ((double) rand() / (RAND_MAX)); //val intre 0 si 1 pt a compara probab
        double cum_prob = 0; //probab cumulativa
        for (int j = 0; j < dim; j++){  
            cum_prob += selection_prob[j]; //daca r <= cum_prob selectam individul
            if(r <= cum_prob) { //selectarea individului
                X_new[i] = X[j];
                binary_val_new[i] = binary_val[j];
                //afisari prima generatie 
                if(nr_pas == 1){
                    cout<<"u="<<fixed<<setprecision(16)<<r << " selectam cromozomul "<< j+1 <<'\n';
                }
                break; //ne oprim din a selecta urmatorii indivizi atata timp cat unul a fost deja selectat
            }
        }
    }
        
    //gasim cel mai bun individ
    double best_fitness = -INFINITY;
    double best_X;
    string best_binary_val;
    for(int i = 0; i < dim; i++){
        double crt_fitness = fitness(a,b,c,X[i]); //cautam in X[i] adica populatia curenta nu cea modif mai sus
        if(crt_fitness > best_fitness){
            best_fitness = crt_fitness;
            best_X = X[i];
            best_binary_val = binary_val[i];
        }
    }

    if(nr_pas == 1) cout<<"\nDupa selectie:\n"; //afisam titlul aici
    //ca sa afisam detaliile in for mai jos
   
    //returnam pop noua
    vector<pair<double, string>> new_population(dim);
    for(int i = 0; i < dim-1; i++){ //dim -1 - pentru ca selectia a selectat doar dim-1 indivizi
        //facem perechi ca sa returnam toata pop odata
        new_population[i] = make_pair(X_new[i], binary_val_new[i]); 
        
        //afisari dupa selectie pt pop noua - doar pt prima gen
        if(nr_pas == 1){
            cout<<i+1<<": "<<binary_val_new[i]<<" x= "<<fixed<<setprecision(6)<<X_new[i];
            cout<<" f="<<fitness(a,b,c,X_new[i])<<'\n';
        }
    }
    if(nr_pas == 1) { //afisam la final si best individual
        cout<<dim<<": "<<best_binary_val<<" x= "<<fixed<<setprecision(6)<<best_X;
        cout<<" f="<<fitness(a,b,c,best_X)<<'\n';
    }
    return make_pair(new_population,make_pair(best_binary_val,best_X));
}

//functie pentru crossover
vector<string> crossover(const vector<string>& generation, double crossover_probab, int nr_gen){
    vector<pair<string,int>> interm_gen; //in interm_gen vom salva doar cromozomii alesi pentru crossover
    vector<string> new_gen; //in new_gen vom salva toti cromozomii de dupa crossover (cei incrucisati + cei nemodificati)
    
    //populam interm_gen cu cromozomii selectati pentru crossover
    if(nr_gen == 1) {
        cout<<defaultfloat; //resetam precizia pt probabilitate (ptc u si x si f au precizii diferite)
        cout<<"\nProbabilitatea de incrucisare "<<crossover_probab<<'\n';
    } //afisam asta doar pt prima gen
    
    for (int i = 0; i < generation.size(); i++) { //parcurgem cromozomii din generatia data la crossover (cea de dupa selectie)
        double u = f_random(0.0, 1.0, 16); //generam u pentru fiecare cromozom
        if(nr_gen == 1) { //daca suntem la prima generatie afisam atat cromozomul cat si valoarea u
            cout<<i+1<<": "<<generation[i]<<" u="<<fixed<<setprecision(16)<<u;
            if(u < crossover_probab) { //daca u < decat probabilitatea de crossover inseamna ca va participa
                cout<<defaultfloat;
                cout<<"<"<<crossover_probab<<" participa\n"; }//verificam aici pentru ca altfel ar trb sa scriem mai mult
            //in if-ul de jos
            else cout<<'\n';//daca nu afisam ca participa, sa trecem la randul urmator pentru cromozomul urmator
        }
        if (u < crossover_probab) { //if separat pentru ca cel de sus era doar pt prima generatie
            interm_gen.push_back(make_pair(generation[i], i)); //adaugam cromozomul la interm_gen ptc a fost selectat
        }
    }

    //generam copii si ii adaugam la noua generatie
    for (int i = 0; i < interm_gen.size(); i += 2) {
        if (i + 1 < interm_gen.size()) { //ne asiguram ca exista perechi pentru crossover (i.e exista mai mult de un cromozom)
        
            //cazul in care interm_gen.size e par si facem cate doi
            string parent1 = interm_gen[i].first; 
            string parent2 = interm_gen[i+1].first;
            int crossover_pct = static_cast<int>(f_random(0, parent1.size(), 0)); //static cast ptc f_random returneaza double

            //crossover pentru doi parinti
            string offspring1 = parent1.substr(0, crossover_pct) + parent2.substr(crossover_pct);
            string offspring2 = parent2.substr(0, crossover_pct) + parent1.substr(crossover_pct);
            
            //adaugam copiii la noua generatie
            new_gen.push_back(offspring1);
            new_gen.push_back(offspring2);
            
            //afisare detaliata pentru prima generatie
            if(nr_gen == 1){
                cout<<"Recombinare dintre cromozomul "<<interm_gen[i].second+1<<" cu cromozomul "<<interm_gen[i+1].second+1<<":\n";
                cout<<parent1<<" "<<parent2<<" punct  "<<crossover_pct<<'\n';
                cout<<"Rezultat     "<<offspring1<<" "<<offspring2<<'\n';
            }
        }
    }
    
    //folosim unordered set ca sa verificam mai usor daca un element exista in multime
    unordered_set<int> crossover_indices; //verificam care cromozomi au participat la crossover ca sa nu ii adaugam la noua gen
    //pentru ca ei deja o sa fie "adaugati" (copiii lor)
    for(int i = 0; i < interm_gen.size(); i++){ //parcurgem cromozomii alesi pentru crossover
        if(i % 2 == 0 && i + 1 < interm_gen.size()){ //ne asiguram ca mai exista perechi la fel ca mai sus cand am facut copiii
        
            //inseram indicii cromozomilor care au fost modificati in crosssover
            crossover_indices.insert(i); 
            crossover_indices.insert(i+1);
        }
    }

    //daca numarul de copii e mai mic decat dim generatiei, atunci adaugam restul cromozomilor(cei nemodificati)
    for (int i = 0; i < generation.size(); i++) { //parcurgem toata generatia data ca parametru functiei
        if(crossover_indices.find(i) == crossover_indices.end()) //daca indivele nu se gaseste in multime 
            new_gen.push_back(generation[i]); //atunci adaugam cromozomul asa cum a fost el dat
    }


    //afisare populatie dupa crossover - pt prima generatie
    if(nr_gen == 1){
        cout<<"\nDupa recombinare:\n";
        int indice = 1;
        for(auto crom : new_gen){ //parcurgem toti cromozomii din generatia noua (modificata)
            double x = fromBinary(crom,d1,d2,l); //declaram x aici ca sa fie mai usor la afisare
            cout<<indice<<": "<<crom<<" x="<<fixed<<setprecision(6)<<x; //afisam indice cromozom x si fitness
            cout<<" f="<<fitness(a,b,c,x)<<'\n';
            indice++;
        }
    }
    return new_gen; //returnam generatia dupa crossover
}

//functia pt mutation
vector<string> mutation(vector<string>& generation, double mutation_probab, int nr_gen) {
    
    vector<string> mutated_generation = generation; //facem o copie a generatiei primita ca parametru (cea de dupa crossover)
    set<int> cromozomi_mutati; //facem o multime pentru cromozomii mutati ca sa stim indecsii celor care au fost mutati
        
    if (nr_gen == 1) { //daca suntem la prima generatie afisam detalii
        cout << defaultfloat; //resetam precizia
        cout << "\nProbabilitate de mutatie pentru fiecare gena " << mutation_probab << '\n';
        cout << "Au fost modificati cromozomii:\n";
    }
    
    bool mutated[dim] = {0}; //flag ca sa retinem daca cromozomul a fost mutat
    for (int i = 0; i < mutated_generation.size(); i++) { //parcurgem cromozomii din generatie
        for (int j = 0; j < mutated_generation[i].size(); j++) { //parcurgem stringul binar
            double u = f_random(0.0, 1.0, 16); //generam valoarea u pt fiecare gena ca sa vedem daca va avea loc mutatia sau nu
            if (u < mutation_probab) { //daca da
                mutated_generation[i][j] = (mutated_generation[i][j] == '0') ? '1' : '0'; //schimbam bitul acelei gene
                mutated[i] = true; //il marcam ca modificat
                break; //ca sa nu mai modificam inca o data acelasi cromozom (putem elimina asta in cazul in care un cromozom permite mutatii multiple)
            }
        }
        if (mutated[i]) { //daca cromozomul respectiv a fost mutat
            if (nr_gen == 1) 
                cout << i+1 << '\n'; //pentru ca porneste de la 0 dar cromozomii sunt de la 1
            cromozomi_mutati.insert(i); //salvam indexul cromozomului mutat
        }
    }
    
    //afisam cromozomii mutati pentru prima generatie
    if (nr_gen == 1) {
        cout << defaultfloat; //resetam precizia
        int index = 1;
        cout << "\nDupa mutatie:\n";
        for (int i = 0; i < generation.size(); i++) {
            if (mutated[i]) { //daca cromozomul a fost mutat atunci il afisam din mutated[generation]
                cout << index << ": " << mutated_generation[i] << " x=" << fixed << setprecision(6) << fromBinary(mutated_generation[i], d1, d2, l);
                cout << " f=" << fitness(a, b, c, fromBinary(mutated_generation[i], d1, d2, l)) << '\n';
            } else { //altfel il afisam asa cum era el in generation (generatia data ca parametru)
                cout << index << ": " << generation[i] << " x=" << fixed << setprecision(6) << fromBinary(generation[i], d1, d2, l);
                cout << " f=" << fitness(a, b, c, fromBinary(generation[i], d1, d2, l)) << '\n';
            }
            index++;
        }
    }

    
    //actualizam generatia cu cromozomii mutati
    for(auto index : cromozomi_mutati)
        generation[index] = mutated_generation[index];
    
    return generation; //returnam generatia dupa etapa de mutatie

}

int main(){
    fin>>dim; //citire dimensiune populatie
    fin>>d1>>d2; //capetele intervalului de definire
    fin>>a>>b>>c; //parametrii polinomului
    fin>>p>>pc>>pm; //precizia, probabilitatea de recombinare si probabilitatea de mutatie
    fin>>nr_gen; //numarul de generatii
    
    //initializare seed pt valorile random
    srand(time(nullptr)); //bazat pe timpul curent
    
    vector<pair<double,double>> max_fitness_evolution; //vector pt a stoca valorile pt best fit individual la fiecare gen
    
    //folosind formula din curs calculam lungimea cromozomilor
    double nr_subintervale = ((d2-d1)*pow(10,p));
    l = ceil(log2(nr_subintervale));
    
    //punem aici titlul pentru ca oricum in forul care urm nu vom afisa altceva decat prima populatie
    cout<<"Populatia initiala\n";
    for(int i = 0; i < dim; i++) //generam valori random pt indivizi
    {
        double x = f_random(d1,d2,p);
        X.push_back(x); //adaugam in vectorul generatiei 
        
        //codificare x
        binary_val.push_back(toBinary(x,l,d1,d2)); //adaugam si codurile binare ale acestor indivizi
        
        //afisarea primei generatii
        cout<<i+1<<": "<<binary_val[i]<<" x= "<<fixed<<setprecision(6)<<x;
        cout<<" f="<<fitness(a,b,c,x)<<'\n';
    } 
    cout<<'\n';
    
    for(int i = 1; i <= nr_gen; i++){ //prelucram generatia i
    
        //selectie de tip elitist - ruleta
        //trimitem si i ptc daca suntem la prima generatie sa afisam mai multe info
        auto result = selection(X, binary_val, a,b,c,dim, i);
        vector<pair<double,string>> new_population = result.first;
        best_binary_val = result.second.first; //returnam best individual separat ptc asa am gandit functia si ca sa fie mai usor 
        //sa il identificam inainte de a modifica prima generatie
        best_X = result.second.second;
        
        
        //actualizam X si binary_val cu noua populatie - despartim perechea
        for(int j = 0; j < dim-1; j++){
            X[j] = new_population[j].first;
            binary_val[j] = new_population[j].second;
        }
    
        //adaugam best individual la noua generatie
        X[dim - 1] = best_X;
        binary_val[dim - 1] = best_binary_val;
        
        //facem crossover
        vector<string> binary; //punem in vectorul asta codurile binare ale generatiei
        for(int j = 0; j < dim; j++){
            binary.push_back(binary_val[j]);
        }
        auto offspring = crossover(binary, pc, i);
        
        //actualizam X si binary_val cu noii copii (cei rezultati dupa crossvoer)
        for(int j = 0; j < offspring.size(); j++){
            X[j] = fromBinary(offspring[j], d1, d2, l);
            binary_val[j] = offspring[j];
        }
        
        //etapa de mutation
        vector<string> mutated_generation = mutation(binary_val, pm, i);
        double max_X = 0;
        //evolutia maximului
        double max_fitness = -INFINITY;
        for(int j = 0; j < dim; j++){
            double current_fitness = fitness(a,b,c,X[j]);
            if(current_fitness > max_fitness)
                max_fitness = current_fitness;
                max_X = X[j];
        }
        max_fitness_evolution.push_back(make_pair(max_fitness, max_X)); //adaugam in vector fiecare valoarea a lui best individual dupa fiecare generatie
    }
    cout<<"\nEvolutia maximului:\n";
    for(auto fit : max_fitness_evolution)
        cout<<"f= "<<fit.first<<" x="<<fit.second<<'\n';
    
    return 0;
}
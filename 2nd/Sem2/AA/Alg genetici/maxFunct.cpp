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


double f_random(double min, double max, double precision) //functie pt random ca sa
//ne dea numere reale din range ul min max cu precizie setata
{
    double range = max - min;
    double div = pow(10,precision);
    double random = min + (rand() /(RAND_MAX/range));
    return round(random*div)/div;
} 

double fitness(int a, int b, int c, double x){
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

vector<pair<double, string>> selection(vector<double>& X, vector<string>& binary_val, int a, int b, int c, int dim, int nr_pas){
    //calculam fitnessul total al populatiei
    double total_fitness = 0;
    for(int i = 0; i < dim; i++){
        total_fitness += fitness(a,b,c,X[i]);
    }

    //calculam probab de selectie 
    vector<double> selection_prob(dim);
    for(int i = 0; i < dim; i++)
        selection_prob[i] = fitness(a,b,c,X[i])/total_fitness;

    //daca suntem la prima generatie dupa cea random afisam detalii
    if(nr_pas == 1) {
        cout<<"Probabilitati selectie\n";
        for(int i = 0; i < dim; i++){
            cout<<"cromozom "<<i+1<<" probabilitate "<<selection_prob[i]<<'\n';
        }

        cout<<"Intervale probabilitati selectie\n";
        double cum_prob = 0;
        for(int i = 0;i < dim; i++){
            cout<<cum_prob<< " " << cum_prob + selection_prob[i]<<" ";
            cum_prob += selection_prob[i];
        }
        cout<<'\n';
    }

    //selectia cu criteriul ruletei
    //vectori pt indivizii noii populatii
    vector<double> X_new(dim-1); //ptc salvam best individual
    vector<string> binary_val_new(dim-1);
    for (int i = 0; i < dim-1; i++){
        double r = ((double) rand() / (RAND_MAX)); //val intre 0 si 1 pt a compara probab
        double cum_prob = 0; //probab cumulativa
        for (int j = 0; j < dim; j++){  
            cum_prob += selection_prob[j]; //daca r <=cum_prob selectam individul
            if(r <= cum_prob) {
                X_new[i] = X[j];
                binary_val_new[i] = binary_val[j];

                //afisari prima gen
                if(nr_pas == 1){
                    cout<<"u=" << r << " selectam cromozomul "<< j+1 <<'\n';
                }

                break;
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
    //adaugam cel mai bun individ la pop noua
    X_new.push_back(best_X);
    binary_val_new.push_back(best_binary_val);

    if(nr_pas == 1) cout<<"Dupa selectie:\n"; //afisam titlul aici
    //ca sa afisam detaliile in for mai jos
   
    //returnam pop noua
    vector<pair<double, string>> new_population(dim);
    for(int i = 0; i < dim; i++){
        //facem perechi ca sa returnam toata pop odata
        new_population[i] = make_pair(X_new[i], binary_val_new[i]); 
        
        //afisari dupa selectie pt pop noua - doar pt prima gen
        if(nr_pas == 1){
            cout<<i+1<<": "<<binary_val_new[i]<<" x= "<<X_new[i]<<" f="<<fitness(a,b,c,X[i])<<'\n';
        }
    }
    return new_population;
}

int main(){
    fin>>dim;
    fin>>d1>>d2;
    fin>>a>>b>>c;
    fin>>p>>pc>>pm;
    fin>>nr_gen;
    
    //folosind formula din curs calculam lungimea cromozomilor
    double nr_subintervale = ((d2-d1)*pow(10,p));
    int l = ceil(log2(nr_subintervale));
    //DEBUG
    //cout<<"Dim pop: "<<dim<<'\n'<<"Capete: "<<d1<<" "<<d2<<'\n'<<"Polin: "<<a<<' '<<b<<' '<<c<<'\n'<<"Prob: "<<p<<' '<<pc<<' '<<pm<<'\n'<<"Numar gen: "<<nr_gen;

    //punem aici titlul pentru ca oricum in forul care urm nu vom afisa altceva
    //decat prima populatie
    cout<<"Populatia initiala\n";
    for(int i = 0; i < dim; i++) //generam valori random pt indivizi
    {
        double x = f_random(d1,d2,p);
        X.push_back(x);
        
        //codificare x
        binary_val.push_back(toBinary(x,l,d1,d2));
        
        //afisarea primei generatii
        cout<<i+1<<": "<<binary_val[i]<<" x= "<<x<<" f="<<fitness(a,b,c,x)<<'\n';
    } 
    cout<<'\n';
    
    for(int i = 1; i < nr_gen; i++){
        //prelucram generatia i 

        //- selectie de tip elitist - ruleta
        //trimitem i ptc daca suntem la prima generatie sa afisam mai multe info
        vector<pair<double,string>> new_population = selection(X, binary_val, a,b,c,dim, i);
    
        //actualizam X si binary_val cu noua pop - despartim perechea
        for(int j = 0; j < dim; j++){
            X[j] = new_population[j].first;
            binary_val[j] = new_population[j].second;
        }
    }


}


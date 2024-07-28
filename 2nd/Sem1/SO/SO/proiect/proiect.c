#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <signal.h>

#define MAX_PATH 256
#define MAX_CHILDREN 10000

//vector global ca sa retinem PIDs pentru procesele copil
pid_t child_pids[MAX_CHILDREN];
int num_children = 0;


//functie pentru a afisa informatii despre un proces specificat prin PID
void print_process_info(const char *pid) {
    //construim calea catre fisierul de status al procesului
    char proc_path[MAX_PATH];
    snprintf(proc_path, MAX_PATH, "/proc/%s/status", pid);

    FILE *file = fopen(proc_path, "r");
    if (!file) {
        perror("Eroare la deschiderea fisierului");
        return;
    }

    //afisam informatii despre proces
    printf("Process Information for PID %s:\n", pid);

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        printf("%s", line);
    }

    //inchidem fisierul
    fclose(file);
}


//functie pentru a adauga PID-ul copil la array
void add_child_pid(pid_t pid) {
    if (num_children < MAX_CHILDREN) {
        child_pids[num_children++] = pid;
    } else {
        fprintf(stderr, "Too many child processes to handle.\n");
    }
}

//functie pentru a afisa PIDs pentru PID-ul dat
void print_child_pids(const char *pid) {
    printf("Child Process PIDs:\n");

    //construim comanda pgrep
    char pgrep_cmd[MAX_PATH];
    snprintf(pgrep_cmd, MAX_PATH, "pgrep -P %s", pid);

    //deschidem un pipe pentru a citi output-ul comenzii pgrep
    FILE *pgrep_pipe = popen(pgrep_cmd, "r");
    if (!pgrep_pipe) {
        perror("Eroare la deschiderea pipe-ului");
        return;
    }

    char child_pid[32];
    while (fgets(child_pid, sizeof(child_pid), pgrep_pipe)) {
        
        //sterge caracterul pt newline
        child_pid[strcspn(child_pid, "\n")] = '\0';

        //adaugam PID-ul la array
        add_child_pid(atoi(child_pid));

        //afisam PID-ul
        printf("%s\n", child_pid);
        
    }

    pclose(pgrep_pipe);
}


//functie pentru a afiaa PIDs si informatiile despre procesele copil pentru PID-ul dat
void print_child_processes(const char *pid) {
    printf("Child Process PIDs:\n");

    //construim comanda pgrep
    char pgrep_cmd[MAX_PATH];
    snprintf(pgrep_cmd, MAX_PATH, "pgrep -P %s", pid);

    //deschidem un pipe pentru a citi output-ul comenzii pgrep
    FILE *pgrep_pipe = popen(pgrep_cmd, "r");
    if (!pgrep_pipe) {
        perror("Eroare la deschiderea pipe-ului");
        return;
    }

    char child_pid[32];
    while (fgets(child_pid, sizeof(child_pid), pgrep_pipe)) {
        //stergem caracter newline
        child_pid[strcspn(child_pid, "\n")] = '\0';

        //afisam PID-ul
        printf("%s\n", child_pid);

        //afisam detalii despre fiecare proces copil
        printf("\nChild Process Information:\n");

        //Verificam daca procesul inca exista inainte de a afisa informatii despre el
        if (kill(atoi(child_pid), 0) == 0) {
            print_process_info(child_pid);
        } else {
            printf("Process with PID %s no longer exists.\n", child_pid);
        }

        printf("\n");
        printf("--------------------------------------------------------------------\n");
    }

    pclose(pgrep_pipe);
}


///functia principala
int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <pid>\n", argv[0]);
        return EXIT_FAILURE;
    }

    const char *pid = argv[1];



    //afisam intai lista cu PID-urile copiilor
    print_child_pids(pid);
    
//afisam numarul total de procese copil
    printf("\nTotal number of child processes: %d\n", num_children);    

    //afisam informatiile despre fiecare proces copil din lista
    printf("\nChild Process Information:\n");
    for (int i = 0; i < num_children; i++) {
        printf("\n--------------------------------------------------------------------\n");
        char child_pid_str[32];
	snprintf(child_pid_str, sizeof(child_pid_str), "%d", child_pids[i]);
	print_process_info(child_pid_str);
    }

    return EXIT_SUCCESS;
}

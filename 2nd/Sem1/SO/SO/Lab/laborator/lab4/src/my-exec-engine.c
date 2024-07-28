#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <command> [args...]\n", argv[0]);
        exit(1);
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork error");
        exit(1);
    } else if (!pid) { // Proces copil
        // Execută comanda folosind execvp
        execvp(argv[1], &argv[1]);
        perror("Exec error"); // Această linie se va executa numai dacă execvp eșuează
        exit(1);
    } else { // Proces părinte
        int status;
        wait(&status);
        if (WIFEXITED(status)) {
            printf("Copilul a terminat cu codul de ieșire: %d\n", WEXITSTATUS(status));
        } else if (WIFSIGNALED(status)) {
            printf("Copilul a fost întrerupt de semnalul: %d\n", WTERMSIG(status));
        }
    }

    return 0;
}


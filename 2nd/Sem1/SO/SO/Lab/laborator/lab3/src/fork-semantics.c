#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int globalInt = 6;
char buf[] = "unbuffered write to stdout\n";

int main() {
    int localInt = 10;
    pid_t pid;

    write(1, buf, strlen(buf));  // Afisare directa folosind write

    printf("Inainte de fork\n");

    pid = fork();

    if (pid < 0) {
        perror("Fork error");
        exit(1);
    } else if (pid == 0) {  // Proces copil
        globalInt++;
        localInt++;
        printf("Copil - Global: %d, Local: %d, Pid: %d\n", globalInt, localInt,pid);
    } else {  // Proces parinte
        sleep(2);  // astept 2 sec
        printf("Parinte - Global: %d, Local: %d, Pid: %d\n", globalInt, localInt,pid);
    }

    return 0;
}


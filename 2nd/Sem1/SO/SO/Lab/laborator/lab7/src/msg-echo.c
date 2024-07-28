#include <stdio.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <string.h>

#define MAX_MESSAGE_SIZE 256

// Structura pentru mesaj
struct msgbuf {
    long mtype;
    char mtext[MAX_MESSAGE_SIZE];
};

int main(int argc, char *argv[]) {
    key_t key;
    int msqid;

    // Verificam argumentele de linie de comanda
    if (argc != 3) {
        fprintf(stderr, "Folosire: %s keyfile message\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    // Generam cheia IPC folosind ftok
    key = ftok(argv[1], 'A');
    if (key == -1) {
        perror("ftok");
        exit(EXIT_FAILURE);
    }

    // Cream coada de mesaje
    msqid = msgget(key, 0);
    if (msqid == -1) {
        perror("msgget");
        exit(EXIT_FAILURE);
    }

    // Trimitem mesajul la server
    struct msgbuf msg;
    msg.mtype = 1; // Tipul mesajului (ar trebui sa corespunda cu tipul folosit de server)
    strncpy(msg.mtext, argv[2], MAX_MESSAGE_SIZE - 1);

    // Trimiterea mesajului la coada de mesaje
    if (msgsnd(msqid, &msg, sizeof(struct msgbuf) - sizeof(long), 0) == -1) {
        perror("msgsnd");
        exit(EXIT_FAILURE);
    }

    printf("Mesaj trimis catre server: %s\n", argv[2]);

    return 0;
}


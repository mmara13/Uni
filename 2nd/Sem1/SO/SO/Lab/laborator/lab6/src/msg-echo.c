#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <unistd.h>
#include <signal.h>

#define MAX_MESSAGE_SIZE 256

struct message {
    long mtype;
    char mtext[MAX_MESSAGE_SIZE];
};

int msgid;

void cleanup(int signal) {
    //eliminare coada msj cand programul e gt
    msgctl(msgid, IPC_RMID, NULL);
    exit(0);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s keyfile\n", argv[0]);
        exit(1);
    }

    key_t key = ftok(argv[1], 'E');
    if (key == -1) {
        perror("ftok");
        exit(1);
    }

    msgid = msgget(key, 0666); //obt id ul cozii de msj creata de msg-echod 
    if (msgid == -1) {
        perror("msgget");
        exit(1);
    }

    signal(SIGINT, cleanup); //gestionare ctr-c pt curatenie

    struct message msg;
    while (1) {
        printf("Enter a message: ");
        fgets(msg.mtext, MAX_MESSAGE_SIZE, stdin);
        msg.mtype = getpid(); //tip msj este pid ul procesului creat

        //trimitere mesaj in coada de mesaje
        if (msgsnd(msgid, &msg, sizeof(msg.mtext), 0) == -1) {
            perror("msgsnd");
            exit(1);
        }

        //asteapta primire reasp (Echoul) de la msh-echod.c
        if (msgrcv(msgid, &msg, sizeof(msg.mtext), getpid(), 0) == -1) {
            perror("msgrcv");
            exit(1);
        }

        printf("Echo: %s", msg.mtext);
    }

    return 0;
}

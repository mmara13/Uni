#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/msg.h>
#include <sys/ipc.h>
#include <string.h>
#include <unistd.h>

#define MAX_MESSAGE_SIZE 256

//structura pentru mesaj
struct msgbuf {
    long mtype;
    char mtext[MAX_MESSAGE_SIZE];
};

//functia executata de fiecare thread
void *handleMessage(void *arg) {
    struct msgbuf *msg = (struct msgbuf *)arg;

    //afisam mesajul primit
    printf("Thread %ld primeste mesaj: %s\n", pthread_self(), msg->mtext);

    //timitem inapoi mesajul primit (serviciu de echo)
    msgsnd(msg->mtype, msg, sizeof(struct msgbuf) - sizeof(long), 0);

    //eliberam resursele alocate pentru mesaj
    free(msg);

    pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
    key_t key;
    int msqid;

    //verificam argumentele de linie de comanda
    if (argc != 2) {
        fprintf(stderr, "Folosire: %s keyfile\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    //generam cheia IPC folosind ftok
    key = ftok(argv[1], 'A');
    if (key == -1) {
        perror("ftok");
        exit(EXIT_FAILURE);
    }

    //cream coada de mesaje
    msqid = msgget(key, IPC_CREAT | 0666);
    if (msqid == -1) {
        perror("msgget");
        exit(EXIT_FAILURE);
    }

    printf("Serverul de echo (msg-mt-echod.c) ruleaza...\n");

    while (1) {
        //asteptam primirea unui mesaj in coada de mesaje
        struct msgbuf *msg = (struct msgbuf *)malloc(sizeof(struct msgbuf));
        ssize_t msgSize = msgrcv(msqid, msg, sizeof(struct msgbuf) - sizeof(long), 0, 0);

        if (msgSize == -1) {
            perror("msgrcv");
            exit(EXIT_FAILURE);
        }

        //cream un thread separat pentru fiecare mesaj primit
        pthread_t thread;
        if (pthread_create(&thread, NULL, handleMessage, (void *)msg) != 0) {
            perror("pthread_create");
            exit(EXIT_FAILURE);
        }

        //detasam thread-ul pentru a permite eliberarea automata a resurselor
        pthread_detach(thread);
    }

    return 0;
}


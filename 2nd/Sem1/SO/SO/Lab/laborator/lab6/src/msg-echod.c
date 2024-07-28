#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <unistd.h>

#define MAX_MESSAGE_SIZE 256

struct message {
    long mtype; 
    char mtext[MAX_MESSAGE_SIZE];
};

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s keyfile\n", argv[0]);
        exit(1);
    }

    key_t key = ftok(argv[1], 'E'); //generare cheie IPC dintr un fisier
    if (key == -1) {
        perror("ftok");
        exit(1);
    }

    int msgid = msgget(key, IPC_CREAT | 0666); //creere sau obtinere coada mesaje
    if (msgid == -1) {
        perror("msgget");
        exit(1);
    }

    struct message msg;
    while (1) {
        if (msgrcv(msgid, &msg, sizeof(msg.mtext), 0, 0) == -1) { //asteapta primirea mesajelor
            perror("msgrcv");
            exit(1);
        }
        printf("Received: %s", msg.mtext);
        //trimite inapoi mesajul primit
        if (msgsnd(msgid, &msg, sizeof(msg.mtext), 0) == -1) {
            perror("msgsnd");
            exit(1);
        }
    }

    return 0;
}


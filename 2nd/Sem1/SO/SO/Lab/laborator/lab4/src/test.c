#include <signal.h>
#include <stdlib.h>
#include <stdio.h>

void (*old_handler)(int);

void handler(int signo) {
    printf("Custom handler: Received SIGINT (%d)\n", signo);

    // Exit
    exit(0);
}

int main(int argc, char *argv[]) {
    if ((old_handler = signal(SIGINT, handler)) == SIG_ERR) {
        perror("Unable to set signal handler");
        exit(1);
    }

    printf("Custom handler for SIGINT is set. Press Ctrl+C to trigger it.\n");

    //mentine programul pornit
    while (1) {
    }

    // Restore handlerul original SIGNINT inainte  de exit
    signal(SIGINT, old_handler);

    return 0;
}


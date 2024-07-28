#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MESSAGE "ABCD"

int main() {
    int pipe_fd[2];
    pid_t child_pid;
    char message_buffer[100];

    if (pipe(pipe_fd) < 0) {
        perror("Eroare pipe!");
        exit(1);
    }

    if ((child_pid = fork()) == -1) {
        perror("eroare fork!");
        exit(1);
    }

    if (child_pid == 0) {
        close(pipe_fd[1]);

        if (read(pipe_fd[0], message_buffer, sizeof(message_buffer)) == -1) {
            perror("Eroare citire din pipe");
            exit(1);
        }

        printf("Procesul copil a primit msjul: %s\n", message_buffer);

        close(pipe_fd[0]);
        exit(0);  
    } else {
        close(pipe_fd[0]);

        if (write(pipe_fd[1], MESSAGE, strlen(MESSAGE)) == -1) {
            perror("Eroare scriere in pipe");
            exit(1);
        }

        close(pipe_fd[1]);
        exit(0);  }
    return 0;
}


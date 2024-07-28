#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MESSAGE "ABCD"
#define DONE "done\n"

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
        // Child process

        // Close the writing end of the pipe
        close(pipe_fd[1]);

        // Read the message from the pipe
        if (read(pipe_fd[0], message_buffer, sizeof(message_buffer)) == -1) {
            perror("Eroare citire din pipe");
            exit(1);
        }

        printf("Procesul copil a primit msjul: %s\n", message_buffer);

        // Close the reading end of the pipe in the child
        close(pipe_fd[0]);

        // Open a new pipe for sending the "done" message
        int done_pipe_fd[2];
        if (pipe(done_pipe_fd) == -1) {
            perror("Eroare pipe catre parinte!");
            exit(1);
        }

        // Close the reading end of the done pipe
        close(done_pipe_fd[0]);

        // Write the "done" message to the done pipe
        if (write(done_pipe_fd[1], DONE, strlen(DONE)) == -1) {
            perror("Eroare scriere in pipe catre parinte");
            exit(1);
        }

        // Close the writing end of the done pipe in the child
        close(done_pipe_fd[1]);

        exit(0);
    } else {
        // Parent process

        // Close the reading end of the pipe in the parent
        close(pipe_fd[0]);

        // Write the initial message to the pipe
        if (write(pipe_fd[1], MESSAGE, strlen(MESSAGE)) == -1) {
            perror("Eroare scriere in pipe");
            exit(1);
        }

        // Close the writing end of the pipe in the parent
        close(pipe_fd[1]);

        // Open a new pipe for receiving the "done" message
        int done_pipe_fd[2];
        if (pipe(done_pipe_fd) == -1) {
            perror("Eroare pipe pentru mesajul 'done'");
            exit(1);
        }

        // Close the writing end of the done pipe
        close(done_pipe_fd[1]);

        // Read the "done" message from the done pipe
        char done_buffer[100];
        if (read(done_pipe_fd[0], done_buffer, sizeof(done_buffer)) == -1) {
            perror("Eroare citire din pipe pentru mesajul 'done'");
            exit(1);
        }

        // Print the "done" message
        printf("Procesul parinte a primit msjul: %s\n", done_buffer);
        exit(0);
    }

    return 0;
}


#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    char buffer[1024];
    ssize_t bytesRead;

    while ((bytesRead = read(STDIN_FILENO, buffer, sizeof(buffer))) > 0) {
        if (write(STDOUT_FILENO, buffer, bytesRead) != bytesRead) {
            perror("write");
            exit(1);
        }
    }

    if (bytesRead < 0) {
        perror("read");
        exit(1);
    }

    exit(0);
}

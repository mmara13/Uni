// userland.c
#include <stdio.h>
#include <unistd.h>

int main() {
    const char *pid = "1234";  // Replace with the actual PID you want to query

    // Call the system call
    long result = syscall(333, pid);  // Assuming the system call number is 333

    if (result == 0) {
        printf("System call executed successfully.\n");
    } else {
        perror("Error in system call");
    }

    return 0;
}


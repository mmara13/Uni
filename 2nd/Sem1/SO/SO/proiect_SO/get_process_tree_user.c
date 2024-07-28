#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>

#define __NR_get_process_tree 333  // Alege un număr de sistem liber

int main() {
    int pid;

    printf("Introduceți PID-ul procesului: ");
    scanf("%d", &pid);

    long ret = syscall(__NR_get_process_tree, pid);

    if (ret < 0) {
        perror("syscall");
        return 1;
    }

    return 0;
}


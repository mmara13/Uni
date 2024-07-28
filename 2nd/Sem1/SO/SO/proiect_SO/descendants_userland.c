#include <stdio.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <errno.h> 
#include <string.h>

#define SYS_get_descendants_info 333

struct task_info {
    pid_t pid;
    char state;
};

int main() {
    pid_t pid;
    printf("Enter PID: ");
    scanf("%d", &pid);

    size_t size = 10;
    struct task_info *info = malloc(size * sizeof(struct task_info));

    if (!info) {
        perror("Failed to allocate memory for info");
        return 1;
    }

    long ret = syscall(SYS_get_descendants_info, pid, info, size);
    
    // Check if the buffer was too small
    if (ret == -1 && errno == EFAULT) {
        // Retry with a larger buffer
        free(info);

        // Double the size (or use a more sophisticated resizing strategy)
        size *= 2;
        info = malloc(size * sizeof(struct task_info));

        if (!info) {
            perror("Failed to allocate memory for info");
            return 1;
        }

        ret = syscall(SYS_get_descendants_info, pid, info, size);
    }
    printf("Syscall return value: %ld\n", ret);

    if (ret < 0) {
        perror("Syscall failed");
        free(info);
        return 1;
    }

    printf("Descendants information for PID %d:\n", pid);
    for (size_t i = 0; i < ret; ++i) {
        printf("PID: %d, State: %c\n", info[i].pid, info[i].state);
    }

    free(info);

    return 0;
}


#include <stdio.h>
#include <unistd.h>

int main(){
	//pid
	pid_t pid =getpid();

	//uid
	uid_t uid = getuid();

	//gid
	gid_t gid = getgid();

	printf("PID: %d\n", pid);
	printf("UID: %d\n", uid);
	printf("GID: %d\n", gid);

	return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <sys/types.h>

int main(int argc, char *argv[]){
	if (argc !=2){
		fprintf(stderr, "Usage: %s <username>\n", argv[0]);
		return 1;
	}

	char *username = argv[1];
	struct passwd *user_info;
	user_info = getpwnam(username);
	if (user_info ==NULL){
		fprintf(stderr, "User '%s' not found.\n", username);
		return 1;
	}

	printf("User ID: %d\n", user_info->pw_uid);
	printf("Group ID: %d\n", user_info->pw_gid);
	printf("Home Directory: %s\n", user_info->pw_dir);
	printf("Shell: %s\n", user_info->pw_shell);

	return 0;
}

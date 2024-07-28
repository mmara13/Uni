#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <stdio.h>

int main(int argc, char*argv[]){
	if(argc!=2){
		fprintf(stderr, "Usage: %s <directory>\n", argv[0]);
		return 1;
	}

	DIR *dir = opendir(argv[1]);

	if(dir==NULL){
		perror("opendir");
		return 1;
	}
	struct dirent *entry;

	while ((entry = readdir(dir)) !=NULL){
		if(strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") !=0) {
			printf("%s\n", entry->d_name);
		}
	}

	closedir(dir);
	return 0;
}

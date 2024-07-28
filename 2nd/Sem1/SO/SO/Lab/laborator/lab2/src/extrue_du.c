#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[], char* envp[])
{
	int n, fd, count=0;
	char c;

	if(argc != 2){
		printf("usage: %s <filename>\n", argv[0], exit(1);
		exit(1);
	}
//open argv[1]
	fd=open(argv[1], 0_RDONLY);

	if(fd==-1){
		perror("open");
		exit(1);
	}

	//while read din fisier
	while(read(fd,&buffer,1)>0){
		//daca caracterul e diferit de \0
		if(buffer!=' '){
			count++;
		}
	}
			//incrementeaza counter
	printf("file size of %s is = %d\n", argv[1], count);

	close(fd);
	exit(0);
}

#include <stdio.h>
#include <unistd.h>

int main(){
	char buffer[1024]; 
	
	while(1) {
		ssize_t bytes_read = read(0,buffer,sizeof(buffer));
	
		if(bytes_read <0){
			perror("read");
			return 1;
		}
		else if(bytes_read ==0){
			break;
		}

		ssize_t bytes_written = write(1, buffer, bytes_read);

		if(bytes_written <0){
			perror("write");
			return 1;
		}
	}
	return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void sigusr_handler(int signo){
	if(signo == SIGUSR1){
		printf("Received SIGUSR1 (%d)\n", signo);
		signal(SIGUSR1, sigusr_handler); 
	}else if(signo == SIGUSR2){
		printf("Received SIGUSR2 (%d)\n", signo);
		signal(SIGUSR2, sigusr_handler);
	}
}
int main(){
	signal(SIGUSR1, sigusr_handler);
	signal(SIGUSR2, sigusr_handler);
	
	printf("My PID is %d\n", getpid());
	
	while(1){
		pause();
	}
	
	return 0;
}
		

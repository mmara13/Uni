#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[], char *envp[]) {
	if(argc !=2 )
	{
		fprintf(stderr, "Usage: %s <environment_variable>\n", argv[0]);
		return 1;
	}

	char *var_name = argv[1];
	char *var_val = NULL;

	for(int i=0; envp[i] !=NULL; i++){
		char *env_entry = envp[i];
		
		if (strncmp(env_entry, var_name, strlen(var_name)) ==0 && env_entry[strlen(var_name)] == '='){
			var_val = env_entry +strlen(var_name)+1;
			break;
		}
	}
	
	if (var_val !=NULL){
		printf("%s=%s\n", var_name, var_val);
	}
	else {
		printf("%s not found in the environment.\n", var_name);
	}
	
	return 0;
}

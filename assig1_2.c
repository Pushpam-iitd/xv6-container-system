#include "types.h"
#include "user.h"
#include "date.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  int size=20;
  short arr[size];
  char c;
  int pid;
  pid = fork();
  if (pid==0){
		create_container(1);
		join_container(1);
		ps();
    int fd2 = open("arrnew", 0);
    printf(1,"returns  \n");
    for(int i=0; i<size; i++){
  		read(fd2, &c, 1);
  		arr[i]=c-'0';
  		read(fd2, &c, 1);
  	}
    	close(fd2);
    printf(1,"first elem %d\n", arr[0]);
		exit();
	}
	else{
		exit();
	}
}

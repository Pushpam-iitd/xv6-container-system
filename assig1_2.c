#include "types.h"
#include "user.h"
#include "date.h"
#include "fcntl.h"
#include "ls.h"

int
main(int argc, char *argv[])
{
  // int size=20;
  // short arr[size];
  // char c;
  int pid;
  pid = fork();
  if (pid==0){
		create_container(2);
		join_container(2);
		// // ps();
    // // char* s = "Rahul";
    int fd2 = open("newfile",0);
    // // write(fd2,s,5);

    close(fd2);
    ls(".");

    // int fd3 = open("arrn", 0);
    // char* s2 = (char*)malloc(5);
    // read(fd3,s2,5);
    // printf(1,"%s",s2);
    // close(fd3);

		exit();
	}
	else{
		exit();
	}
}

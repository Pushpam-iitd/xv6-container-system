#include "types.h"
#include "user.h"
#include "date.h"
#include "fcntl.h"

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
		ps();
    int fd2 = open("arrn", O_CREATE | O_RDWR);
    close(fd2);
    int fd3 = open("arrn", 0);
    close(fd3);
		exit();
	}
	else{
		exit();
	}
}

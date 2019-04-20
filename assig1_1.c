#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"


int
main(void)
{
	int pid;
	int k;
	for (k = 1; k <= 3; k++) {
			pid = fork();
			if (pid == -1) {
					printf(1,"fork failed\n");
					// return;
					break;
			}
			if (pid == 0) {              // child process
					break;
			}
	}
	if (pid==0){
		create_container(k);
		join_container(k);
		char* s = "Rahul";
    int fd2 = open("arrn", O_CREATE | O_RDWR);
    write(fd2,s,5);
    close(fd2);
		ps();
		exit();
	}
	else{
		exit();
	}
}

#include "types.h"
#include "user.h"
#include "date.h"
#include "fcntl.h"
#include "ls.h"
#include "cat.h"

char* my_itoa_1(int i, char* b){
    char const digit[] = "0123456789";
    char* p = b;
    int n = i;
    do{
        ++p;
        n = n/10;
    }while(n);
    *p = '\0';
    do{
        *--p = digit[i%10];
        i = i/10;
    }while(i);
    return b;
}


char* strcat(char* s1,const char* s2)
{
  char* b = (char*)malloc(50);
  char* c= b;

  while (*s1)  *b++=*s1++;
  while (*s2) {
    *b=*s2;
    b++;
    s2++;}
  *b = 0;

  return c;
}

int
main(int argc, char *argv[])
{
  int k;
  int pid;
  create_container(1);
  create_container(2);
  create_container(3);

  for (k = 1; k <= 5; k++) {
			pid = fork();
			if (pid == -1) {
					printf(1,"fork failed\n");
					break;
			}
			if (pid == 0) {              // child process
					break;
			}
      sleep(1);
	}
  if (pid==0){
    if (k==1 || k==2 || k==3)join_container(1);


    if (k==4 || k==5) join_container(k-2);
  //
    if (k==3 || k==4 || k==5) ps();

    if (k==3 || k==4 || k==5) {
    scheduler_log();
    sleep(1);
    scheduler_log();
  }

    if (k==5) ls(".");

    char *pid_num = (char*)malloc(8);

    open(strcat("file_",my_itoa_1(getpid(),pid_num)),O_CREATE | O_RDWR);

    sleep(10);

    if (k==5) {
      ls(".");
    }


    if (k==3 || k==4 || k==5){
    int file = open("my_file",O_CREATE | O_RDWR);
    write(file,strcat("Modified by: ",my_itoa_1(getpid(),pid_num)),20);
    close(file);
    cat("my_file");
  }

    sleep(200);
    leave_container();
    exit();
	}
	else{


    for (int i = 0; i < 5; i++) {
      wait();
    }
    destroy_container(1);
    destroy_container(2);
    destroy_container(3);
		exit();
	}
}

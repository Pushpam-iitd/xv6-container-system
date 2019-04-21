#include "types.h"
#include "user.h"
#include "date.h"
#include "fcntl.h"
#include "ls.h"

int
main(int argc, char *argv[])
{
  // int k;
  int pid;
  create_container(1);
  create_container(2);
  create_container(3);
	pid = fork();
  if (pid==0){
    join_container(1);
    int pid2;
    pid2 = fork();
    if(pid2 ==0){
      int pid3;
      join_container(1);
      pid3 = fork();
      if(pid3 ==0){
        join_container(1);
        ps();
        exit();
      }
      else{exit();}
    }
    else{exit();}
	}
	else{

    // destroy_container(1);
    // destroy_container(2);
    // destroy_container(3);
		exit();
	}
}

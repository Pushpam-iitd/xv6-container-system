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

  int fd = newopen("arrnew", 0);
  

  printf(1,"returns  \n");

  // printf(1,"fd is  %d\n", fd);


  	close(fd);


  int fd2 = open("arrnew_0", 0);
  

  printf(1,"returns  \n");

  // printf(1,"fd is  %d\n", fd);

  for(int i=0; i<size; i++){
		read(fd2, &c, 1);
		arr[i]=c-'0';
		read(fd2, &c, 1);
	}	
  	close(fd2);



  	// this is to supress warning
  printf(1,"first elem %d\n", arr[0]);
  exit();
}

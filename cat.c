#include "types.h"
#include "stat.h"
#include "user.h"
#include "cat.h"

char buf[512];

// char* my_itoa(int i, char* b){
//     char const digit[] = "0123456789";
//     char const sig[] = "$";
//     char* p = b;
//     // if(i<0){
//     //     *p++ = '-';
//     //     i *= -1;
//     // }
//     int n = i;
//     do{
//         ++p;
//         n = n/10;
//     }while(n);
//     p++;
//     *p = '\0';
//     do{
//         *--p = digit[i%10];
//         i = i/10;
//     }while(i);
//     // p--;
//     *--p = sig[0];
//
//     return b;
// }
// char* strcat(char* s1,const char* s2)
// {
//   char* b = (char*)kalloc();
//   char* c= b;
//
//   while (*s1)  *b++=*s1++;
//   while (*s2) {
//     *b=*s2;
//     b++;
//     s2++;}
//   *b = 0;
//
//   return c;
// }

void
cat(char* file)
{
  int n;
  int fd = open(file, 0);
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  printf(1,"\n");
  if(n < 0){
    printf(1, "cat: read error\n");
    exit();
  }
}

// int
// main(int argc, char *argv[])
// {
//   int fd, i;
//
//   if(argc <= 1){
//     cat(0);
//     exit();
//   }
//
//   for(i = 1; i < argc; i++){
//     if((fd = open(argv[i], 0)) < 0){
//       printf(1, "cat: cannot open %s\n", argv[i]);
//       exit();
//     }
//     cat(fd);
//     close(fd);
//   }
//   exit();
// }

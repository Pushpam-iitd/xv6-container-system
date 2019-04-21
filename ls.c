#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "ls.h"
// #include "defs.h"

char* removelast(char *s){
    int a = 0;
    char* b = (char*)malloc(100);
    while(*s){
        if(s[0] == '$')
        {
            break;
        }
        *b = *s;
        s++;
        b++;
        a++;
    }
    while(a--){s--;b--;}
    return b;
}

int
mystrcmp (char *s1, char *s2)
{
    int a =0,b=0;
    while(*s1){a++;s1++;}
    while(*s2){b++;s2++;}

    if(a!=b)return 0;
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}

void
ls(char *path)
{
  *ls_called = 1;

  int cid = getcid();

  // printf(2, "Cid is: %d\n", cid);
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
  case T_FILE:
    if (st.cid ==0 || st.cid==-1){
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  }
  if (st.cid == cid){
  printf(1, "%s %d %d %d\n", fmtname(removelast(path)), st.type, st.ino, st.size);
}
  break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      if (st.cid ==0 || st.cid==-1){
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    if (st.cid == cid){
    printf(1, "%s %d %d %d\n", fmtname(removelast(buf)), st.type, st.ino, st.size);
  }
    }
    break;
  }
  close(fd);
  *ls_called=0;

}




// int
// main(int argc, char *argv[])
// {
//   int i;
//
//   if(argc < 2){
//     ls(".");
//     exit();
//   }
//   for(i=1; i<argc; i++)
//     ls(argv[i]);
//   exit();
// }

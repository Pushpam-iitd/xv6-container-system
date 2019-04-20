#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"
#include "syscall.h"

// #include "string.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.

int create_container_called = 0;


static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

int
sys_dup(void)
{ if(isTraceOn==1)
  {num_calls[SYS_dup] ++;}
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

int
sys_read(void)
{ if(isTraceOn==1)
  {num_calls[SYS_read] ++;}
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  // if (cid==-1 || create_container_called == 0){
  return fileread(f, p, n);
    // }
//   else{
//   int ind = curproc->cid;
//     // int ind = 67;
//   char *sind = (char *)kalloc();
//     // strncpy(sind,my_itoa(ind,sind),);
//   sind = my_itoa(ind,sind);
//   char *path2 = strcat(path,sind);
//   }
}

int
sys_write(void)
{ if(isTraceOn==1)
  {num_calls[SYS_write] ++;}
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return filewrite(f, p, n);
}

int
sys_close(void)
{ if(isTraceOn==1)
  {num_calls[SYS_close] ++;}
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}

int
sys_fstat(void)
{ if(isTraceOn==1)
  {num_calls[SYS_fstat] ++;}
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  if(isTraceOn==1)
  {num_calls[SYS_link] ++;}
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

//PAGEBREAK!
int
sys_unlink(void)
{ if(isTraceOn==1)
  {num_calls[SYS_unlink] ++;}
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
    return -1;
  }

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}



// new code
// a file is already present, we have to just make a copy and open the new file.

// end  new code


int
sys_mkdir(void)
{ if(isTraceOn==1)
  {num_calls[SYS_mkdir] ++;}
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_mknod(void)
{ if(isTraceOn==1)
  {num_calls[SYS_mknod] ++;}
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_chdir(void)
{ if(isTraceOn==1)
  {num_calls[SYS_chdir] ++;}
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}

int
sys_exec(void)
{ if(isTraceOn==1)
  {num_calls[SYS_exec] ++;}
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{ if(isTraceOn==1)
  {num_calls[SYS_pipe] ++;}
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}

char* my_itoa(int i, char* b){
    char const digit[] = "0123456789";
    char const sig[] = "_";
    char* p = b;
    // if(i<0){
    //     *p++ = '-';
    //     i *= -1;
    // }
    int n = i;
    do{
        ++p;
        n = n/10;
    }while(n);
    p++;
    *p = '\0';
    do{
        *--p = digit[i%10];
        i = i/10;
    }while(i);
    // p--;
    *--p = sig[0];

    return b;
}

char* strcat(char* s1, const char* s2)
{
  char* b = s1;

  while (*s1) ++s1;
  while (*s2) *s1++ = *s2++;
  *s1 = 0;

  return b;
}

// char buf[4];


int
sys_open(void)
{
  int create_in_container = 0;
  struct proc *curproc = myproc();
  int cid = curproc->cid;

  if(isTraceOn==1)
  {num_calls[SYS_open] ++;}


  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    {cprintf("yahan nahi aana chahiye 0\n");
    return -1;}

  begin_op();

  if(omode & O_CREATE){
    cprintf("yahan nahi aana chahiye 1\n");
    if (cid==-1 || create_container_called == 0){
    ip = create(path, T_FILE, 0, 0);
    }
    else{
      create_in_container = 1;
      int ind = curproc->cid;
      // int ind = 67;
      char *sind = (char *)kalloc();
      // strncpy(sind,my_itoa(ind,sind),);
      sind = my_itoa(ind,sind);
      char *path2 = strcat(path,sind);
      ip = create(path2, T_FILE, 0, 0);
    }
    if(ip == 0){
      end_op();
      return -1;
    }

  }
  else {
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
      cprintf("yahan nahi aana chahiye 2\n");

    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
    cprintf("yahan nahi aana chahiye 3\n");

      iunlockput(ip);
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    cprintf("yahan nahi aana chahiye 4\n");

    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f->path = path;
  f->cid = 0;

  if (cid==-1 || create_container_called == 0 ){return fd;}
  if (create_in_container == 1) {

    
    f->cid = cid;
    return fd;
  }

  // fd has the original file

  // ------------------------------------------------------------------------------
  // COPY CONTENTS OF F TO F2, AND CLOSE BOTH F AND F2
  // ------------------------------------------------------------------------------

  // struct proc *curproc = myproc();
  struct file *f2;
  int fd2;
  int ind = curproc->cid;
  // int ind = 67;
  char *sind = (char *)kalloc();
  // strncpy(sind,my_itoa(ind,sind),);
  sind = my_itoa(ind,sind);
  char *path2 = strcat(path,sind);
  // cprintf("path 2 is %s\n",path2);
  struct inode *ip2;

  begin_op();
  ip2 = create(path2, T_FILE, 0, 0);
  if(ip2 == 0){
    cprintf("yahan nahi aana chahiye 5\n");

    end_op();
    return -1;
    cprintf("ip2 0 \n");
  }


  cprintf("file 2 is created\n");
  if((f2 = filealloc()) == 0 || (fd2 = fdalloc(f2)) < 0){
    if(f2)
      fileclose(f2);
    iunlockput(ip2);
    end_op();
    return -1;
  }
  cprintf("yahan 1 \n");


  iunlock(ip2);
  end_op();

  f2->type = FD_INODE;
  f2->ip = ip2;
  f2->off = 0;
  f2->readable = !(omode & O_WRONLY);
  // f2->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f2->writable =1;
  f2->path = path2;
  f2->cid = cid;


  cprintf("yahan 2 \n");


  // return fd;
  while(1){
    int n1;
    char c[1];
    n1 = fileread(f, c, sizeof(c)) ;
    if(n1<=0)break;
    n1 = filewrite(f2,c,sizeof(c));
    // cprintf("reading  %s \n",c);
    if(n1<0)
      cprintf("error in writing in newopen \n");
  }
  // return fd;
  f2->off = 0;
  f->off = 0;

  cprintf("yahan 2 fd2 ka offset %d\n", f2->off);

  myproc()->ofile[fd] = 0;
  fileclose(f);

  myproc()->ofile[fd2] = 0;
  fileclose(f2);



  // ------------------------------------------------------------------------------
  // OPEN F2 AGAIN AS F3
  // ------------------------------------------------------------------------------
  char *path3;
  int fd3;
  struct file *f3;
  struct inode *ip3;

  path3 = path2;
  // if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  //   return -1;

  begin_op();

  if(omode & O_CREATE){
    cprintf("yahan nahi aana chahiye 6\n");
    ip3 = create(path3, T_FILE, 0, 0);
    if(ip3 == 0){
      end_op();
      return -1;
    }
  }

  else {
    if((ip3 = namei(path3)) == 0){
      end_op();
      return -1;
    }
    ilock(ip3);
    if(ip3->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip3);
      end_op();
      return -1;
    }
  }

  if((f3 = filealloc()) == 0 || (fd3 = fdalloc(f3)) < 0){
    if(f3)
      fileclose(f3);
    iunlockput(ip3);
    end_op();
    return -1;
  }
  iunlock(ip3);
  end_op();

  f3->type = FD_INODE;
  f3->ip = ip3;
  f3->off = 0;
  f3->readable = !(omode & O_WRONLY);
  f3->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f3->path = path3;
  f3->cid = 0;

  // n1 = fileread(f3, &c, 1);
  // cprintf("reading  %s \n",c);

  cprintf("yahan fd3 is %d \n",fd3);
  return fd3;
}

int
sys_create_container(int cid){
  // cprintf("Create container call hua%s\n");
  create_container_called = 1;
  argint(0,&cid);
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){return -1;}
    }
  }
  for ( int i=0; i<100 ; i++) {
    if (container_location[i]!=1){
      struct container new_container;
      new_container.cid = cid;
      container_array[i]=new_container;
      container_location[i]=1;
      container_array[i].number_of_process=0;
      break;
    }
  }
  return cid;
}

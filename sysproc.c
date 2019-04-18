#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "syscall.h"

// #include "queues.h"

int
sys_fork(void)
{ if(isTraceOn==1)
  {num_calls[SYS_fork] ++;}
  return fork();
}

int
sys_exit(void)
{ if(isTraceOn==1)
  {num_calls[SYS_exit] ++;}
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{ if(isTraceOn==1)
  {num_calls[SYS_wait] ++;}
  return wait();
}

int
sys_kill(void)
{ if(isTraceOn==1)
  {num_calls[SYS_kill] ++;}
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{ if(isTraceOn==1)
  {num_calls[SYS_getpid] ++;}
  return myproc()->pid;
}

int
sys_sbrk(void)
{ if(isTraceOn==1)
  {num_calls[SYS_sbrk] ++;}
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{ if(isTraceOn==1)
  {num_calls[SYS_sleep] ++;}
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{ if(isTraceOn==1)
  {num_calls[SYS_uptime] ++;}
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_halt(void)
{ if(isTraceOn==1)
  {num_calls[SYS_halt] ++;}
  outb(0xf4, 0x00);
  return 0;
}

int
sys_toggle(void)
{ 
  if(isTraceOn==0)
    {
      isTraceOn=1;
      for(int i =0;i<NELEM(num_calls);i++){num_calls[i]=0;}
      return 0;
    }
  if(isTraceOn==1)
  {
    isTraceOn=0;
    return 0;
  }
  return 0;
}

int 
sys_print_count(void)
{ 
  if(isTraceOn==1)
  {num_calls[SYS_print_count] ++;}

  const int sorted_syscalls_int[]={SYS_add , SYS_chdir , SYS_close , SYS_dup , SYS_exec , SYS_exit , SYS_fork , SYS_fstat , SYS_getpid , SYS_kill , SYS_link ,
  SYS_mkdir , SYS_mknod , SYS_open , SYS_pipe , SYS_print_count , SYS_ps , SYS_read ,SYS_recv, SYS_sbrk ,SYS_send, SYS_sleep , SYS_toggle , SYS_unlink , SYS_uptime , SYS_wait , SYS_write };


const char* sorted_syscalls_str[]={"sys_add ", "sys_chdir ", "sys_close ", "sys_dup ", "sys_exec ", "sys_exit ", "sys_fork ", "sys_fstat ", "sys_getpid ", "sys_kill ", "sys_link ",
  "sys_mkdir ", "sys_mknod ", "sys_open ", "sys_pipe ", "sys_print_count ", "sys_ps ", "sys_read ","sys_recv", "sys_sbrk ","sys_send", "sys_sleep ", "sys_toggle ", "sys_unlink ", "sys_uptime ", "sys_wait ", "sys_write "};

  for(int i =0;i<27;i++)
    { if(num_calls[sorted_syscalls_int[i]]!=0)
      cprintf("%s%d\n", sorted_syscalls_str[i], num_calls[sorted_syscalls_int[i]] );
    }
    return 0;
}

int 
sys_add(int a ,int b)
{ if(isTraceOn==1)
  {num_calls[SYS_add] ++;}
  // cprintf("sum is calculated\n");
  argint(0,&a);
  argint(1,&b);

  // cprintf("sum is, %d \n", a+b);

  return a+b;
}


int
sys_ps(void)
{   if(isTraceOn==1)
  {num_calls[SYS_ps] ++;}
    running_procs();
    // for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    // if(p->state == RUNNING)
    //   {
    //     cprintf("pid:%d name:%s",p->pid,p->name)
    //     cprintf("\n");
    //   }
    return 0;
}

int
sys_create_container(int cid){
  argint(0,&cid);
  cprintf("%d\n",cid);
  return cid;
}

int
sys_destroy_container(int cid){
  argint(0,&cid);
  return 1;
}

int
sys_join_container(int cid){
  argint(0,&cid);
  return 1;
}

int
sys_leave_container(void){
  
  return 1;
}

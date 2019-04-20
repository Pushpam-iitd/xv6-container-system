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
sys_ps(void)
{
  // cprintf("ps call hua%s\n");
  if(isTraceOn==1){num_calls[SYS_ps] ++;}
  running_procs();
return 0;
}


int
sys_destroy_container(int cid){
  argint(0,&cid);
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){
        // container_array[i]=null;
        container_location[i]=0;
        return 1;
        }
    }
  }
  return -1;
}

int
sys_join_container(int cid){
  // cprintf("Join container call hua%s\n");
  argint(0,&cid);
  int r = join_cont(cid);
  return r;
}

int
sys_leave_container(void){
  struct proc *curproc = myproc();
  int cid = curproc->cid;
  for (int i = 0; i < 100; i++) {
    if (container_location[i]==1){
      if(container_array[i].cid==cid){
        curproc->cid = 0;
        container_array[i].mypid[container_array[i].number_of_process] = -1;
        container_array[i].number_of_process--;
        return 1;
      }
    }
  }
  return -1;
}

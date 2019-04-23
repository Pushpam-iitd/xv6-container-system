#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "syscall.h"

int syscallhappened = 0;
// #include <malloc.h>

// User code makes a system call with INT T_SYSCALL.
// System call number in %eax.
// Arguments on the stack, from the user call to the C
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
  *ip = *(int*)(addr);
  return 0;
}

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  int i;
  struct proc *curproc = myproc();

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
  *pp = (char*)i;
  return 0;
}

// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}

extern int sys_chdir(void);
extern int sys_close(void);
extern int sys_dup(void);
extern int sys_exec(void);
extern int sys_exit(void);
extern int sys_fork(void);
extern int sys_fstat(void);
extern int sys_getpid(void);
extern int sys_kill(void);
extern int sys_link(void);
extern int sys_mkdir(void);
extern int sys_mknod(void);
extern int sys_open(void);
extern int sys_pipe(void);
extern int sys_read(void);
extern int sys_sbrk(void);
extern int sys_sleep(void);
extern int sys_unlink(void);
extern int sys_wait(void);
extern int sys_write(void);
extern int sys_uptime(void);
extern int sys_halt(void);
extern int sys_toggle(void);
extern int sys_ps(void);
extern int sys_send(void);
extern int sys_recv(void);
extern int sys_create_container(void);
extern int sys_destroy_container(void);
extern int sys_join_container(void);
extern int sys_leave_container(void);
extern int sys_getcid(void);
extern int sys_scheduler_log(void);




static int (*syscalls[])(void) = {
[SYS_fork]    sys_fork,
[SYS_exit]    sys_exit,
[SYS_wait]    sys_wait,
[SYS_pipe]    sys_pipe,
[SYS_read]    sys_read,
[SYS_kill]    sys_kill,
[SYS_exec]    sys_exec,
[SYS_fstat]   sys_fstat,
[SYS_chdir]   sys_chdir,
[SYS_dup]     sys_dup,
[SYS_getpid]  sys_getpid,
[SYS_sbrk]    sys_sbrk,
[SYS_sleep]   sys_sleep,
[SYS_uptime]  sys_uptime,
[SYS_open]    sys_open,
[SYS_write]   sys_write,
[SYS_mknod]   sys_mknod,
[SYS_unlink]  sys_unlink,
[SYS_link]    sys_link,
[SYS_mkdir]   sys_mkdir,
[SYS_close]   sys_close,
[SYS_halt]    sys_halt,
[SYS_toggle]  sys_toggle,
[SYS_ps]      sys_ps,
[SYS_create_container] sys_create_container,
[SYS_destroy_container] sys_destroy_container,
[SYS_join_container] sys_join_container,
[SYS_leave_container] sys_leave_container,
[SYS_send]	  sys_send,
[SYS_recv]    sys_recv,
[SYS_getcid]      sys_getcid,
[SYS_scheduler_log] sys_scheduler_log,
};

// static int (*syscalls2[])(int,int) = {
// [SYS_add]     sys_add,
// };



void
syscall(void)
{

  if(syscallhappened==0){
  	init_queues();
  	syscallhappened=1;
  }
  int num;
  struct proc *curproc = myproc();

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  }
  // else if(syscalls2[num](int ,int )){
  // 	curproc->tf->eax = syscalls2[num]();
  // }
  else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}

























// code for queues

// #include "queues.h"
// #include "proc.h"
// #include "stdlib.h"
// #include "memlayout.h"

/*
//////////////////////////////////////////////////////
initialising all message buffers
/////////////////////////////////////////////////////
*/
// initialsing the message queues
// call this in init


const int EndOfFreeList = -1;
int lastBufferUsed=0;

// struct messageQueue* createQueue(unsigned capacity)
// {
//     struct messageQueue* mq = (struct messageQueue*) kalloc();
//     mq->capacity = capacity;
//     mq->front = 0;
//     mq->size = 0;
//     mq->last = -1;  // This is important, see the enqueue
//     mq->array = kalloc();
//     return mq;
// }

struct intMessageQueue* createIntQueue(unsigned capacity)
{
    struct intMessageQueue* mq = (struct intMessageQueue*) kalloc();
    mq->capacity = capacity;
    mq->front =0;
    mq->size = 0;
    mq->last = -1;  // This is important, see the enqueue
    mq->arr = (int*) kalloc();
    return mq;
}

struct waitQueue* createWaitQueue(unsigned capacity)
{
    struct waitQueue* mq = (struct waitQueue*) kalloc();
    mq->capacity = capacity;
    mq->front = 0;
    mq->size = 0;
    mq->last = -1;  // This is important, see the enqueue
    mq->array = (struct waitQueueItem*) kalloc();
    return mq;
}


void
init_queues(void)
{
  unsigned capacity = 50;             // capacity of one message quque
  for(int p = 0; p < NPROC; p++){
    // message_quque[p] = createQueue(capacity);
    int_message_queue[p] = createIntQueue(capacity);
    wait_queue[p] = createWaitQueue(capacity);
  }
}



// int isFull(struct messageQueue* mq)
// {  return (mq->size == mq->capacity);  }


// int isEmpty(struct messageQueue* mq)
// {  return (mq->size == 0); }


// void enqueue(struct messageQueue* mq, struct oneBuffer item)
// {
//     if (isFull(mq))
//         return;
//     mq->rear = (mq->rear + 1)%mq->capacity;
//     mq->array[mq->rear] = item;
//     mq->size = mq->size + 1;
//     // printf("%d enqueued to queue\n", item);
// }

// oneBuffer dequeue(struct messageQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
// {

//     if (isEmpty(mq))
//         cprintf("dequeue from EMPTY\n");
//     oneBuffer item = mq->array[mq->front];
//     mq->front = (mq->front + 1)%mq->capacity;
//     mq->size = mq->size - 1;
//     return item;
// }


int isWaitFull(struct waitQueue* mq)
{
	if(mq->size == mq->capacity)
	return 1;
	else return 0;
}


int isWaitEmpty(struct waitQueue* mq)
{
	if(mq->size == 0)
	return 1;
	else return 0;
}


void waitenqueue(struct waitQueue* mq, struct waitQueueItem item)
{
    if (isWaitFull(mq))
        return;
    mq->last = mq->last + 1;
    mq->array[mq->last] = item;
    mq->size = mq->size + 1;
    // printf("%d enqueued to queue\n", item);
}

struct waitQueueItem waitdequeue(struct waitQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{

    // if (isEmpty(mq))
    //     return;
    struct waitQueueItem item = mq->array[mq->front];
    mq->front = (mq->front + 1)%mq->capacity;
    mq->size = mq->size - 1;
    return item;
}




/////////////////////////////////////////////////////////

int isFull(struct intMessageQueue* mq)
{  if(mq->size == mq->capacity)
	return 1;
	else return 0;
}


int isEmpty(struct intMessageQueue* mq)
{
	if(mq->size == 0)
	return 1;
	else return 0;
}


void enqueue(struct intMessageQueue* mq, int item)
{
    if (isFull(mq))
        return;
    mq->last = (mq->last + 1)%mq->capacity;
    mq->arr[mq->last] = item;
    mq->size = mq->size + 1;
    // printf("%d enqueued to queue\n", item);
}

int dequeue(struct intMessageQueue* mq)                // ALWAYS CHECK IF EMPTY BEFORE USING DEQUEUE
{

    if (isEmpty(mq))
        {cprintf("dequeue from EMPTY\n");return -3;}
    int item = mq->arr[mq->front];
    mq->front = (mq->front + 1)%mq->capacity;
    mq->size = mq->size - 1;
    return item;
}





/*
/////////// COPY TO SYSTEM SPACE AND COPY FROM SYSTEM SPACE///////
*/

void
copyToSystemSpace(char *from,char *to, int len)
{
	// from = P2V(from);
	while(len-->0){
		*to++= *from++;
		// to++;
		// from++;
	}
}

void
copyFromSystemSpace(char *to,char *from, int len)
{
	// to = P2V(to);
	while(len-->0){
		*to++= *from++;
		// to++;
		// from++;
	}
}


int
getMessageBuffer(void)
{
	// int msg_no = free_message_buffer;
	// if(msg_no != EndOfFreeList){
	// 	free_message_buffer = messageBuffers[msg_no][0];
	// }
	// return msg_no;

	lastBufferUsed++;
	int m = lastBufferUsed;
	lastBufferUsed++;

	return m;

}

void
freeMessageBuffer(int msg_no)
{
	messageBuffers[msg_no][0]= free_message_buffer;
	free_message_buffer = msg_no;
}

// code for queues

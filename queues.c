#include "queues.h"
#include "proc.h"
#include "stdlib.h"
#include "memlayout.h"

/*
//////////////////////////////////////////////////////
initialising all message buffers
/////////////////////////////////////////////////////
*/
// initialsing the message queues
// call this in init


EndOfFreeList = -1;


// struct messageQueue* createQueue(unsigned capacity) 
// { 
//     struct messageQueue* mq = (struct messageQueue*) malloc(sizeof(struct messageQueue)); 
//     mq->capacity = capacity; 
//     mq->front =0;
//     mq->size = 0;  
//     // mq->rear = capacity - 1;  // This is important, see the enqueue 
//     mq->array = (oneBuffer*) malloc(mq->capacity * sizeof(oneBuffer)); 
//     return mq; 
// }

struct intMessageQueue* createIntQueue(unsigned capacity) 
{ 
    struct intMessageQueue* mq = (struct intMessageQueue*) malloc(sizeof(struct intMessageQueue)); 
    mq->capacity = capacity; 
    mq->front = 0;
    mq->size = 0;  
    // mq->rear = capacity - 1;  // This is important, see the enqueue 
    mq->arr = (int*) kalloc(); 
    return mq; 
}

struct waitQueue* createWaitQueue(unsigned capacity) 
{ 
    struct waitQueue* mq = (struct waitQueue*) kalloc(); 
    mq->capacity = capacity; 
    mq->front=0;
    mq->size = 0;  
    // mq->rear = capacity - 1;  // This is important, see the enqueue 
    mq->array = (struct waitQueueItem*) kalloc(); 
    return mq; 
}


void
init_queues(void)
{ 
  unsigned capacity = 50;             // capacity of one message quque
  for(int p = 0; p < NPROC; p++){
    // message_quque[p] = createQueue(capacity);
    int_message_quque[p] = createIntQueue(capacity); 
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
{  return (mq->size == mq->capacity);  } 
  

int isWaitEmpty(struct waitQueue* mq) 
{  return (mq->size == 0); } 
  

void waitenqueue(struct waitQueue* mq, struct waitQueueItem item) 
{ 
    if (isWaitFull(mq)) 
        return; 
    mq->rear = (mq->rear + 1)%mq->capacity; 
    mq->array[mq->rear] = item; 
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
{  return (mq->size == mq->capacity);  } 
  

int isEmpty(struct intMessageQueue* mq) 
{  return (mq->size == 0); } 
  

void enqueue(struct intMessageQueue* mq, int item) 
{ 
    if (isFull(mq)) 
        return; 
    mq->rear = (mq->rear + 1)%mq->capacity; 
    mq->arr[mq->rear] = item; 
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
copyToSystemSpace(char* from;char* to; int len)
{
	// from = P2V(from);
	while(len-->0){
		*to++ = *from++;
	}
}

void
copyFromSystemSpace(char* to;char* from; int len)
{
	// to = P2V(to);
	while(len-->0){
		*to++ = *from++;
	}
}


int 
getMessageBuffer(void)
{
	int msg_no = free_message_buffer;
	if(msg_no != EndOfFreeList){
		free_message_buffer = message_buffer[msg_no][0];
	}
	return msg_no;
}

void 
freeMessageBuffer(int msg_no)
{
	message_buffer[msg_no][0]= free_message_buffer;
	free_message_buffer = msg_no;
}
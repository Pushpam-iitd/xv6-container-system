#define NumberOfMessageQueues 64             // NPROCS is the number of message queues.
#define NumberOfMessageBuffers 200


typedef char* oneBuffer;       //the buffer of 8 bytes, have to malloc the space

const int EndOfFreeList ;

struct intMessageQueue
{
	int front,rear,size;
	unsigned capacity;
	int* arr;
};

struct messageQueue 
{ 
    int front, rear, size; 
    unsigned capacity;
    oneBuffer* array; 
};


struct waitQueueItem 
{ 
    // int front, rear, size;
    int pid; 
    char* buffer; 
};


struct waitQueue 
{ 
    int front, rear, size;
    unsigned capacity; 
    struct waitQueueItem* array; 
};



oneBuffer messageBuffers[NumberOfMessageBuffers];    // define Number of Message Buffers
int free_message_buffer;


int message_queue_allocated[NumberOfMessageQueues];  // to define -> NumberOfMessageQueues
struct messageQueue *message_queue[NumberOfMessageQueues]; 
struct waitQueue *wait_queue[NumberOfMessageQueues];
struct intMessageQueue *int_message_queue[NumberOfMessageQueues];

// int isFull(struct messageQueue* mq);
// int isEmpty(struct messageQueue* mq); 
// void enqueue(struct messageQueue* mq, oneBuffer item); 
// oneBuffer dequeue(struct messageQueue* mq); 
int isFull(struct intMessageQueue* mq);
int isEmpty(struct intMessageQueue* mq); 
void enqueue(struct intMessageQueue* mq, int item); 
int dequeue(struct intMessageQueue* mq); 

int isWaitFull(struct waitQueue* mq); 
int isWaitEmpty(struct waitQueue* mq); 
void waitenqueue(struct waitQueue* mq, struct waitQueueItem item);
struct waitQueueItem waitdequeue(struct waitQueue* mq); 
void init_queues(void);
void copyToSystemSpace(char* from,char* to, int len);
void copyFromSystemSpace(char* to,char* from, int len);
int getMessageBuffer(void);
void freeMessageBuffer(int msg_no);
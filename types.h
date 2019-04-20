typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;
typedef uint pde_t;


#define MSGSIZE 8

struct container{
  int cid;  //container id
  int number_of_process;
  int number_of_files;
  int mypid[100]; // pids belonging to the container
  char* container_files[100];
  int copied_or_not[100];
  short type[100];
  uint ino[100];
  uint size[100];
};

extern struct container container_array[100];
extern int container_location[100];

extern char* all_files[100];
extern int corresponding_cid[100];
extern int num_all_files;


struct container container_array[100];
int container_location[100];

char* all_files[100];
int corresponding_cid[100];
int num_all_files;


// code for queues


#define NumberOfMessageQueues 64             // NPROCS is the number of message queues.
#define NumberOfMessageBuffers 500


typedef char* oneBuffer;       //the buffer of 8 bytes, have to malloc the space

const int EndOfFreeList ;
int lastBufferUsed;            // to keeptrack of the buffers used.

struct intMessageQueue
{
	int front,last,size;      // struct of the meaage queue object
	unsigned capacity;
	int* arr; 				 // queue of int
};



struct waitQueueItem
{ 							// waitqueue item containes the pid of process
    int pid; 				// and the buffer to recieve the message
    char* buffer;
};


struct waitQueue
{
    int front, last, size;		// struct of the wait queue object
    unsigned capacity;
    struct waitQueueItem* array;    // queue of waitqueue item
};


struct messageQueue
{
    int front, last, size;
    unsigned capacity;
    oneBuffer* array;
};


oneBuffer messageBuffers[NumberOfMessageBuffers];    // define Number of Message Buffers
int free_message_buffer;


int message_queue_allocated[NumberOfMessageQueues];  // to define -> NumberOfMessageQueues
struct waitQueue *wait_queue[NumberOfMessageQueues];
struct intMessageQueue *int_message_queue[NumberOfMessageQueues];

struct messageQueue *message_queue[NumberOfMessageQueues];

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

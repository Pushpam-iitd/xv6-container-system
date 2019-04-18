#include "types.h"
#include "stat.h"
#include "user.h"





char* my_itoa(int i, char* b){
    char const digit[] = "0123456789";
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
    *p = '\0';
    do{
        *--p = digit[i%10];
        i = i/10;
    }while(i);
    return b;
}


// int my_atoi(char *str)
// {
//   int result=0;
//   // int puiss;

//   // result = 0;
//   // puiss = 1;
//   // while (('-' == (*str)) || ((*str) == '+'))
//   // {
//   //     if (*str == '-')
//   //       puiss = puiss * -1;
//   //     str++;
//   // }
//   while ((*str >= '0') && (*str <= '9'))
//   {
//       result = (result * 10) + ((*str) - '0');
//       str++;
//   }
//   return (result);
// }



int
main(int argc, char *argv[])
{	


	// printf(1,"here inside \n");
	if(argc< 2){
		printf(1,"Need type and input filename\n");
		exit();
	}
	char *filename;
	filename=argv[2];
	int type = atoi(argv[1]);
	printf(1,"Type is %d and filename is %s\n",type, filename);

	int tot_sum = 0;	
	float variance = 0.0;

	int size=1000;
	short arr[size];
	char c;
	int fd = open(filename, 0);

	// int pid_array[10];        // 0 is the parent process.
	// for(int i =0;i<10;i++){
		// pid_array[i] = -2;
	// } 

	for(int i=0; i<size; i++){
		read(fd, &c, 1);
		arr[i]=c-'0';
		read(fd, &c, 1);
	}	
  	close(fd);
  	// this is to supress warning
  	printf(1,"first elem %d\n", arr[0]);
  
  	//----FILL THE CODE HERE for unicast sum and multicast variance

  	// int nChildren = 8;

    int parent=getpid();

    int k;
    int pid;
    for (k = 0; k < 8; k++) {
        pid = fork();
        if (pid == -1) {
            printf(1,"fork failed\n");
            // return;
            break;
        }
        if (pid == 0) {              // child process
            break;
        }
    }

    if(pid==0){

            int temp_sum=0;
            int per_process_length = 125;
            
            int start = k*per_process_length;
            int end = start + per_process_length;

            for(int j= start;j<end;j++){            // calculating the partial sum, 
                temp_sum += arr[j];                 // depending on the index of the child process
            }
            
            char *msg_tosend = (char *)malloc(MSGSIZE);
            strcpy(msg_tosend,my_itoa(temp_sum,msg_tosend));     

            send(pid,parent,msg_tosend);               // sending to the parent process
            free(msg_tosend);
            exit();
            }
    
    else{
        	// printf("I am a child: %d ",k, );
            // sleep (5);
            // if(parent==-2){
            // 	// pid_array[0] = getpid();
            //     parent = getpid();
            //     printf(1,"parent is%d\n",parent); 
            // }
            // if(k!=0)
            // pid_array[k] = pid;
            // printf(1,"inside else d \n");
            for(int i =0;i<8;i++){
            char *msg = (char *)malloc(MSGSIZE);
            int stat=-1;
            while(stat==-1){
            stat = recv(msg);
            // printf(1,"message recieved 1\n");
            sleep(1);
            }
            int s = atoi(msg);
            tot_sum += s;
            }

            // code for add
            // int temp_sum=0;
            // int per_process_length = 125;
            
            // int start = k*per_process_length;
            // int end = start + per_process_length;
            // for(int j= start;j<end;j++){
            // 	temp_sum += arr[j];
            // }
            // proc_sum[k] =temp_sum;

        }
    
	// }


// sleep(100);
// if(getpid()==parent){

// 	    for(int i =0;i<10;i++){
	    	
// 	    	printf(1,"pid of process %d is %d\n",i,pid_array[i]);
// 	    }
        
//         int temp_sum=0;

//         for(int j= 0;j<125;j++){
//                 temp_sum += arr[j];
//         }
//         tot_sum  += temp_sum;

//             // char *msg_tosend = (char *)malloc(MSGSIZE);
//             // send(getpid(),parent,my_itoa(proc_sum,msg_tosend)); 

//         // recieve the messages

//         for(int i =0;i<7;i++){
//         char *msg = (char *)malloc(MSGSIZE);
//         int stat=-1;
//         while(stat==-1){
//             stat = recv(msg);
//             // printf(1,"message recieved \n");
//         }
//         int s = my_atoi(msg);
//         tot_sum += s;
//         }

//         // for(int j= 0;j<8;j++){
//         //         tot_sum += proc_sum[j];
//         // }
	    
//         printf(1,"final sum is %d \n",tot_sum);
// }

// printf(1,"final sum is %d \n",tot_sum);

  	//------------------

  	if(type==0){ //unicast sum
		printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
	}
	else{ //mulicast variance
        // just to print
        // variance++;
		printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
	}
	exit();
}

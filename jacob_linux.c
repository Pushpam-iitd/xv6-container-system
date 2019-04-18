// #include "types.h"
// #include "stat.h"
// #include "user.h"
#include <math.h>
#include <stdio.h>
#include<unistd.h>
// #include <time.h>

// #define N 12
// #define E 0.00001
// #define T 100.0
// #define P 2
// #define L 20000

float fabsm(float a){
	if(a<0)
	return -1*a;
return a;
}

int main(int argc, char *argv[])
{	


	// void read_ints (const char* file_name)
// {
  FILE* file = fopen ("assig2a.inp", "r");
  int N = 0;
  float E = 0.0;
  float T = 0.0;
  int P =0;
  int L =0; 

  fscanf (file, "%d %f %f %d %d", &N,&E,&T,&P,&L);    
  fclose (file);        

   // printf( "params are  %d %f %f %d %d", N,E,T,P,L);
// }

    // clock_t t; 
    // t = clock(); 



	float diff;
	int i,j;
	float mean;
	float u[N][N];
	float w[N][N];


	int pipedown[P-1][2];
	int parentpipe[P][2];
	int ret[P];
	int returnstatus[P-1];
	int pipeup[P-1][2];
	int returnstatus2[P-1];
	for (int i = 0; i < P-1; ++i)
	{
		returnstatus[i] = pipe(pipedown[i]);
		if (returnstatus[i] == -1) {
	      printf("Unable to create pipe %d \n", i);
	      return 1;
	    }

	    returnstatus2[i] = pipe(pipeup[i]);
		if (returnstatus2[i] == -1) {
	      printf("Unable to create pipe2 %d \n", i);
	      return 1;
	    }

	}	

	for (int i = 0; i < P; ++i)
	{
		ret[i] = pipe(parentpipe[i]);
			if (ret[i] == -1) {
		      printf("Unable to create pipe p  %d \n", i);
		      return 1;
		  }
	}


	int co = 0;
	int co2 =0;
	int count = 0;
	mean = 0.0;
	for (i = 0; i < N; i++){
		u[i][0] = u[i][N-1] = u[0][i] = T;
		u[N-1][i] = 0.0;
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
	}
	mean /= (4.0 * N);
	for (i = 1; i < N-1; i++ )
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
	
// my code
	int pid;
	int k;
	for ( k = 0; k < P; ++k)
	{
		pid = fork();
		if (pid == -1) {
            printf("fork failed\n");
            // return;
            break;
        }
        if (pid == 0) {              // child process
            break;
        }
	}

	int perprocess = N/P;
	if(pid == 0)
	{	
		// printf("we are in process %d \n",k );
		int start =  k*perprocess;
		int end  =  start + perprocess;
		if(k == 0) start = 1;
		if(k == P-1) end = N-1;

		for(;;){
				// if(k==0) printf("in first, start and end are %d  %d\n",start, end);

				diff = 1.3;
				for(i =start ; i < end; i++){
					for(j =1 ; j < N-1; j++){
						w[i][j] = ( u[i-1][j] + u[i+1][j]+
							    u[i][j-1] + u[i][j+1])/4.0;
						if( fabsm(w[i][j] - u[i][j]) > diff )
							diff = fabsm(w[i][j]- u[i][j]);	
					}
				}
			    count++;

			
				for (i =start; i< end; i++)	
					for (j =1; j< N-1; j++) u[i][j] = w[i][j];
			
			// send the value of boundary rows to adjacent processes.
				if(k!=0){
					write(pipeup[k-1][1], &u[start], sizeof(u)/N);
				}

				if(k!=P-1){
					write(pipedown[k][1], &u[end-1], sizeof(u)/N);
				}
			// recieve the value of rows and update.
				if(k!=0){

					read(pipedown[k-1][0], &u[start-1], sizeof(u)/N);
				}
				if(k!=P-1){
					read(pipeup[k][0], &u[end], sizeof(u)/N);
				}

				if(diff<= E || count > L){ 
					break;
				}
			
			}

			write(parentpipe[k][1], &u[start], sizeof(u)*(end-start)/N);
			exit(1);
			
	}


else{

	int pk ;
	for ( pk = 0; pk < P; ++pk)
	{

	int start =  pk*perprocess;
	int end  =  start + perprocess;
	if(pk == 0) start = 1;
	if(pk == P-1) end = N-1;
	read(parentpipe[pk][0], &u[start], sizeof(u)*(end-start)/N);	
	}
	
	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
			printf("%d ",((int)u[i][j]));
		printf("\n");
	}
}


    // fun(); 
    // t = clock() - t; 
    // double time_taken = ((double)t)/CLOCKS_PER_SEC;
    // printf("time taken is %f\n",time_taken);

}

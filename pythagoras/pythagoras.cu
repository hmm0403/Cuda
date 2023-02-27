#include <cstdio>

#define CHECK_CUDA(call)                                                 \
  do {                                                                   \
    cudaError_t status_ = call;                                          \
    if (status_ != cudaSuccess) {                                        \
      fprintf(stderr, "CUDA error (%s:%d): %s:%s\n", __FILE__, __LINE__, \
              cudaGetErrorName(status_), cudaGetErrorString(status_));   \
      exit(EXIT_FAILURE);                                                \
    }                                                                    \
  } while (0)

__global__ void pythagoras(int *pa, int *pb, int *pc, int *pd){

    int a = *pa;
    int b = *pb;
    int c = *pc;

    if((a * a + b * b) == c * c ){
        *pd = 1;
    }else{
        *pd = 0;
    }

}

int main(int argc, char *argv[]) {
    if(argc != 4){
        printf("Usage: %s <num 1> <num 2> <num 3>\n", argv[0]);
        return 0;
    }

    int *d_a, *d_b, *d_c, *d_d;
    cudaMalloc(&d_a, sizeof(int));
    cudaMalloc(&d_b, sizeof(int));
    cudaMalloc(&d_c, sizeof(int));
    cudaMalloc(&d_d, sizeof(int));

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    int c = atoi(argv[3]);
    int d;

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_c, &c, sizeof(int), cudaMemcpyHostToDevice);
    pythagoras<<<1, 10>>>(d_a, d_b, d_c, d_d);
    cudaMemcpy(&d, d_d, sizeof(int), cudaMemcpyDeviceToHost);
    if(d == 1){
        printf("YES\n");
    }
    else{
        printf("No\n");
    }
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    cudaFree(d_d);
    return 0;
}

#include <cstdio>
#define CHECK_CUDA(call)                                                 \
  do {                                                                   \
    cudaError_t status_ = call;                                          \
    if (status_ != cudaSuccess) {                                        \
      fprintf(stderr, "CUDA error (%s:%d): %s:%s\n", __FILE__, __LINE__, \
              cudaGetErrorName(status_),                                 \
              cudaGetErrorString(status_));                              \
      exit(EXIT_FAILURE);                                                \
    }                                                                    \
  } while (0)

#define MAX_GPUS 8 // maximum number of GPUs possible

int main() {
    int count;
    cudaGetDeviceCount(&count);
    printf("Number of devices: %d\n",count);
    cudaDeviceProp props[MAX_GPUS];
    for(int d = 0; d< count; ++d){
        printf("device %d:\n", d);
        cudaGetDeviceProperties(&props[d], d);

        printf("\t\tname : %s\n", props[d].name);
        printf("\t\tmultiProcessorCount : %d\n", props[d].multiProcessorCount);
        printf("\t\tmaxThreadsPerBlock : %d\n", props[d].maxThreadsPerBlock);
        printf("\t\ttotalGlobalMem : %lu\n", props[d].totalGlobalMem);
        printf("\t\tsharedMemPerBlock : %lu\n", props[d].sharedMemPerBlock);
  }
  return 0;
}

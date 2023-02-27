#include <cstdio>

// CUDA 커널을 정의해 GPU에서 실행할 코드 구현
__global__ void hello_world() {
  printf("Thread %d: Hello, World!\n", threadIdx.x);
}

int main() {
    hello_world<<<1, 32>>>();
    cudaDeviceSynchronize();
  return 0;
}

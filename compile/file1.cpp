#include <cuda_runtime.h>

#include <cstdio>

void call_test_kernel(void);
int main() {
  call_test_kernel();
  cudaDeviceSynchronize();
  return 0;
}
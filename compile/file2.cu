#include <cstdio>

__global__ void test_kernel() { /* Do nothing */
}

void call_test_kernel(void) {
  printf("Hello\n");
  test_kernel<<<1, 1>>>();
}

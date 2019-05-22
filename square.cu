#include <stdio.h>
#include <cuda.h>
 

__global__ void square_cuda(float *a, int N) {
  int idx = blockIdx.x * blockDim.x + threadIdx.x;
  if (idx<N) a[idx] = a[idx] * a[idx];
}

extern "C" {

void square(float *a, int N) {
  float* a_d;
  size_t size = N * sizeof(float);
  cudaMalloc((void **) &a_d, size);   
  cudaMemcpy(a_d, a, size, cudaMemcpyHostToDevice);

  int block_size = 4;
  int n_blocks = N/block_size + (N%block_size == 0 ? 0:1);
  square_cuda <<< n_blocks, block_size >>> (a_d, N);

  cudaMemcpy(a, a_d, size, cudaMemcpyDeviceToHost);
  cudaFree(a_d);
}

}

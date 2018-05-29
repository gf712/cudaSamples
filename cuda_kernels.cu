//
// Created by gil on 29/05/18.
//
#include <device_launch_parameters.h>
#include "cuda_kernels.h"
#include "cuda_cpp.h"

__global__ void square(float* d_in, float* d_out) {

    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    float f = d_in[idx];
    d_out[idx] = f * f;
}

__global__ void vector_dot_product(float* d_u, float* d_v, float* d_out) {

    // each block of threads has its own shared memory,
    // so can declare an array where we store results accessible by all the threads in block
    __shared__ float cache[THREADS_PER_BLOCK];

    // first calculate element product
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    cache[threadIdx.x] = d_u[idx] * d_v[idx];

    __syncthreads();

    // thread 0 will be responsible for adding the results
    if (threadIdx.x == 0) {
        float sum = 0;
        for (int i = 0; i < THREADS_PER_BLOCK; ++i) {
            sum += cache[i];
        }
        atomicAdd(d_out, sum);
    }
}

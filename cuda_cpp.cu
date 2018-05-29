//
// Created by gil on 29/05/18.
//

#include "cuda_cpp.h"
#include "cuda_kernels.h"
#include <iostream>

void square_gpu(float *h_in, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES) {

    // C pointers to point to CUDA memory
    float *d_in;
    float *d_out;

    // allocate GPU memory
    // cudaMalloc((void**) C pointer, size of C pointer)
    cudaMalloc((void **) &d_in, ARRAY_BYTES);
    cudaMalloc((void **) &d_out, ARRAY_BYTES);

    // copy array from CPU to GPU
    // cudaMemcpy(GPU pointer, CPU pointer, pointer size, cudaMemcpyHostToDevice/cudaMemcpyDeviceToHost/cudaMemcpyDeviceToDevice)
    cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

    // launch kernel with GPU pointer
    //   -> ARRAY_SIZE+THREADS_PER_BLOCK-1 ensures that we always launch at least one thread block for N > 0
    square <<< (ARRAY_SIZE+THREADS_PER_BLOCK-1) / THREADS_PER_BLOCK, THREADS_PER_BLOCK>>> (d_in, d_out);

    // copy GPU pointer to CPU pointer
    cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

    // free cuda memory
    cudaFree(d_in);
    cudaFree(d_out);
}


void vector_dot_product_gpu(float *h_u, float* h_v, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES) {

    // C pointers to point to CUDA memory
    float *d_v;
    float *d_u;
    float *d_out;

    // allocate GPU memory
    // cudaMalloc((void**) C pointer, size of C pointer)
    cudaMalloc((void **) &d_v, ARRAY_BYTES);
    cudaMalloc((void **) &d_u, ARRAY_BYTES);
    // store result (a scalar) in a one element array -> size = sizeof(float)
    cudaMalloc((void **) &d_out, sizeof(float));

    // copy array from CPU to GPU
    // cudaMemcpy(GPU pointer, CPU pointer, pointer size, cudaMemcpyHostToDevice/cudaMemcpyDeviceToHost/cudaMemcpyDeviceToDevice)
    cudaMemcpy(d_v, h_v, ARRAY_BYTES, cudaMemcpyHostToDevice);
    cudaMemcpy(d_u, h_u, ARRAY_BYTES, cudaMemcpyHostToDevice);
//    cudaMemcpy(d_out, h_out, sizeof(float), cudaMemcpyHostToDevice);

    // launch kernel with GPU pointer
    //   -> ARRAY_SIZE+THREADS_PER_BLOCK-1 ensures that we always launch at least one thread block for N > 0
    vector_dot_product <<< (ARRAY_SIZE+THREADS_PER_BLOCK-1) / THREADS_PER_BLOCK, THREADS_PER_BLOCK>>> (d_u, d_v, d_out);

    // copy GPU pointer to CPU pointer
    cudaMemcpy(h_out, d_out, sizeof(float), cudaMemcpyDeviceToHost);

    // free cuda memory
    cudaFree(d_v);
    cudaFree(d_u);
    cudaFree(d_out);
}
//
// Created by gil on 29/05/18.
//

#include "cuda_cpp.h"
#include "cuda_kernels.h"

void square_cpp(float *h_in, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES) {

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
    square <<< 1, ARRAY_SIZE >>> (d_in, d_out);

// copy GPU pointer to CPU pointer
    cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

// free cuda memory
    cudaFree(d_in);
    cudaFree(d_out);
}
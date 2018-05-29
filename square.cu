//
// Created by gil on 18/12/17.
//
#include <cstdio>
#include "cuda_kernels.h"

int main() {

    int ARRAY_SIZE = 64;
    int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    // initialise array (in CPU)
    float h_in[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        h_in[i] = static_cast<float>(i);
    }
    float h_out[ARRAY_SIZE];

    // C pointers to point to CUDA memory
    float* d_in;
    float* d_out;

    // allocate GPU memory
    // cudaMalloc((void**) C pointer, size of C pointer)
    cudaMalloc((void**) &d_in, ARRAY_BYTES);
    cudaMalloc((void**) &d_out, ARRAY_BYTES);

    // copy array from CPU to GPU
    // cudaMemcpy(GPU pointer, CPU pointer, pointer size, cudaMemcpyHostToDevice/cudaMemcpyDeviceToHost/cudaMemcpyDeviceToDevice)
    cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

    // launch kernel with GPU pointer
    square <<<1, ARRAY_SIZE>>>(d_in, d_out);

    // copy GPU pointer to CPU pointer
    cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

    // print result
    for (int j = 0; j < ARRAY_SIZE; ++j) {
        if (j == 0) {
            printf("[%f\t", h_out[j]);
        }

        else {
            printf(" %f", h_out[j]);

            if (j == ARRAY_SIZE - 1) {
                printf("]\n");
            } else if ((j + 1) % 4 == 0 && j > 0) {
                printf(",\n");
            } else {
                printf(",\t");
            }
        }
    }

    // free cuda memory
    cudaFree(d_in);
    cudaFree(d_out);

    return 0;
}
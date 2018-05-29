//
// Created by gil on 29/05/18.
//
#include "cuda_kernels.h"

__global__ void square(float* d_in, float* d_out) {

    int idx = threadIdx.x;
    float f = d_in[idx];
    d_out[idx] = f * f;

}

__global__ void vector_dot_product(float* u, float* v, float* out) {



}

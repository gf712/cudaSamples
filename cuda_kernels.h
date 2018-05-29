//
// Created by gil on 29/05/18.
//

#ifndef CUDASAMPLES_CUDA_KERNELS_H
#define CUDASAMPLES_CUDA_KERNELS_H

// helps out with highlighting in CLion IDE
// https://stackoverflow.com/questions/39980645/enable-code-indexing-of-cuda-in-clion
#ifdef __JETBRAINS_IDE__
#define __host__
#define __device__
#define __shared__
#define __constant__
#define __global__
#define cudaMemcpyHostToDevice
#define cudaMemcpyDeviceToHost

typedef unsigned int uint;

typedef struct uint3{
    uint x;
    uint y;
    uint z;
}uint3;

extern uint3 threadIdx;
#endif

__global__ void square(float* d_in, float* d_out);
__global__ void vector_dot_product(float* u, float* v, float* out);

//void square_cpp(float *h_in, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES);

#endif //CUDASAMPLES_CUDA_KERNELS_H

//
// Created by gil on 29/05/18.
//

#ifndef CUDASAMPLES_CUDA_CPP_H
#define CUDASAMPLES_CUDA_CPP_H

#define THREADS_PER_BLOCK 512

void square_gpu(float *h_in, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES);

#endif

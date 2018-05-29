//
// Created by gil on 29/05/18.
//

#include "cuda_cpp.h"
#include "utils.h"
#include <chrono>
#include <cstdlib>
#include <iostream>

#define TOLERANCE 10e-9

void vector_dot_product_cpu(float *h_u, float *h_v, float *h_out, int ARRAY_SIZE) {

    for (int i = 0; i < ARRAY_SIZE; ++i) {
        *h_out += h_u[i] * h_v[i];
    }

}


int main() {

    int ARRAY_SIZE = 512;
    int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    // initialise array (in CPU)
    float h_u[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        h_u[i] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX/100);
    }
    float h_v[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        h_v[i] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX/100);
    }

    float h_out_cpu[1];
    h_out_cpu[0] = 0;
    float h_out_gpu[1];
    h_out_gpu[0] = 0;

    auto start = std::chrono::high_resolution_clock::now();

    vector_dot_product_gpu(h_u, h_v, h_out_gpu, ARRAY_SIZE, ARRAY_BYTES);

    auto end = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::microseconds>( end - start ).count();

    printf("[GPU] Elapsed time is %li microseconds.\n", duration);

    start = std::chrono::high_resolution_clock::now();

    vector_dot_product_cpu(h_u, h_v, h_out_cpu, ARRAY_SIZE);

    end = std::chrono::high_resolution_clock::now();

    duration = std::chrono::duration_cast<std::chrono::microseconds>( end - start ).count();

    printf("[CPU] Elapsed time is %li microseconds.\n", duration);

    std::cout << h_out_cpu[0] << std::endl;
    std::cout << h_out_gpu[0] << std::endl;

    if (h_out_cpu[0] - h_out_gpu[0] < TOLERANCE)
        printf("Value mismatch by [%f]\n", h_out_cpu[0] - h_out_gpu[0]);

    return 0;
}
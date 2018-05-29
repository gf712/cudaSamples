//
// Created by gil on 18/12/17.
//
#include "cuda_cpp.h"
#include "utils.h"
#include <chrono>
#include <cstdlib>
#include <iostream>

//extern "C" void
//void square_cpp(float *h_in, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES);

void square_cpu(float *h_in, float *h_out, int ARRAY_SIZE) {

    for (int i = 0; i < ARRAY_SIZE; ++i) {
        h_out[i] = h_in[i] * h_in[i];
    }

}


int main() {

    int ARRAY_SIZE = 2048;
    int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    // initialise array (in CPU)
    float h_in[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        h_in[i] = static_cast <float> (rand()) / static_cast <float> (RAND_MAX/100);
    }

    float h_out_gpu[ARRAY_SIZE];
    float h_out_cpu[ARRAY_SIZE];

    if (h_out_cpu == nullptr) {
        std::cout << "Error allocation memory" << std::endl;
        return 1;
    }

//    print_array(h_in, ARRAY_SIZE);

    auto start = std::chrono::high_resolution_clock::now();

    square_gpu(h_in, h_out_gpu, ARRAY_SIZE, ARRAY_BYTES);

    auto end = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::microseconds>( end - start ).count();

    printf("[GPU] Elapsed time is %li microseconds.\n", duration);

    start = std::chrono::high_resolution_clock::now();

    square_cpu(h_in, h_out_cpu, ARRAY_SIZE);

    end = std::chrono::high_resolution_clock::now();

    duration = std::chrono::duration_cast<std::chrono::microseconds>( end - start ).count();

    printf("[CPU] Elapsed time is %li microseconds.\n", duration);

    for (int i = 0; i < ARRAY_SIZE; ++i) {
        if (h_out_cpu[i] != h_out_gpu[i]) {
            printf("Value mismatch at index: %i\n", i);
        }
    }

    return 0;
}
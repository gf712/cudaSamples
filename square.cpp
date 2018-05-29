//
// Created by gil on 18/12/17.
//
#include "cuda_cpp.h"
#include "utils.h"

//extern "C" void
//void square_cpp(float *h_in, float *h_out, int ARRAY_SIZE, int ARRAY_BYTES);

int main() {

    int ARRAY_SIZE = 64;
    int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    // initialise array (in CPU)
    float h_in[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; ++i) {
        h_in[i] = static_cast<float>(i);
    }
    float h_out[ARRAY_SIZE];

    square_cpp(h_in, h_out, ARRAY_SIZE, ARRAY_BYTES);

    print_array(h_out, ARRAY_SIZE);

    return 0;
}
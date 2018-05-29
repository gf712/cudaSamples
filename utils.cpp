//
// Created by gil on 29/05/18.
//

#include "utils.h"
#include <cstdio>

void print_array(float* array, int ARRAY_SIZE) {
    for (int j = 0; j < ARRAY_SIZE; ++j) {
        if (j == 0) {
            printf("[%f\t", array[j]);
        } else {
            printf(" %f", array[j]);

            if (j == ARRAY_SIZE - 1) {
                printf("]\n");
            } else if ((j + 1) % 4 == 0 && j > 0) {
                printf(",\n");
            } else {
                printf(",\t");
            }
        }
    }
}
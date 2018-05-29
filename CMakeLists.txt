cmake_minimum_required(VERSION 3.10)
project(cudaSamples)

#set(CMAKE_C_STANDARD 11)

find_package(CUDA QUIET REQUIRED)

cuda_add_library(cuda_kernels STATIC
        cuda_kernels.cu
        cuda_kernels.h)

cuda_add_executable(cudaSquare
        square.cu)

target_link_libraries(cudaSquare cuda_kernels)
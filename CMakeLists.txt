cmake_minimum_required(VERSION 3.9)
project(cudaSamples)

set(CMAKE_CXX_STANDARD 11)

find_package(CUDA REQUIRED)

cuda_add_library(cuda_kernels STATIC
        cuda_kernels.cu
        cuda_kernels.h
        )

cuda_add_library(cuda_cpp STATIC
        cuda_cpp.h
        cuda_cpp.cu
        )

link_libraries(cuda_cpp cuda_kernels)

add_library(utils_cpp utils.cpp utils.h)

cuda_add_executable(cudaSquare
        square.cpp)

target_link_libraries(cudaSquare
        cuda_cpp
        utils_cpp)

cuda_add_executable(cudaDotProduct
        vector_dot_product.cpp)

target_link_libraries(cudaSquare
        cuda_cpp
        utils_cpp)

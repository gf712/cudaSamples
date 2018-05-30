## Repo with CUDA code samples

This is just a repo with some CUDA code to compare with C++ implementations.

### Useful links:
 - Set CLion IDE [here](https://stackoverflow.com/questions/39980645/enable-code-indexing-of-cuda-in-clion)
 - Learn how to program with CUDA [here](https://classroom.udacity.com/courses/cs344)
 - Set up NVCC [here](http://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html)
 
### Build binaries
 - Compile code:
 ```bash
mkdir build
cd build
cmake ..
make
```
 - Run the executables, each one has a CPU and GPU version to do some benchmarking (this is the only behaviour):
   - Square of vector:
```bash
./cudaSquare
```
   - Dot product:
 ```bash
./cudaDotProduct
```

### Structure:
 - cuda_kernels.cu/h:
 >CUDA kernels
 - cuda_cpp.cu/h:
 >Wrappers around CUDA code to launch CUDA kernels from C++
 - utils.cpp/h:
 > C++ misc helpers
 - remaining *.cpp files:
 > C++ code to compile executables to run CPU and GPU calculations
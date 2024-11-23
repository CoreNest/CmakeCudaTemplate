#include "hellow.h"
#include "hellow_GPU.h"
#include <cuda_runtime.h>
#include <chrono>
#include <iostream>

int main()
{
    helloFromCPU();
    helloFromGPU();
    return 0;
}
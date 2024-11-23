#include <iostream>
#include <chrono>
#include <iostream>
class Timer
{
private:
    /* data */
    std::chrono::time_point<std::chrono::steady_clock> start;

public:
    Timer(/* args */) : start(std::chrono::steady_clock::now()) {};
    ~Timer()
    {
        const std::chrono::duration<double> diff = std::chrono::steady_clock::now() - start;
        std::cout << "time:" << diff.count() << std::endl;
    };
};

__global__ void vector_add(float *out, float *a, float *b, int n)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    // int index = 0;
    // int stride = 1;

    for (int i = index; i < n; i += stride)
    {
        out[i] = a[i] + b[i];
    }
}
void helloFromGPU()
{
    float *a, *b, *out;
    float *d_a, *d_b, *d_out;
    int N = 100000000;
    // Allocate memory
    a = (float *)malloc(sizeof(float) * N);
    b = (float *)malloc(sizeof(float) * N);
    out = (float *)malloc(sizeof(float) * N);

    // Initialize array
    for (int i = 0; i < N; i++)
    {
        a[i] = 1.0f;
        b[i] = i;
    }

    // Allocate device memory for a
    cudaMalloc((void **)&d_out, sizeof(float) * N);
    cudaMalloc((void **)&d_a, sizeof(float) * N);
    cudaMalloc((void **)&d_b, sizeof(float) * N);

    // Transfer data from host to device memory
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(float) * N, cudaMemcpyHostToDevice);
    cudaMemcpy(d_out, out, sizeof(float) * N, cudaMemcpyHostToDevice);

    // for (int i{}; i < 10; i++)
    //     std::cout << "Begin" << out[i] << std::endl;
    Timer *t = new Timer;

    // vector_add<<<1, 1>>>(d_out, d_a, d_b, N);
    vector_add<<<255, 255>>>(d_out, d_a, d_b, N);

    std::cout << cudaMemcpy(out, d_out, sizeof(float) * N, cudaMemcpyDeviceToHost);
    delete t;
    // for (int i{}; i < 10; i++)
    //     std::cout << "END" << out[i] << std::endl;

    // Cleanup after kernel execution
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_out);
    free(a);
    free(b);
    free(out);
}

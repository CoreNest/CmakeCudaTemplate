cmake_minimum_required(VERSION 3.15...3.31)

project(My_Lib_Cuda  VERSION 1.0 LANGUAGES CUDA CXX)
SET(Lib_NAME MyCuda)


# Find packages go here.
find_package(CUDAToolkit REQUIRED)
message(STATUS "Found CUDA ${CUDAToolkit_VERSION} at ${CUDAToolkit_LIBRARY_ROOT}")

enable_language(CUDA)


set(CMAKE_CUDA_STANDARD 14)

set(CUDA_SEPARABLE_COMPILATION ON)
set(CUDA_LINK_LIBRARIES_KEYWORD PUBLIC)
# string(APPEND CMAKE_CUDA_FLAGS " -rdc=true --cudart shared")
set(CUDA_RUNTIME_LIBRARY ON)

#inding source file to compile 

file(GLOB_RECURSE SRCS *.cu)

include_directories(./include)

# add_subdirectory("dependency")

add_library(${Lib_NAME} STATIC ${SRCS} )

# set_property(TARGET CUDA_COMP PROPERTY CUDA_ARCHITECTURES 86-real 86-virtual)
target_include_directories(${Lib_NAME} PUBLIC  "./include" )
add_definitions(-DCUDABLAS)
target_link_libraries(${Lib_NAME} PUBLIC CUDA::cublas)
target_link_libraries(${Lib_NAME} PUBLIC CUDA::cudart_static)
target_link_libraries(${Lib_NAME} PUBLIC CUDA::cufft)

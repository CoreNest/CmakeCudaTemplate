cmake_minimum_required(VERSION 3.15...3.31)

project(Templet_Cuda  VERSION 1.0 LANGUAGES CXX CUDA)

SET(APP_NAME Cuda_template)
# set(CMAKE_CXX_STANDARD 17)

# Find packages go here.


file(GLOB_RECURSE SRCS src/*.cpp)

include_directories(./include)

add_subdirectory("dependency")


add_executable(${APP_NAME} ${SRCS} )

target_link_libraries(${APP_NAME} PUBLIC MyLib)
target_link_libraries(${APP_NAME} PUBLIC MyCuda)



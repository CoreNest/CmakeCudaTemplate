cmake_minimum_required(VERSION 3.15...3.31)

project(My_Lib  VERSION 1.0 LANGUAGES CXX)

SET(Lib_NAME MyLib)

# Find packages go here.


file(GLOB_RECURSE SRCS *.cpp)

# include_directories(./include)

# add_subdirectory("dependency")

add_library(${Lib_NAME} ${SRCS} )
target_include_directories(${Lib_NAME} PUBLIC  "./include" )

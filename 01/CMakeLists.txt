CMAKE_MINIMUM_REQUIRED(VERSION 3.18)
PROJECT(DllTest)

# Tell cmake we want it to automate generating an export stub for the dll
SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

ADD_LIBRARY(hello SHARED hello.c)
# hard-coded path is a bad idea outside an experiment.
TARGET_INCLUDE_DIRECTORIES(hello PRIVATE C:\\Users\\PierreBOUTELOUP\\Documents\\perso\\mapf-sandbox\\01\\lua-5.1.5\\src)
TARGET_LINK_LIBRARIES(hello C:\\Users\\PierreBOUTELOUP\\Documents\\perso\\mapf-sandbox\\01\\lua51.lib)
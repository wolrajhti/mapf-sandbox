CMAKE_MINIMUM_REQUIRED(VERSION 3.18)
PROJECT(DllTest)

# Tell cmake we want it to automate generating an export stub for the dll
SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

ADD_LIBRARY(
        mylib SHARED
        mylib.cpp
)

ADD_LIBRARY(middle_lib SHARED middle_lib.cpp)
# hard-coded path is a bad idea outside an experiment.
TARGET_LINK_LIBRARIES(middle_lib C:\\Users\\PierreBOUTELOUP\\Documents\\perso\\mapf-sandbox\\00\\out\\Debug\\mylib.lib)

ADD_EXECUTABLE(experiment main.cpp)
TARGET_LINK_LIBRARIES(experiment middle_lib)
#include <iostream>

extern void mylib_fn();

void middle_lib_fn() {
    std::cout << "middle_lib_fn\n";
    mylib_fn();
}
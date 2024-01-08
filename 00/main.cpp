#include <iostream>

extern void middle_lib_fn();

int main() {
  std::cout << "main\n";
  middle_lib_fn();
}
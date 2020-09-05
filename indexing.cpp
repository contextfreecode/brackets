#include <iostream>
#include <vector>

template<typename Item>
struct Grid {
  // auto operator[](int i, int j) -> Item& {
  //   return values[i][j];
  // }
  auto operator()(int i, int j) -> Item& {
    return values[i][j];
  }
  // Super inefficient nested vectors.
  std::vector<std::vector<Item>> values;
};

// g++ -std=c++17 -o color color.cpp && ./color
// g++ -std=c++20 -o color color.cpp && ./color

auto main() -> int {
  int values[][2] = {{0, 1}, {2, 3}};
  // http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2019/p1161r3.html
  std::cout << values[1, 1] << std::endl;
  auto grid = Grid<int>{{{0, 1}, {2, 3}}};
  // grid(1, 1) = 9;
  std::cout << grid(1, 1) << std::endl;
}

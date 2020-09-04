#include <iostream>
#include <vector>

template<typename Item>
struct Grid2x2 {
  // auto operator[](int i, int j) -> Item {
  //   return values[i][j];
  // }
  auto operator()(int i, int j) -> Item {
    return values[i][j];
  }
  std::vector<std::vector<Item>> values;
};

// g++ -std=c++17 -o color color.cpp && ./color
// g++ -std=c++20 -o color color.cpp && ./color

auto main() -> int {
  int values[][2] = {{0, 1}, {2, 3}};
  std::cout << values[1, 1] << std::endl;
  auto grid = Grid2x2<int>{{{0, 1}, {2, 3}}};
  std::cout << grid(1, 1) << std::endl;
}

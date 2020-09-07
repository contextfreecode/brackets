#include <iostream>
#include <vector>

template<typename Item>
struct Grid {
  // auto operator[](int i, int j) -> Item& {
  //   return values.at(i).at(j);
  // }
  auto operator()(int i, int j) -> Item& {
    return values.at(i).at(j);
  }
  // Super inefficient nested vectors.
  std::vector<std::vector<Item>> values;
};

auto main() -> int {
  int values[][2] = {{0, 1}, {2, 3}};
  std::cout << values[1, 1] << std::endl;
  auto grid = Grid<int>{{{0, 1}, {2, 3}}};
  // grid(1, 1) = 9;
  std::cout << grid(1, 1) << std::endl;
}

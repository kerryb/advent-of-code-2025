defmodule Lobby2Test do
  use ExUnit.Case, async: true

  describe "Lobby2.update_list/2" do
    test "leaves the list as-is if the digit is no bigger than any element" do
      list = [3, 4, 5]
      assert Lobby2.update_list(list, 3) == list
    end

    test "replaces the leftmost element with the digit and the rest with zeroes if it is smaller than the digit" do
      list = [3, 4, 5, 6]
      assert Lobby2.update_list(list, 4) == [4, 0, 0, 0]
    end

    test "replaces the leftmost element smaller than the digit with the digit and the rest with zeroes" do
      list = [8, 6, 5, 6, 3, 3, 3]
      assert Lobby2.update_list(list, 4) == [8, 6, 5, 6, 4, 0, 0, 0]
    end
  end

  describe "Lobby2.max_dozen/1" do
    test "returns the number formed by the highest 12 digits when they are adjacent at the start" do
      assert Lobby2.max_dozen("987654321111111") == 987_654_321_111
    end

    test "returns the number formed by the highest 12 digits when they are not adjacent" do
      assert Lobby2.max_dozen("234234234234278") == 434_234_234_278
    end
  end
end

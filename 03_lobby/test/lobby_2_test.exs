defmodule Lobby2Test do
  use ExUnit.Case, async: true

  describe "Lobby2.pad/1" do
    test "pads a list with leading zeroes to 12 elements" do
      assert Lobby2.pad([1, 2, 3, 4, 5, 6]) == [0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6]
    end
  end

  describe "Lobby2.update_list/2" do
    test "leaves the list as-is if no element is smaller than the digit" do
      list = [3, 4, 5, 6, 3, 3, 3, 9, 5, 6, 4, 7]
      assert Lobby2.update_list(list, 3) == list
    end

    test "returns the digit and 11 zeroes if the digit is bigger than the first element" do
      list = [3, 4, 5, 6, 3, 3, 3, 9, 5, 6, 4, 7]
      assert Lobby2.update_list(list, 4) == [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
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

defmodule Lobby2Test do
  use ExUnit.Case, async: true

  describe "Lobby2.total/1" do
    test "returns the total joltage from the input" do
      assert Lobby2.total("""
             987654321111111
             811111111111119
             234234234234278
             818181911112111
             """) == 3_121_910_778_619
    end
  end

  describe "Lobby2.update_list/2" do
    test "appends the digit if the digit is no bigger than any element" do
      list = [3, 4, 5]
      assert Lobby2.update_list(list, 3) == [3, 4, 5, 3]
    end

    test "returns a new list with just the digit if it is larger than the first element" do
      list = [3, 4, 5]
      assert Lobby2.update_list(list, 4) == [4]
    end

    test "replaces the leftmost element smaller than the digit with the digit, and removes the rest" do
      list = [8, 6, 3, 2, 7]
      assert Lobby2.update_list(list, 4) == [8, 6, 4]
    end
  end

  describe "Lobby2.max_dozen/1" do
    test "returns the number formed by the highest 12 digits when they are adjacent at the start" do
      assert Lobby2.max_dozen("987654321111111") == 987_654_321_111
    end

    test "returns the number formed by the highest 12 digits when they include the first and last" do
      assert Lobby2.max_dozen("811111111111119") == 811_111_111_119
    end

    test "returns the number formed by the highest 12 digits when they are not adjacent" do
      assert Lobby2.max_dozen("234234234234278") == 434_234_234_278
    end
  end
end

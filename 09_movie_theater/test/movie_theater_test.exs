defmodule MovieTheaterTest do
  use ExUnit.Case, async: true

  describe "MovieTheater.largest_area/1" do
    test "returnas the largest area between any pair of points" do
      assert MovieTheater.largest_area([{7, 1}, {11, 1}, {11, 7}, {9, 7}, {9, 5}, {2, 5}, {2, 3}, {7, 3}]) == 50
    end
  end

  describe "MovieTheater.parse/1" do
    test "extracts the points from the input" do
      assert MovieTheater.parse("""
             7,1
             11,1
             11,7
             """) == [{7, 1}, {11, 1}, {11, 7}]
    end
  end
end

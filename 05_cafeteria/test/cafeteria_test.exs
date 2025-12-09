defmodule CafeteriaTest do
  use ExUnit.Case

  describe "Cafeteria.count_fresh/1" do
    test "returns the number of IDs that fall within a range" do
      assert Cafeteria.count_fresh("""
             3-5
             10-14
             16-20
             12-18

             1
             5
             8
             11
             17
             32
             """) == 3
    end
  end

  describe "Cafeteria.parse/1" do
    test "returns the ranges and ids" do
      assert Cafeteria.parse("""
             3-5
             10-14
             16-20
             12-18

             1
             5
             8
             11
             17
             32
             """) == %Cafeteria{ranges: [3..5, 10..14, 16..20, 12..18], ids: [1, 5, 8, 11, 17, 32]}
    end
  end
end

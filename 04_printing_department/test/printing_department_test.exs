defmodule PrintingDepartmentTest do
  use ExUnit.Case

  describe "PrintingDepartment.count_removable/1" do
    test "returns the number of rolls with fewer than four neighbours" do
      assert PrintingDepartment.count_removable("""
             ..@@.@@@@.
             @@@.@.@.@@
             @@@@@.@.@@
             @.@@@@..@.
             @@.@@@@.@@
             .@@@@@@@.@
             .@.@.@.@@@
             @.@@@.@@@@
             .@@@@@@@@.
             @.@.@@@.@.
             """) == 13
    end
  end

  describe "PrintingDepartment.find_removable/1" do
    test "returns the number of rolls with fewer than four neighbours" do
      assert PrintingDepartment.find_removable(%{
               {0, 0} => [{0, 1}],
               {0, 1} => [{0, 0}, {0, 2}, {1, 2}],
               {0, 2} => [{0, 1}, {1, 2}, {1, 3}],
               {1, 2} => [{0, 1}, {0, 2}, {1, 3}, {2, 2}, {2, 3}],
               {1, 3} => [{0, 2}, {1, 2}, {2, 2}, {2, 3}],
               {2, 2} => [{1, 2}, {1, 3}, {2, 3}],
               {2, 3} => [{1, 2}, {1, 3}, {2, 2}]
             }) == [{0, 0}, {0, 1}, {0, 2}, {2, 2}, {2, 3}]
    end
  end

  describe "PrintingDepartment.parse/1" do
    test "returns the {x, y} coordinates of all rolls" do
      assert PrintingDepartment.parse("""
             .@.
             @.@
             ..@
             """) == [{1, 0}, {0, 1}, {2, 1}, {2, 2}]
    end
  end

  describe "PrintingDepartment.neighbours/1" do
    test "returns the coordinates of all eight potential neighbours" do
      assert PrintingDepartment.neighbours({2, 3}) == [
               {1, 2},
               {1, 3},
               {1, 4},
               {2, 2},
               {2, 4},
               {3, 2},
               {3, 3},
               {3, 4}
             ]
    end
  end

  describe "PrintingDepartment.find_neighbours/1" do
    test "returns a map of coordinates to neighbours" do
      assert PrintingDepartment.find_neighbours([{1, 0}, {0, 1}, {2, 1}, {2, 2}]) == %{
               {1, 0} => [{0, 1}, {2, 1}],
               {0, 1} => [{1, 0}],
               {2, 1} => [{1, 0}, {2, 2}],
               {2, 2} => [{2, 1}]
             }
    end
  end
end

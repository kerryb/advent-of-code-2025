defmodule PrintingDepartmentTest do
  use ExUnit.Case

  describe "PrintingDepartment.parse/1" do
    test "returns the {x, y} coordinates of all rolls" do
      assert PrintingDepartment.parse("""
             .@.
             @.@
             ..@
             """) == [{1, 0}, {0, 1}, {2, 1}, {2, 2}]
    end
  end
end

defmodule TrashCompactorTest do
  use ExUnit.Case

  describe "TrashCompactor.run/1" do
    test "returns the sum of all the results" do
      assert TrashCompactor.run("""
             123 328  51 64 
              45 64  387 23 
               6 98  215 314
             *   +   *   +  
             """) == 4_277_556
    end
  end
end

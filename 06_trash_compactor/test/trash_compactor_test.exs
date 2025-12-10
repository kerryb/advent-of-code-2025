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

  describe "TrashCompactor.run_2/1" do
    test "returns the sum of all the results, reading numbers vertically" do
      assert TrashCompactor.run_2("""
             123 328  51 64 
              45 64  387 23 
               6 98  215 314
             *   +   *   +  
             """) == 3_263_827
    end
  end
end

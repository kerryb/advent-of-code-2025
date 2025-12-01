defmodule SecretEntranceTest do
  use ExUnit.Case, async: true

  describe "SecretEntrance.turn/2" do
    test "advances the position if turning right" do
      assert SecretEntrance.turn(10, "R32") == 42
    end
  end
end

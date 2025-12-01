defmodule SecretEntranceTest do
  use ExUnit.Case, async: true

  describe "SecretEntrance.turn/2" do
    test "advances the position if turning right" do
      assert SecretEntrance.turn(10, "R32") == 42
    end

    test "retards the position if turning left" do
      assert SecretEntrance.turn(42, "L32") == 10
    end
  end
end

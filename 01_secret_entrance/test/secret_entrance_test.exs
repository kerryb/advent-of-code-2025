defmodule SecretEntranceTest do
  use ExUnit.Case, async: true

  describe "SecretEntrance.turn/2" do
    test "advances the position if turning right" do
      assert SecretEntrance.turn(10, "R32") == 42
    end

    test "retards the position if turning left" do
      assert SecretEntrance.turn(42, "L32") == 10
    end

    test "wraps from 99 to 0 when turning right" do
      assert SecretEntrance.turn(90, "R20") == 10
    end

    test "wraps from 0 to 99 when turning left" do
      assert SecretEntrance.turn(10, "L20") == 90
    end
  end

  describe "SecretEntrance.count_zeroes/2" do
    test "does not change the count if the position is not 0" do
      assert SecretEntrance.count_zeroes(50, 4) == 4
    end

    test "increments the count if the position is 0" do
      assert SecretEntrance.count_zeroes(0, 4) == 5
    end
  end
end

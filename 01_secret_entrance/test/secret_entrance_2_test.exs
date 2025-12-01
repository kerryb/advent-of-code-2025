defmodule SecretEntrance2Test do
  use ExUnit.Case, async: true

  describe "SecretEntrance2.turn/2" do
    test "advances the position if turning right" do
      assert SecretEntrance2.turn(10, 0, "R32") == {42, 0}
    end

    test "retards the position if turning left" do
      assert SecretEntrance2.turn(42, 0, "L32") == {10, 0}
    end

    test "wraps from 99 to 0 when turning right" do
      assert SecretEntrance2.turn(90, 0, "R20") == {10, 0}
    end

    test "wraps from 0 to 99 when turning left" do
      assert SecretEntrance2.turn(10, 0, "L20") == {90, 0}
    end
  end
end

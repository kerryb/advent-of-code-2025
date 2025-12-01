defmodule SecretEntrance2Test do
  use ExUnit.Case, async: true

  describe "SecretEntrance2.turn/2" do
    test "advances the position if turning right" do
      assert SecretEntrance2.turn(10, 0, "R32") == {42, 0}
    end

    test "retards the position if turning left" do
      assert SecretEntrance2.turn(42, 0, "L32") == {10, 0}
    end

    test "wraps from 99 to 0, incrementing the total, when turning right" do
      assert SecretEntrance2.turn(90, 0, "R20") == {10, 1}
    end

    test "wraps from 0 to 99, incrementing the total, when turning left" do
      assert SecretEntrance2.turn(10, 0, "L20") == {90, 1}
    end

    test "increments the total when landing on zero turning right" do
      assert SecretEntrance2.turn(90, 0, "R10") == {0, 1}
    end

    test "increments the total when landing on zero turning left" do
      assert SecretEntrance2.turn(10, 0, "L10") == {0, 1}
    end

    test "increments the total once per revolution when turning right by more than 100" do
      assert SecretEntrance2.turn(90, 0, "R220") == {10, 3}
    end

    test "increments the total once per revolution when turning left by more than 100" do
      assert SecretEntrance2.turn(10, 0, "L220") == {90, 3}
    end

    test "increments the total correctly when turning right by more than 100 and ending on zero" do
      assert SecretEntrance2.turn(80, 0, "R220") == {0, 3}
    end

    test "increments the total correctly when turning left by more than 100 and ending on zero" do
      assert SecretEntrance2.turn(20, 0, "L220") == {0, 3}
    end

    test "increments the total correctly when turning right by 100 from zero to zero" do
      assert SecretEntrance2.turn(0, 0, "R100") == {0, 1}
    end

    test "increments the total correctly when turning left by 100 from zero to zero" do
      assert SecretEntrance2.turn(0, 0, "L100") == {0, 1}
    end
  end
end

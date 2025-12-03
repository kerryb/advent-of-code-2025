defmodule LobbyTest do
  use ExUnit.Case, async: true

  describe "Lobby.total/1" do
    test "returns the total joltage from the input" do
      assert Lobby.total("""
             987654321111111
             811111111111119
             234234234234278
             818181911112111
             """) == 357
    end
  end

  describe "Lobby.max_pair/1" do
    test "returns the number formed by the highest two digits when they are adjacent at the start" do
      assert Lobby.max_pair("987654321111111") == 98
    end

    test "returns the number formed by the highest two digits when they are adjacent at the end" do
      assert Lobby.max_pair("234234234234278") == 78
    end

    test "returns the number formed by the highest two digits when they are not adjacent" do
      assert Lobby.max_pair("818181911112111") == 92
    end
  end
end

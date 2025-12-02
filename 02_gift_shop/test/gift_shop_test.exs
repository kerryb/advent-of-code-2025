defmodule GiftShopTest do
  use ExUnit.Case, async: true

  describe "GiftShop.run/1" do
    test "returns the total of all the invalid IDs" do
      assert GiftShop.run(
               "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
             ) == 1_227_775_554
    end
  end

  describe "GiftShop.ranges/1" do
    test "extracts ranges from the input" do
      assert GiftShop.ranges("11-22,95-115,998-1012,1188511880-1188511890") == [
               11..22,
               95..115,
               998..1012,
               1_188_511_880..1_188_511_890
             ]
    end
  end

  describe "GiftShop.invalid?/1" do
    test "returns true for a repeated digit" do
      assert GiftShop.invalid?("55")
    end

    test "returns true for a repeated multi-digit number" do
      assert GiftShop.invalid?("123123")
    end

    test "returns false for a non-repetitive number" do
      refute GiftShop.invalid?("12321")
    end
  end
end

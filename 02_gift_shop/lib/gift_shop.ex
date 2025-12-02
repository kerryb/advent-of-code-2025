defmodule GiftShop do
  def run(input, fun) do
    input
    |> ranges()
    |> Enum.flat_map(fn range -> Enum.filter(range, fun) end)
    |> Enum.sum()
  end

  def ranges(input) do
    input |> String.split(",") |> Enum.map(&range(&1))
  end

  defp range(string) do
    string
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [first, last] -> first..last end)
  end

  def invalid?(number) do
    string = to_string(number)
    match?({a, a}, String.split_at(string, div(String.length(string), 2)))
  end

  def invalid2?(number) do
    string = to_string(number)

    Enum.any?(1..div(String.length(string), 2), fn length ->
      string =~ ~r/^(#{String.slice(string, 0, length)})*$/
    end)
  end
end

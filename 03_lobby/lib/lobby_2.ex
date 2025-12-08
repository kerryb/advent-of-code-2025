defmodule Lobby2 do
  def total(input) do
    input
    |> String.split()
    |> Enum.reduce(0, fn str, acc -> acc + max_dozen(str) end)
  end

  def max_dozen(string) do
    string
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
    |> find_max_dozen()
    |> Enum.reduce(0, fn digit, acc -> acc * 10 + digit end)
  end

  defp find_max_dozen(numbers) when length(numbers) == 12, do: numbers

  defp find_max_dozen(numbers) do
    0..(length(numbers) - 1)
    |> Enum.map(&List.delete_at(numbers, &1))
    |> Enum.max()
    |> find_max_dozen()
  end
end

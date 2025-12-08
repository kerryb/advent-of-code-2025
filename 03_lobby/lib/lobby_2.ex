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
    |> max_dozen([])
    |> Enum.reduce(0, fn digit, acc -> acc * 10 + digit end)
  end

  defp max_dozen(numbers, acc) when length(numbers) + length(acc) >= 12, do: acc ++ numbers
  defp max_dozen([], acc), do: Enum.take(acc, 12)
  defp max_dozen([head | tail], acc), do: max_dozen(tail, update_list(acc, head))

  def update_list(list, digit), do: list |> update_list(digit, []) |> Enum.reverse()
  defp update_list([], digit, result), do: [digit | result]
  defp update_list([head | _tail], digit, result) when digit > head, do: [digit | result]
  defp update_list([head | tail], digit, result), do: update_list(tail, digit, [head | result])
end

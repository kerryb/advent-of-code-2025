defmodule Lobby do
  def total(input) do
    input
    |> String.split()
    |> Enum.reduce(0, fn str, acc -> acc + max_pair(str) end)
  end

  def max_pair(string), do: max_pair(string, {0, 0})

  defp max_pair(<<char::binary-size(1)>>, {a, b}) do
    digit = String.to_integer(char)
    {a, b} = if digit > b, do: {a, digit}, else: {a, b}
    a * 10 + b
  end

  defp max_pair(<<char::binary-size(1), rest::binary>>, {a, b}) do
    digit = String.to_integer(char)

    acc =
      cond do
        digit > a -> {digit, 0}
        digit > b -> {a, digit}
        true -> {a, b}
      end

    max_pair(rest, acc)
  end
end

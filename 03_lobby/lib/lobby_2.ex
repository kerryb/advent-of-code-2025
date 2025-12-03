defmodule Lobby2 do
  def max_dozen(string), do: max_dozen(string, Range.to_list(1..12))

  defp max_dozen(<<rest::binary-size(11)>>, acc) do
    Enum.reduce(acc, 0, fn digit, acc -> acc * 10 + digit end) + String.to_integer(rest)
  end

  defp max_dozen(<<char::binary-size(1), rest::binary>>, acc) do
    digit = String.to_integer(char)
    max_dozen(rest, update_list(acc, digit))
  end

  def update_list(list, digit, result \\ [])
  def update_list([], _digit, result), do: Enum.reverse(result)

  def update_list([head | tail], digit, result) do
    if digit > head do
      Enum.reverse(pad([digit | result]))
    else
      update_list(tail, digit, [head | result])
    end
  end

  def pad(list) when length(list) == 12, do: list
  def pad(list), do: pad([0 | list])
end

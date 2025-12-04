defmodule Lobby2 do
  def max_dozen(string), do: max_dozen(string, [])

  defp max_dozen("", acc) do
    Enum.reduce(acc, 0, fn digit, acc -> acc * 10 + digit end)
  end

  defp max_dozen(<<char::binary-size(1), rest::binary>>, acc) do
    digit = String.to_integer(char)
    max_dozen(rest, update_list(acc, digit))
  end

  def update_list(list, digit, result \\ [])
  def update_list([], _digit, result), do: Enum.reverse(result)

  def update_list([head | tail], digit, result) do
    if digit > head do
      Enum.reverse([digit | result]) ++
        (Stream.repeatedly(fn -> 0 end) |> Enum.take(length(tail)))
    else
      update_list(tail, digit, [head | result])
    end
  end
end

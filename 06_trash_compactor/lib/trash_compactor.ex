defmodule TrashCompactor do
  @moduledoc false

  def run(input) do
    input |> String.split("\n", trim: true) |> Enum.reverse() |> Enum.map(&String.split/1) |> calculate(0)
  end

  defp calculate([[] | _], sum), do: sum

  defp calculate([operations | numbers], sum) do
    [operation | operation_tail] = operations
    number_heads = Enum.map(numbers, &hd/1)
    number_tails = Enum.map(numbers, &tl/1)
    result = number_heads |> Enum.map(&String.to_integer/1) |> Enum.reduce(operation_fun(operation))
    calculate([operation_tail | number_tails], sum + result)
  end

  defp operation_fun("+"), do: &+/2
  defp operation_fun("*"), do: &*/2
end

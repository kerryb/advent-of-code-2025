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

  def run_2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reverse()
    |> Enum.map(&String.codepoints/1)
    |> calculate_2([], nil, 0)
  end

  defp calculate_2([[] | _], numbers, operation, sum) do
    sum + perform_calculation(numbers, operation)
  end

  defp calculate_2([operations | lines], numbers, operation, sum) do
    lists = [tl(operations) | Enum.map(lines, &tl/1)]

    new_operation =
      case hd(operations) do
        " " -> operation
        op -> op
      end

    case number_from_column(lines) do
      nil -> calculate_2(lists, [], nil, sum + perform_calculation(numbers, operation))
      number -> calculate_2(lists, [number | numbers], new_operation, sum)
    end
  end

  defp number_from_column(lines) do
    case lines
         |> Enum.flat_map(fn
           [" " | _] -> []
           [digit | _] -> [digit]
         end)
         |> Enum.join() do
      "" -> nil
      number -> number |> String.reverse() |> String.to_integer()
    end
  end

  defp perform_calculation(numbers, operation) do
    Enum.reduce(numbers, operation_fun(operation))
  end

  defp operation_fun("+"), do: &+/2
  defp operation_fun("*"), do: &*/2
end

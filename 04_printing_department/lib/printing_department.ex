defmodule PrintingDepartment do
  def run(input) do
    input
    |> parse()
    |> count_neighbours()
    |> Enum.reduce(0, fn
      count, acc when count < 4 -> acc + 1
      _, acc -> acc
    end)
  end

  def parse(input) do
    input |> String.split() |> Enum.with_index() |> Enum.flat_map(&parse_row/1)
  end

  defp parse_row({row, y}) do
    row |> String.codepoints() |> Enum.with_index() |> Enum.flat_map(&parse_cell(&1, y))
  end

  defp parse_cell({"@", x}, y), do: [{x, y}]
  defp parse_cell(_, _), do: []

  def count_neighbours(coordinate_list) do
    coordinate_list |> Enum.map(&count_neighbours(&1, coordinate_list))
  end

  defp count_neighbours(coordinates, coordinate_list) do
    Enum.count(neighbours(coordinates), &(&1 in coordinate_list))
  end

  def neighbours({x, y}) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
  end
end

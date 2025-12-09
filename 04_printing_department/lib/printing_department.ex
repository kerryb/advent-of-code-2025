defmodule PrintingDepartment do
  def count_removable(input) do
    input |> parse() |> find_neighbours() |> find_removable() |> length()
  end

  def find_removable(counts) do
    Enum.flat_map(counts, fn
      {coordinates, neighbours} when length(neighbours) < 4 -> [coordinates]
      _ -> []
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

  def find_neighbours(coordinate_list) do
    coordinate_list |> Map.new(&{&1, find_neighbours(&1, coordinate_list)})
  end

  defp find_neighbours(coordinates, coordinate_list) do
    Enum.filter(neighbours(coordinates), &(&1 in coordinate_list))
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

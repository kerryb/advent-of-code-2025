defmodule PrintingDepartment do
  def count_removable(input) do
    input |> parse() |> count_neighbours() |> find_removable() |> length()
  end

  def remove_all_accessible(input) do
    input |> parse() |> count_neighbours() |> recursively_remove(0)
  end

  defp recursively_remove(counts, total) do
    new_counts = remove(counts)
    removed_count = map_size(counts) - map_size(new_counts)

    if removed_count == 0 do
      total
    else
      recursively_remove(new_counts, total + removed_count)
    end
  end

  def remove(counts) do
    removable = find_removable(counts)
    counts = Map.reject(counts, fn {k, _v} -> k in removable end)

    removable
    |> Enum.flat_map(&neighbours/1)
    |> Enum.reduce(counts, fn neighbour, counts ->
      Map.replace_lazy(counts, neighbour, &(&1 - 1))
    end)
  end

  def find_removable(counts) do
    Enum.flat_map(counts, fn
      {coordinates, count} when count < 4 -> [coordinates]
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

  def count_neighbours(coordinate_list) do
    coordinate_list |> Map.new(&{&1, count_neighbours(&1, coordinate_list)})
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

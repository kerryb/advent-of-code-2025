defmodule PrintingDepartment do
  def parse(input) do
    input |> String.split() |> Enum.with_index() |> Enum.flat_map(&parse_row/1)
  end

  defp parse_row({row, y}) do
    row |> String.codepoints() |> Enum.with_index() |> Enum.flat_map(&parse_cell(&1, y))
  end

  defp parse_cell({"@", x}, y), do: [{x, y}]
  defp parse_cell(_, _), do: []
end

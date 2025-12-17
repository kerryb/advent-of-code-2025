defmodule MovieTheater do
  @moduledoc false

  def run(input), do: input |> parse() |> largest_area()

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, ",") end)
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
  end

  def largest_area(points) do
    {a, b} =
      Enum.max_by(
        for a <- points, b <- points, a > b do
          {a, b}
        end,
        fn {a, b} -> area(a, b) end
      )

    area(a, b)
  end

  defp area({x, y}, {xx, yy}), do: (abs(x - xx) + 1) * (abs(y - yy) + 1)

  def draw_loop(points) do
    [List.last(points) | points]
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(%{}, fn [previous_point, point], acc -> add_point(previous_point, point, acc) end)
  end

  defp add_point(previous_point, point, grid) do
    previous_point |> line(point) |> Enum.reduce(grid, &Map.put(&2, &1, :green)) |> Map.put(point, :red)
  end

  defp line({x, y1}, {x, y2}) when y2 - y1 >= 2, do: Enum.map((y1 + 1)..(y2 - 1), &{x, &1})
  defp line({x, y1}, {x, y2}) when y1 - y2 >= 2, do: Enum.map((y2 + 1)..(y1 - 1), &{x, &1})
  defp line({x1, y}, {x2, y}) when x2 - x1 >= 2, do: Enum.map((x1 + 1)..(x2 - 1), &{&1, y})
  defp line({x1, y}, {x2, y}) when x1 - x2 >= 2, do: Enum.map((x2 + 1)..(x1 - 1), &{&1, y})
  defp line(_, _), do: []
end

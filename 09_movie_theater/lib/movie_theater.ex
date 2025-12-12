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
end

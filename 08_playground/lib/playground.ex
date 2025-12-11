defmodule Playground do
  @moduledoc false

  def distances(input) do
    points =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.split(",") |> Enum.map(&String.to_integer/1) end)

    Map.new(
      for [a, b, c] = first <- points, [aa, bb, cc] = second <- points, first < second do
        {{{a, b, c}, {aa, bb, cc}}, :math.sqrt((a - aa) ** 2 + (b - bb) ** 2 + (c - cc) ** 2)}
      end
    )
  end
end

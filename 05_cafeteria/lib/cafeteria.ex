defmodule Cafeteria do
  @moduledoc false

  defstruct [:ranges, :ids]

  def count_fresh(input) do
    data = parse(input)
    Enum.count(data.ids, fn id -> Enum.any?(data.ranges, &(id in &1)) end)
  end

  def parse(input) do
    [ranges, ids] = String.split(input, ~r/\n{2,}/)
    %__MODULE__{ranges: parse_ranges(ranges), ids: parse_ids(ids)}
  end

  defp parse_ranges(input) do
    input |> String.split() |> Enum.map(&parse_range/1)
  end

  defp parse_range(line) do
    [start, finish] = line |> String.split("-") |> Enum.map(&String.to_integer/1)
    start..finish
  end

  defp parse_ids(input) do
    input |> String.split() |> Enum.map(&String.to_integer/1)
  end
end

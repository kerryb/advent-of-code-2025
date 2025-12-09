defmodule Cafeteria do
  @moduledoc false

  defstruct [:ranges, :ids]

  def count_fresh(input) do
    data = parse(input)
    Enum.count(data.ids, fn id -> Enum.any?(data.ranges, &(id in &1)) end)
  end

  def fresh_range_size(input) do
    input
    |> parse()
    |> Map.get(:ranges)
    |> Enum.sort()
    |> merge_contiguous([])
    |> Enum.reduce(0, &(Range.size(&1) + &2))
  end

  defp merge_contiguous([], acc), do: acc
  defp merge_contiguous([head | tail], []), do: merge_contiguous(tail, [head])

  defp merge_contiguous([head | tail], [acc_head | acc_tail]) do
    if Range.disjoint?(head, acc_head) do
      merge_contiguous(tail, [head, acc_head | acc_tail])
    else
      merge_contiguous(tail, [Range.new(acc_head.first, max(head.last, acc_head.last)) | acc_tail])
    end
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

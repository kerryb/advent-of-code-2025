defmodule Laboratories do
  @moduledoc false

  def run(input), do: input |> String.split("\n", trim: true) |> Enum.map(&String.codepoints/1) |> run([], 0)

  defp run([head | tail], [], 0), do: run(tail, [Enum.find_index(head, &(&1 == "S"))], 0)
  defp run([], _beams, count), do: count

  defp run([head | tail], beams, count) do
    splitters =
      head
      |> Enum.with_index()
      |> Enum.flat_map(fn
        {"^", index} ->
          if index in beams, do: [index], else: []

        _ ->
          []
      end)

    beams =
      beams
      |> Enum.flat_map(fn beam ->
        if beam in splitters, do: [beam - 1, beam + 1], else: [beam]
      end)
      |> Enum.uniq()

    run(tail, beams, count + length(splitters))
  end
end

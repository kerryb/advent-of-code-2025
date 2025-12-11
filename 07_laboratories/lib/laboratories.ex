defmodule Laboratories do
  @moduledoc false

  def run(input), do: run(parse(input), [], 0)
  def run_2(input), do: run_2(parse(input), nil)

  defp parse(input) do
    input |> String.split("\n", trim: true) |> Enum.map(&String.codepoints/1)
  end

  defp run([head | tail], [], 0), do: run(tail, [start(head)], 0)
  defp run([], _beams, count), do: count

  defp run([head | tail], beams, count) do
    splitters = splitters(head, beams)

    beams = next_beams(beams, splitters)

    run(tail, beams, count + length(splitters))
  end

  defp splitters(line, beams) do
    line
    |> Enum.with_index()
    |> Enum.flat_map(fn
      {"^", index} ->
        if index in beams, do: [index], else: []

      _ ->
        []
    end)
  end

  defp next_beams(beams, splitters) do
    beams
    |> Enum.flat_map(fn beam ->
      if beam in splitters, do: [beam - 1, beam + 1], else: [beam]
    end)
    |> Enum.uniq()
  end

  defp run_2([head | tail], nil), do: run_2(tail, start(head))
  defp run_2([], _beam), do: 1

  defp run_2([head | tail], beam) do
    if Enum.at(head, beam) == "^" do
      run_2(tail, beam - 1) + run_2(tail, beam + 1)
    else
      run_2(tail, beam)
    end
  end

  defp start(line) do
    Enum.find_index(line, &(&1 == "S"))
  end
end

defmodule Laboratories do
  @moduledoc false

  def run(input), do: run(parse(input), [], 0)
  def run_2(input), do: run_2(parse(input), [])

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

  defp next_beams(beams, splitters) do
    beams
    |> Enum.flat_map(fn beam ->
      if beam in splitters, do: [beam - 1, beam + 1], else: [beam]
    end)
    |> Enum.uniq()
  end

  defp run_2([head | tail], []), do: run_2(tail, %{start(head) => 1})
  defp run_2([], frequencies), do: frequencies |> Map.values() |> Enum.sum()

  defp run_2([head | tail], frequencies) do
    splitters = splitters(head, Map.keys(frequencies))
    new_paths = Enum.flat_map(splitters, &%{(&1 - 1) => frequencies[&1], (&1 + 1) => frequencies[&1]})
    new_frequencies = frequencies |> increment_new_paths(new_paths) |> remove_old_paths(splitters)
    run_2(tail, new_frequencies)
  end

  defp increment_new_paths(frequencies, paths) do
    Enum.reduce(paths, frequencies, fn {path, count}, frequencies ->
      Map.update(frequencies, path, count, &(&1 + count))
    end)
  end

  defp remove_old_paths(frequencies, paths) do
    Enum.reduce(paths, frequencies, fn path, frequencies -> Map.put(frequencies, path, 0) end)
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

  defp start(line) do
    Enum.find_index(line, &(&1 == "S"))
  end
end

defmodule Playground do
  @moduledoc false

  def run(input, count) do
    {_, circuits} =
      Enum.reduce(1..count, {distances(input), []}, fn _, {distances, circuits} ->
        connect_shortest(distances, circuits)
      end)

    circuits |> Enum.map(&length/1) |> Enum.sort(:desc) |> Enum.take(3) |> Enum.reduce(&*/2)
  end

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

  def connect_shortest(distances, circuits) do
    {{a, b}, _} = Enum.min_by(distances, &elem(&1, 1))
    distances = Map.delete(distances, {a, b})

    circuits =
      case {Enum.find_index(circuits, &(a in &1)), Enum.find_index(circuits, &(b in &1))} do
        {nil, nil} ->
          [[a, b] | circuits]

        {index, index} ->
          circuits

        {a_index, nil} ->
          List.update_at(circuits, a_index, &[b | &1])

        {nil, b_index} ->
          List.update_at(circuits, b_index, &[a | &1])

        {a_index, b_index} ->
          circuits |> List.update_at(b_index, &(Enum.at(circuits, a_index) ++ &1)) |> List.delete_at(a_index)
      end

    {distances, circuits}
  end
end

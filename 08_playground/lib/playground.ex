defmodule Playground do
  @moduledoc false

  def run(input, count) do
    {_, _point_1, _point_2, circuits} =
      Enum.reduce(1..count, {input |> points() |> distances(), nil, nil, []}, fn _,
                                                                                 {distances, _point_1, _point_2, circuits} ->
        connect_shortest(distances, circuits)
      end)

    circuits |> Enum.map(&length/1) |> Enum.sort(:desc) |> Enum.take(3) |> Enum.reduce(&*/2)
  end

  def run_2(input) do
    points = points(input)
    distances = distances(points)
    count = length(points)
    {{x, _y, _z}, {xx, _yy, _zz}} = connect_all(distances, [], count)
    x * xx
  end

  defp connect_all(distances, circuits, count) do
    {new_distances, point_1, point_2, new_circuits} = connect_shortest(distances, circuits)

    if length(new_circuits) == 1 and length(hd(new_circuits)) == count do
      {point_1, point_2}
    else
      connect_all(new_distances, new_circuits, count)
    end
  end

  def distances(points) do
    Map.new(
      for {a, b, c} = first <- points, {aa, bb, cc} = second <- points, first < second do
        {{{a, b, c}, {aa, bb, cc}}, :math.sqrt((a - aa) ** 2 + (b - bb) ** 2 + (c - cc) ** 2)}
      end
    )
  end

  def points(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> line |> String.split(",") |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn [a, b, c] -> {a, b, c} end)
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

    {distances, a, b, circuits}
  end
end

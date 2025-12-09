defmodule SecretEntrance do
  @moduledoc false
  def decode(input) do
    input
    |> String.split()
    |> Enum.reduce({50, 0}, fn instruction, {position, total} ->
      new_position = turn(position, instruction)
      new_total = count_zeroes(new_position, total)
      {new_position, new_total}
    end)
    |> elem(1)
  end

  def turn(position, <<"R", distance::binary>>), do: new_position(position, distance, 1)
  def turn(position, <<"L", distance::binary>>), do: new_position(position, distance, -1)

  defp new_position(position, distance, direction) do
    Integer.mod(position + String.to_integer(distance) * direction, 100)
  end

  def count_zeroes(0, total), do: total + 1
  def count_zeroes(_position, total), do: total
end

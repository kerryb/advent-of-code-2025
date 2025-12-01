defmodule SecretEntrance2 do
  def decode(input) do
    input
    |> String.split()
    |> Enum.reduce({50, 0}, fn instruction, {position, total} ->
      turn(position, total, instruction)
    end)
    |> then(&elem(&1, 1))
  end

  def turn(position, total, <<"R", distance::binary>>) do
    new_position(position, total, distance, 1)
  end

  def turn(position, total, <<"L", distance::binary>>) do
    new_position(position, total, distance, -1)
  end

  defp new_position(position, total, distance, direction) do
    new_position = position + String.to_integer(distance) * direction
    {Integer.mod(new_position, 100), total + zero_count(position, new_position)}
  end

  defp zero_count(_position, new_position) when new_position > 0, do: div(new_position, 100)
  defp zero_count(_position, new_position) when new_position == 0, do: 1
  defp zero_count(0, new_position), do: div(abs(new_position), 100)
  defp zero_count(_position, new_position), do: div(abs(new_position), 100) + 1
end

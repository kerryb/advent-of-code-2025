defmodule SecretEntrance2 do
  def turn(position, total, <<"R", distance::binary>>) do
    new_position(position, total, distance, 1)
  end

  def turn(position, total, <<"L", distance::binary>>) do
    new_position(position, total, distance, -1)
  end

  defp new_position(position, total, distance, direction) do
    new_position = position + String.to_integer(distance) * direction
    {Integer.mod(new_position, 100), total + zero_count(new_position)}
  end

  defp zero_count(0), do: 1
  defp zero_count(position) when position > 0, do: div(position, 100)
  defp zero_count(position), do: div(abs(position), 100) + 1
end

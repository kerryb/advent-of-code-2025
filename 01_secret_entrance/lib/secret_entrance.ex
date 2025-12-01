defmodule SecretEntrance do
  def turn(position, <<"R", distance::binary>>), do: new_position(position, distance, 1)
  def turn(position, <<"L", distance::binary>>), do: new_position(position, distance, -1)

  defp new_position(position, distance, direction) do
    Integer.mod(position + String.to_integer(distance) * direction, 100)
  end

  def count_zeroes(0, total), do: total + 1
  def count_zeroes(_position, total), do: total
end

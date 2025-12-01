defmodule SecretEntrance do
  def turn(position, <<"R", count::binary>>), do: new_position(position, count, 1)
  def turn(position, <<"L", count::binary>>), do: new_position(position, count, -1)

  defp new_position(position, count, direction) do
    Integer.mod(position + String.to_integer(count) * direction, 100)
  end

  def count_zeroes(0, total), do: total + 1
  def count_zeroes(_position, total), do: total
end

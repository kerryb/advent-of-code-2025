defmodule SecretEntrance do
  def turn(position, <<"R", count::binary>>) do
    new_position(position, count, 1)
  end

  def turn(position, <<"L", count::binary>>) do
    new_position(position, count, -1)
  end

  defp new_position(position, count, direction) do
    Integer.mod(position + String.to_integer(count) * direction, 100)
  end
end

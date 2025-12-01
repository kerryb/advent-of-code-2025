defmodule SecretEntrance2 do
  def turn(position, total, <<"R", distance::binary>>) do
    new_position(position, total, distance, 1)
  end

  def turn(position, total, <<"L", distance::binary>>) do
    new_position(position, total, distance, -1)
  end

  defp new_position(position, total, distance, direction) do
    {Integer.mod(position + String.to_integer(distance) * direction, 100), total}
  end
end

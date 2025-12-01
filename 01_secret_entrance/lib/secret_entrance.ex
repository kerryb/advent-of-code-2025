defmodule SecretEntrance do
  def turn(position, <<"R", count::binary>>) do
    position + String.to_integer(count)
  end

  def turn(position, <<"L", count::binary>>) do
    position - String.to_integer(count)
  end
end

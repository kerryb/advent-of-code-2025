defmodule MovieTheaterTest do
  use ExUnit.Case, async: true

  describe "MovieTheater.largest_area/1" do
    test "returnas the largest area between any pair of points" do
      assert MovieTheater.largest_area([{7, 1}, {11, 1}, {11, 7}, {9, 7}, {9, 5}, {2, 5}, {2, 3}, {7, 3}]) == 50
    end
  end

  describe "MovieTheater.parse/1" do
    test "extracts the points from the input" do
      assert MovieTheater.parse("""
             7,1
             11,1
             11,7
             """) == [{7, 1}, {11, 1}, {11, 7}]
    end
  end

  describe "MovieTheater.draw_loop/1" do
    test "sets the points to red" do
      assert """
             7,1
             11,1
             11,7
             9,7
             9,5
             2,5
             2,3
             7,3
             """
             |> MovieTheater.parse()
             |> MovieTheater.draw_loop()
             |> to_grid() ==
               String.trim("""
               .....#...#
               ..........
               #....#....
               ..........
               #......#..
               ..........
               .......#.#
               """)
    end
  end

  defp to_grid(points) do
    {min_x, _} = Enum.min_by(Map.keys(points), &elem(&1, 0))
    {max_x, _} = Enum.max_by(Map.keys(points), &elem(&1, 0))
    {_, min_y} = Enum.min_by(Map.keys(points), &elem(&1, 1))
    {_, max_y} = Enum.max_by(Map.keys(points), &elem(&1, 1))

    for_result =
      for y <- min_y..max_y do
        Enum.map_join(min_x..max_x, fn x -> render_point(points[{x, y}]) end)
      end

    Enum.join(for_result, "\n")
  end

  defp render_point(nil), do: "."
  defp render_point(:red), do: "#"
  defp render_point(:green), do: "X"
end

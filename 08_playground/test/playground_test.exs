defmodule PlaygroundTest do
  use ExUnit.Case, async: true

  describe "Playground.distances/1" do
    test "calculates the distance between each pair of points" do
      distances =
        Playground.distances("""
        162,817,812
        57,618,57
        906,360,560
        592,479,940
        352,342,300
        466,668,158
        542,29,236
        431,825,988
        739,650,466
        52,470,668
        216,146,977
        819,987,18
        117,168,530
        805,96,715
        346,949,466
        970,615,88
        941,993,340
        862,61,35
        984,92,344
        425,690,689
        """)

      assert_in_delta distances[{{162, 817, 812}, {431, 825, 988}}],
                      :math.sqrt((431 - 162) ** 2 + (825 - 817) ** 2 + (988 - 812) ** 2),
                      0.1
    end
  end
end

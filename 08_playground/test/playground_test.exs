defmodule PlaygroundTest do
  use ExUnit.Case, async: true

  describe "Playground.run/2" do
    test "multiplies the sizes of the three largest groups after making the shortest <count> connections" do
      assert Playground.run(
               """
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
               """,
               10
             ) == 40
    end
  end

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

  describe "Playground.connect_shortest/2" do
    test "removes the shortest pair from the distances map" do
      {distances, _circuits} =
        Playground.connect_shortest(
          %{
            {{1, 2, 3}, {3, 4, 5}} => 3.4,
            {{1, 2, 3}, {2, 3, 4}} => 1.2,
            {{1, 2, 3}, {4, 5, 6}} => 5.6
          },
          []
        )

      refute {{1, 2, 3}, {2, 3, 4}} in Map.keys(distances)
    end

    test "returns a new circuit for the first pair" do
      assert {_distances, [[{1, 2, 3}, {2, 3, 4}]]} =
               Playground.connect_shortest(
                 %{
                   {{1, 2, 3}, {3, 4, 5}} => 3.4,
                   {{1, 2, 3}, {2, 3, 4}} => 1.2,
                   {{1, 2, 3}, {4, 5, 6}} => 5.6
                 },
                 []
               )
    end

    test "adds a new circuit if neither of the pair are already in a circuit" do
      assert {_distances, [[{1, 2, 4}, {3, 4, 5}], [{1, 2, 3}, {2, 3, 4}]]} =
               Playground.connect_shortest(
                 %{
                   {{1, 2, 4}, {3, 4, 5}} => 3.4,
                   {{1, 2, 4}, {4, 5, 6}} => 5.6
                 },
                 [[{1, 2, 3}, {2, 3, 4}]]
               )
    end

    test "adds the second point to an existing circuit if the first point is already in it" do
      assert {_distances, [[{3, 4, 5}, {1, 2, 3}, {2, 3, 4}]]} =
               Playground.connect_shortest(
                 %{
                   {{1, 2, 3}, {3, 4, 5}} => 3.4,
                   {{1, 2, 3}, {4, 5, 6}} => 5.6
                 },
                 [[{1, 2, 3}, {2, 3, 4}]]
               )
    end

    test "adds the first point to an existing circuit if the second point is already in it" do
      assert {_distances, [[{3, 4, 5}, {1, 2, 3}, {2, 3, 4}]]} =
               Playground.connect_shortest(
                 %{
                   {{2, 3, 4}, {3, 4, 5}} => 3.4,
                   {{1, 2, 3}, {4, 5, 6}} => 5.6
                 },
                 [[{1, 2, 3}, {2, 3, 4}]]
               )
    end

    test "combines two circuits if one point is in each" do
      assert {_distances, [[{1, 2, 3}, {2, 3, 4}, {3, 4, 5}, {7, 8, 9}]]} =
               Playground.connect_shortest(
                 %{
                   {{2, 3, 4}, {3, 4, 5}} => 3.4,
                   {{1, 2, 3}, {4, 5, 6}} => 5.6
                 },
                 [[{1, 2, 3}, {2, 3, 4}], [{3, 4, 5}, {7, 8, 9}]]
               )
    end

    test "does not change any circuits if both points are already in the same one" do
      assert {_distances, [[{1, 2, 3}, {2, 3, 4}, {3, 4, 5}, {7, 8, 9}], [{3, 2, 1}, {5, 4, 3}]]} =
               Playground.connect_shortest(
                 %{
                   {{2, 3, 4}, {3, 4, 5}} => 3.4,
                   {{1, 2, 3}, {4, 5, 6}} => 5.6
                 },
                 [[{1, 2, 3}, {2, 3, 4}, {3, 4, 5}, {7, 8, 9}], [{3, 2, 1}, {5, 4, 3}]]
               )
    end
  end
end

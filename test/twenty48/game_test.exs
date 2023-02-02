defmodule Twenty48.GameTest do
  use ExUnit.Case, async: true
  alias Twenty48.Game

  describe "new" do
    test "creates a game with a a status of playing" do
      assert Game.new().status == :playing
    end

    test "creates a 6x6 board by default" do
      assert [
               [_, _, _, _, _, _],
               [_, _, _, _, _, _],
               [_, _, _, _, _, _],
               [_, _, _, _, _, _],
               [_, _, _, _, _, _],
               [_, _, _, _, _, _]
             ] = Game.new().board
    end

    test "creates board with the specified width" do
      for width <- 1..10 do
        assert Game.new(width, 3).board |> Enum.all?(&(Enum.count(&1) == width))
      end
    end

    test "creates board with the specified height" do
      for height <- 1..10 do
        assert Game.new(3, height).board |> Enum.count() == height
      end
    end

    test "places a 2 in a random position" do
      seed_random()
      assert Game.new(3, 1).board == [[2, :_, :_]]
      assert Game.new(3, 1).board == [[:_, :_, 2]]
    end

    test "gives a status of lost if there is nowhere to place a piece" do
      assert Game.new(0, 0).status == :lost
    end
  end

  describe "slide" do
    test "slides the pieces the specified direction then adds a 1 in a random free position" do
      seed_random()
      game = %{board: [[:_, :_, 2]], status: :playing}
      assert Game.slide(game, :left).board == [[2, 1, :_]]
      assert Game.slide(game, :left).board == [[2, :_, 1]]
    end

    test "combines pieces with the same number" do
      game = %{board: [[16, 16]], status: :playing}
      assert Game.slide(game, :left).board == [[32, 1]]
    end

    test "gives a status of playing if there is space for the new piece" do
      game = %{board: [[:_, 2]], status: :playing}
      assert Game.slide(game, :left).status == :playing
    end

    test "gives a status of playing if the pieces combine creating space for the new piece" do
      game = %{board: [[16, 16]], status: :playing}
      assert Game.slide(game, :left).status == :playing
    end

    test "gives a status of lost if the board is full" do
      game = %{board: [[4, 2]], status: :playing}
      assert Game.slide(game, :left).status == :lost
    end

    test "gives a status of won if the pieces combine to make a 2048" do
      game = %{board: [[1024, 1024]], status: :playing}
      assert Game.slide(game, :left).status == :won
    end

    test "does not add a 1 if the pieces combine to make a 2048" do
      game = %{board: [[1024, 1024]], status: :playing}
      assert Game.slide(game, :left).board == [[2048, :_]]
    end

    test "does nothing if status is won" do
      game = %{board: [[:_, 2048]], status: :won}
      assert Game.slide(game, :left) == game
    end

    test "does nothing if status is lost" do
      game = %{board: [[16, 16]], status: :lost}
      assert Game.slide(game, :left) == game
    end
  end

  defp seed_random do
    :rand.seed(:exsplus, {101, 102, 103})
  end
end

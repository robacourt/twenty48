defmodule Twenty48.BoardTest do
  use ExUnit.Case, async: true
  alias Twenty48.Board

  describe "slide/2" do
    test "can slide the tiles left" do
      board = [
        [:_, 1],
        [:_, 2]
      ]

      assert Board.slide(board, :left) == [
               [1, :_],
               [2, :_]
             ]
    end

    test "can slide the tiles right" do
      board = [
        [1, :_],
        [2, :_]
      ]

      assert Board.slide(board, :right) == [
               [:_, 1],
               [:_, 2]
             ]
    end

    test "can slide the tiles down" do
      board = [
        [1, 2],
        [:_, :_]
      ]

      assert Board.slide(board, :down) == [
               [:_, :_],
               [1, 2]
             ]
    end

    test "can slide the tiles up" do
      board = [
        [:_, :_],
        [1, 2]
      ]

      assert Board.slide(board, :up) == [
               [1, 2],
               [:_, :_]
             ]
    end
  end

  describe "free_spaces/1" do
    test "returns an empty list if there are no free spaces" do
      board = [
        [1, 2],
        [3, 4]
      ]

      assert Board.free_spaces(board) == []
    end

    test "returns the x, y coordiantes of any free spaces" do
      assert Board.free_spaces([
               [:_, 2],
               [3, 4]
             ]) == [{0, 0}]

      assert Board.free_spaces([
               [1, :_],
               [3, 4]
             ]) == [{1, 0}]

      assert Board.free_spaces([
               [1, 2],
               [:_, 4]
             ]) == [{0, 1}]

      assert Board.free_spaces([
               [:_, :_],
               [:_, :_]
             ]) == [{0, 0}, {1, 0}, {0, 1}, {1, 1}]
    end
  end

  describe "add/3" do
    test "adds the specified tile onto the board at the specified coordinates" do
      board = [[1, 2], [3, 4]]

      assert Board.add(board, {0, 0}, :x) == [
               [:x, 2],
               [3, 4]
             ]

      assert Board.add(board, {0, 1}, :x) == [
               [1, 2],
               [:x, 4]
             ]

      assert Board.add(board, {1, 0}, :x) == [
               [1, :x],
               [3, 4]
             ]
    end
  end

  describe "create/2" do
    test "returns an empty board of the specified width and height" do
      assert Board.create(2, 2) == [
               [:_, :_],
               [:_, :_]
             ]

      assert Board.create(2, 1) == [
               [:_, :_]
             ]
    end
  end
end

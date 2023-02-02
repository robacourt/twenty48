defmodule Twenty48.BoardTest do
  use ExUnit.Case, async: true
  alias Twenty48.Board

  test "slide" do
    assert Board.slide([[:_, 1], [:_, 2]], :left) == [[1, :_], [2, :_]]
    assert Board.slide([[1, :_], [2, :_]], :right) == [[:_, 1], [:_, 2]]
    assert Board.slide([[1, 2], [:_, :_]], :down) == [[:_, :_], [1, 2]]
    assert Board.slide([[:_, :_], [1, 2]], :up) == [[1, 2], [:_, :_]]
  end

  test "free_spaces" do
    assert Board.free_spaces([[1, 2], [3, 4]]) == []
    assert Board.free_spaces([[:_, 2], [3, 4]]) == [{0, 0}]
    assert Board.free_spaces([[1, :_], [3, 4]]) == [{1, 0}]
    assert Board.free_spaces([[1, 2], [:_, 4]]) == [{0, 1}]
    assert Board.free_spaces([[:_, :_], [:_, :_]]) == [{0, 0}, {1, 0}, {0, 1}, {1, 1}]
  end

  test "add" do
    assert Board.add([[:_, :_], [:_, :_]], {0, 0}, 2) == [[2, :_], [:_, :_]]
    assert Board.add([[:_, :_], [:_, :_]], {1, 0}, 2) == [[:_, 2], [:_, :_]]
    assert Board.add([[8, :_], [:_, 4]], {0, 1}, 2) == [[8, :_], [2, 4]]
  end

  test "create" do
    assert Board.create(2, 2) == [[:_, :_], [:_, :_]]
    assert Board.create(2, 1) == [[:_, :_]]
  end
end

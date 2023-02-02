defmodule Twenty48.RowTest do
  use ExUnit.Case, async: true
  alias Twenty48.Row

  test "Moves numbers left" do
    assert Row.left([:_, 1]) == [1, :_]
    assert Row.left([:_, 1, :_, 2]) == [1, 2, :_, :_]
    assert Row.left([1, :_, :_, 2]) == [1, 2, :_, :_]
    assert Row.left([1, 2]) == [1, 2]
  end

  test "Combines pairs of identical numbers" do
    assert Row.left([1, 1]) == [2, :_]
    assert Row.left([2, 2]) == [4, :_]
    assert Row.left([2, 2, 2]) == [4, 2, :_]
    assert Row.left([8, 4, 4]) == [8, 8, :_]
    assert Row.left([2, 1, 2]) == [2, 1, 2]
    assert Row.left([2, :_, 2, :_, 1]) == [4, 1, :_, :_, :_]
    assert Row.left([4, :_, 2, :_, 2]) == [4, 4, :_, :_, :_]
  end

  test "Obstacles stop pieces moving past them" do
    assert Row.left([:_, :x, 1]) == [:_, :x, 1]
    assert Row.left([:_, :x, :_, 1]) == [:_, :x, 1, :_]
    assert Row.left([:_, :x, 1, 1]) == [:_, :x, 2, :_]
    assert Row.left([:_, :_, 1, :x]) == [1, :_, :_, :x]
    assert Row.left([:_, :_, :x, :x]) == [:_, :_, :x, :x]
  end
end

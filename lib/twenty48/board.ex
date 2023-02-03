defmodule Twenty48.Board do
  alias Twenty48.Row

  @space Row.space()

  def slide(board, :left) do
    Enum.map(board, &Row.slide_left/1)
  end

  def slide(board, :right) do
    board
    |> reverse_columns()
    |> slide(:left)
    |> reverse_columns()
  end

  def slide(board, :down) do
    board
    |> rotate_clockwise()
    |> slide(:left)
    |> rotate_anticlockwise()
  end

  def slide(board, :up) do
    board
    |> rotate_anticlockwise()
    |> slide(:left)
    |> rotate_clockwise()
  end

  def free_spaces(board) do
    for {row, y} <- Enum.with_index(board), {@space, x} <- Enum.with_index(row) do
      {x, y}
    end
  end

  def add(board, {x, y}, new_tile) do
    for {row, row_index} <- Enum.with_index(board) do
      for {tile, column_index} <- Enum.with_index(row) do
        if column_index == x && row_index == y do
          new_tile
        else
          tile
        end
      end
    end
  end

  def create(width, height) do
    @space
    |> List.duplicate(width)
    |> List.duplicate(height)
  end

  defp reverse_columns(board) do
    Enum.map(board, &Enum.reverse/1)
  end

  defp reverse_rows(board) do
    Enum.reverse(board)
  end

  defp rotate_clockwise(board) do
    board
    |> swap_rows_with_columns()
    |> reverse_columns()
  end

  defp rotate_anticlockwise(board) do
    board
    |> swap_rows_with_columns()
    |> reverse_rows()
  end

  defp swap_rows_with_columns(rows) do
    Enum.zip_with(rows, & &1)
  end
end

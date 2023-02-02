defmodule Twenty48.Board do
  alias Twenty48.Row
  @space Row.space()

  def move(board, :left) do
    Enum.map(board, &Row.move_left/1)
  end

  def move(board, :right) do
    board
    |> reverse_columns
    |> move(:left)
    |> reverse_columns
  end

  def move(board, :down) do
    board
    |> rotate_clockwise
    |> move(:left)
    |> rotate_anticlockwise
  end

  def move(board, :up) do
    board
    |> rotate_anticlockwise
    |> move(:left)
    |> rotate_clockwise
  end

  def free_spaces(board) do
    for {row, y} <- Enum.with_index(board), {@space, x} <- Enum.with_index(row) do
      {x, y}
    end
  end

  def add(board, {x, y}, number) do
    for {row, row_index} <- Enum.with_index(board) do
      for {tile, column_index} <- Enum.with_index(row) do
        if column_index == x && row_index == y do
          number
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
    |> transpose
    |> reverse_columns
  end

  defp rotate_anticlockwise(board) do
    board
    |> transpose
    |> reverse_rows
  end

  defp transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end

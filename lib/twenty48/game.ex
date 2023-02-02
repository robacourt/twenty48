defmodule Twenty48.Game do
  alias Twenty48.Board
  @winning_number 2048

  def new(board_width \\ 6, board_height \\ 6) do
    %{board: Board.create(board_width, board_height), status: :playing}
    |> add_piece(2)
  end

  def slide(%{board: board, status: :playing} = game, direction) do
    game
    |> Map.put(:board, Board.slide(board, direction))
    |> check_win()
    |> add_piece(1)
  end

  def slide(game, _), do: game

  defp check_win(%{board: board} = game) do
    if board |> List.flatten() |> Enum.any?(&(&1 == @winning_number)) do
      %{game | status: :won}
    else
      game
    end
  end

  defp add_piece(%{board: board, status: :playing} = game, piece) do
    case Board.free_spaces(board) do
      [] -> %{game | status: :lost}
      spaces -> %{game | board: Board.add(board, Enum.random(spaces), piece)}
    end
  end

  defp add_piece(game, _), do: game
end

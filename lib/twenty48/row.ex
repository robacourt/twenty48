defmodule Twenty48.Row do
  @space :_
  @obstacle :x

  def space, do: @space
  def obstacle, do: @obstacle

  def move_left(row), do: move_left(row, 0, [])

  defp move_left([@obstacle | tiles], spaces, acc) do
    move_left(tiles, 0, [@obstacle | add_spaces(acc, spaces)])
  end

  defp move_left([@space | tiles], spaces, acc), do: move_left(tiles, spaces + 1, acc)

  defp move_left([tile, @space | tiles], spaces, acc),
    do: move_left([tile | tiles], spaces + 1, acc)

  defp move_left([tile, tile | tiles], spaces, acc),
    do: move_left(tiles, spaces + 1, [tile * 2 | acc])

  defp move_left([tile | tiles], spaces, acc), do: move_left(tiles, spaces, [tile | acc])
  defp move_left([], spaces, acc), do: acc |> add_spaces(spaces) |> Enum.reverse()

  defp add_spaces(tiles, spaces) do
    List.duplicate(@space, spaces) ++ tiles
  end
end

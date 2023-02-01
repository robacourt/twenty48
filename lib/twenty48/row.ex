defmodule Twenty48.Row do
  @space :_

  def space, do: @space

  def left(row), do: left(row, 0, [])

  defp left([@space | tiles], spaces, acc), do: left(tiles, spaces + 1, acc)
  defp left([tile, @space | tiles], spaces, acc), do: left([tile | tiles], spaces + 1, acc)
  defp left([tile, tile | tiles], spaces, acc), do: left(tiles, spaces + 1, [tile * 2 | acc])
  defp left([tile | tiles], spaces, acc), do: left(tiles, spaces, [tile | acc])
  defp left([], spaces, acc), do: acc |> add_spaces(spaces) |> Enum.reverse()

  defp add_spaces(tiles, spaces) do
    List.duplicate(@space, spaces) ++ tiles
  end
end

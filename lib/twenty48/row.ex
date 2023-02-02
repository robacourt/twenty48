defmodule Twenty48.Row do
  @space :_
  @obstacle :x

  def space, do: @space
  def obstacle, do: @obstacle

  def move_left(row), do: move_left(row, [], [])

  defp move_left([@obstacle | tiles], spaces, acc) do
    move_left(tiles, [], [@obstacle | spaces ++ acc])
  end

  defp move_left([@space | tiles], spaces, acc) do
    move_left(tiles, [@space | spaces], acc)
  end

  defp move_left([tile, @space | tiles], spaces, acc) do
    move_left([tile | tiles], [@space | spaces], acc)
  end

  defp move_left([tile, tile | tiles], spaces, acc) do
    move_left(tiles, [@space | spaces], [tile * 2 | acc])
  end

  defp move_left([tile | tiles], spaces, acc) do
    move_left(tiles, spaces, [tile | acc])
  end

  defp move_left([], spaces, acc) do
    Enum.reverse(spaces ++ acc)
  end
end

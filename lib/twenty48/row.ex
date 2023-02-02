defmodule Twenty48.Row do
  @space :_
  @obstacle :x

  def space, do: @space
  def obstacle, do: @obstacle

  def slide_left(row), do: slide_left(row, [])

  # Obstacles must stay in place so any spaces to the left of them
  # must stay to the left of them and then continue to slide_left the
  # rest of the tiles to the right
  defp slide_left([@obstacle | tiles], spaces) do
    spaces ++ [@obstacle | slide_left(tiles, [])]
  end

  # Spaces can be skipped, but accumilate them so we can add them
  # back later
  defp slide_left([@space | tiles], spaces) do
    slide_left(tiles, [@space | spaces])
  end

  # Remove spaces to the right of the number tile in case there's another
  # number tile that can be merged. Accumilate the spaces so we can add them
  # back later
  defp slide_left([number, @space | tiles], spaces) do
    slide_left([number | tiles], [@space | spaces])
  end

  # Two number tiles that have the same value can be merged
  # into one number tile with double the value, creating an extra
  # space that needs to be accumulated
  defp slide_left([number, number | tiles], spaces) do
    [number * 2 | slide_left(tiles, [@space | spaces])]
  end

  # Number tiles without a same value tile next to them
  # are not merged
  defp slide_left([number | tiles], spaces) do
    [number | slide_left(tiles, spaces)]
  end

  # We're at the right end of the row now,
  # time to add back the spaces we removed from the left
  defp slide_left([], spaces), do: spaces
end

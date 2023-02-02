defmodule Twenty48.Row do
  @space :_
  @obstacle :x

  def space, do: @space
  def obstacle, do: @obstacle

  def slide_left(tiles) do
    tiles
    |> Enum.chunk_by(&(&1 == @obstacle))
    |> Enum.map(&slide_chunk_left/1)
    |> Enum.concat()
  end

  defp slide_chunk_left([@obstacle | _] = obstacles), do: obstacles

  defp slide_chunk_left(tiles) do
    length = Enum.count(tiles)

    tiles
    |> remove_spaces()
    |> merge_numbers()
    |> pad_to_length(length)
  end

  defp remove_spaces(tiles) do
    Enum.reject(tiles, &(&1 == @space))
  end

  defp merge_numbers([number, number | tiles]), do: [2 * number | merge_numbers(tiles)]
  defp merge_numbers([number | tiles]), do: [number | merge_numbers(tiles)]
  defp merge_numbers([]), do: []

  defp pad_to_length(tiles, length) do
    padding_lenth = length - Enum.count(tiles)

    tiles ++ List.duplicate(@space, padding_lenth)
  end
end

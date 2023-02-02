defmodule Twenty48Web.Components do
  use Phoenix.Component

  def select(assigns) do
    ~H"""
    <div>
      <label for={@name}><%= @label %></label>

      <select name={@name} id={@name}>
        <%= for item <- @items do %>
          <option value={ item } selected={item==@value}>
            <%= item %>
          </option>
        <% end %>
      </select>
    </div>
    """
  end

  def status(%{value: :playing} = assigns) do
    ~H"""
    <div class="status--hide" />
    """
  end

  def status(%{value: :won} = assigns) do
    ~H"""
    <div class="status--show">
      <div class="status__text">
        YOU WIN!
      </div>
    </div>
    """
  end

  def status(%{value: :lost} = assigns) do
    ~H"""
    <div class="status--show">
      <div class="status__text">
        YOU LOSE!
      </div>
    </div>
    """
  end

  def board(assigns) do
    ~H"""
    <div class="board">
      <%= for row <- @value do %>
        <div class="board__row">
          <%= for tile <- row do %>
            <.tile value={tile} />
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  defp tile(%{value: number} = assigns) when is_integer(number) do
    ~H"""
    <div class={"tile--#{@value}"}>
      <%= number %>
    </div>
    """
  end

  defp tile(%{value: :_} = assigns) do
    ~H"""
    <div class="tile--empty">
    </div>
    """
  end

  defp tile(%{value: :x} = assigns) do
    ~H"""
    <div class="tile--obstacle">
      #
    </div>
    """
  end
end

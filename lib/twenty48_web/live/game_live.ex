defmodule Twenty48Web.GameLive do
  use Twenty48Web, :live_view

  alias Twenty48.Game

  @directions %{
    "ArrowUp" => :up,
    "ArrowDown" => :down,
    "ArrowLeft" => :left,
    "ArrowRight" => :right
  }

  @arrow_keys Map.keys(@directions)

  def render(assigns) do
    ~H"""
    <div class="game" phx-window-keyup="keyup">
      <div class="board-container">
        <.status value={@game.status} />
        <div class="board">
          <%= for row <- @game.board do %>
            <div class="board__row">
              <%= for tile <- row do %>
                <.tile value={tile} />
              <% end %>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def mount(_, _, socket) do
    {:ok, assign(socket, game: Game.new())}
  end

  defp tile(%{value: number} = assigns) when is_integer(number) do
    ~H"""
    <div class={"tile--#{number}"}>
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

  defp status(%{value: :playing} = assigns) do
    ~H"""
    <div class="status--hide" />
    """
  end

  defp status(%{value: :won} = assigns) do
    ~H"""
    <div class="status--show">
      <div class="status__text">
        YOU WIN!
      </div>
    </div>
    """
  end

  defp status(%{value: :lost} = assigns) do
    ~H"""
    <div class="status--show">
      <div class="status__text">
        YOU LOSE!
      </div>
    </div>
    """
  end

  def handle_event("keyup", %{"key" => key}, socket) when key in @arrow_keys do
    {:noreply, assign(socket, game: Game.slide(socket.assigns.game, @directions[key]))}
  end

  def handle_event("keyup", %{"key" => _key}, socket) do
    {:noreply, socket}
  end
end

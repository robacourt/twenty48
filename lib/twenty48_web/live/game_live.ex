defmodule Twenty48Web.GameLive do
  use Twenty48Web, :live_view

  alias Twenty48.Game
  alias Twenty48Web.Components

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
        <Components.status value={@game.status} />
        <Components.board value={@game.board} />
      </div>
    </div>
    """
  end

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(width: 6, height: 6, obstacles: 0)
      |> new_game()

    {:ok, socket}
  end

  def handle_event("keyup", %{"key" => key}, socket) when key in @arrow_keys do
    {:noreply, assign(socket, game: Game.slide(socket.assigns.game, @directions[key]))}
  end

  def handle_event("keyup", %{"key" => _key}, socket) do
    {:noreply, socket}
  end

  defp new_game(%{assigns: assigns} = socket) do
    assign(socket,
      game:
        Game.new(
          assigns.width,
          assigns.height,
          obstacles: assigns.obstacles
        )
    )
  end
end

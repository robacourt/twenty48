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
    <div class="game" phx-window-keyup="key-up">
      <form phx-submit="new-game">
        <Components.select name="width" label="Width" items={1..6} value={@width} />
        <Components.select name="height" label="Height" items={1..6} value={@height} />
        <Components.select name="obstacles" label="Obstacles" items={0..4} value={@obstacles} />

        <button>New Game</button>
      </form>
      <div class="board-container">
        <Components.status value={@game.status} />
        <Components.board value={@game.board} />
      </div>
      <p>Use your arrow keys to slide the tiles</p>
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

  def handle_event("new-game", params, socket) do
    socket =
      socket
      |> assign(
        width: String.to_integer(params["width"]),
        height: String.to_integer(params["height"]),
        obstacles: String.to_integer(params["obstacles"])
      )
      |> new_game()

    {:noreply, socket}
  end

  def handle_event("key-up", %{"key" => key}, socket) when key in @arrow_keys do
    {:noreply, assign(socket, game: Game.slide(socket.assigns.game, @directions[key]))}
  end

  def handle_event("key-up", %{"key" => _key}, socket) do
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

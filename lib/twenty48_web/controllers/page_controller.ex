defmodule Twenty48Web.PageController do
  use Twenty48Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

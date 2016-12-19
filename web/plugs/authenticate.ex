defmodule Server.AdminPlug do
  @behaviour Plug
  import Plug.Conn

  import Phoenix.Controller

  alias Server.Repo
  alias Server.Player
  require Logger

  def init(opts), do: opts

  def call(conn, _) do
    player = get_session(conn, :player_id)
    if player do
      p = Repo.get(Player, player)
      if p.is_admin === true do
        conn
      else
        conn |> Phoenix.Controller.redirect(to: "/login")
      end
    else
      conn |> Phoenix.Controller.redirect(to: "/login")
    end
  end
end
defmodule Server.SessionPlug do
  @behaviour Plug
  import Plug.Conn

  require Logger

  def init(opts), do: opts

  def call(conn, _) do
    player = get_session(conn, :player_id)
    if player do
        Logger.info "Returning player! #{inspect player}"
        conn 
        |> assign(:token, Phoenix.Token.sign(Server.Endpoint, "token", player))
        |> assign(:player_id, player)
    else
        conn
    end
  end
end
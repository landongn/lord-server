defmodule Server.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias Server.Router.Helpers
  alias Server.Repo
  require Logger

  def login(conn, player) do
    Logger.info "logging in: #{inspect player}"
    token = Phoenix.Token.sign(Server.Endpoint, "token", player.id)

    conn
      |> put_session(:player_id, player.id)
      |> put_session(:token, token)
      |> assign(:token, token)
      |> assign(:player, player)
      |> configure_session(renew: true)
  end


  def logout(conn) do
    configure_session(conn, drop: true)
  end

end
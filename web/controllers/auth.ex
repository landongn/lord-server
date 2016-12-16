defmodule Server.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias Server.Router.Helpers
  alias Server.Repo
  require Logger

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    player_id = get_session(conn, :player_id)
    if player_id do
      Logger.info "player is on plug.call is: #{player_id}"
      player = player_id && repo.get(Server.Player, player_id)
      Logger.info "Found user? #{inspect player}"
      assign(conn, :player, player)
      Logger.info "player set on connection assigns. #{inspect conn.assigns}"
      token = Phoenix.Token.sign(Server.Endpoint, "token", player.email)
      assign(conn, :token, token)
    end
    conn
  end

  def login(conn, player) do
    Logger.info "logging in: #{inspect player.id}"
    token = Phoenix.Token.sign(Server.Endpoint, "token", player.email)
    conn
    |> assign(:player, player)
    |> put_session(:player_id, player)
    |> assign(:token, token)
    |> configure_session(renew: true)
  end

 
  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_user(conn, _opts) do
    Logger.info "authenticate_user: #{conn.assigns.current_user}"
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access that page")
      |> redirect(to: Helpers.index_path(conn, :index))
      |> halt()
    end
  end
end
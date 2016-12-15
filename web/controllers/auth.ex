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
    Logger.info "plug seeking logged in session for player: #{inspect player_id}"
    if player = player_id && repo.get(Server.Player, player_id) do
      put_current_player(conn, player)
    else
      assign(conn, :current_player, nil)
    end
  end

  def login(conn, player) do
    Logger.info "logging in: #{inspect player.id}"
    conn
    |> assign(:current_player, player.id)
    |> put_session(:player_id, player.id)
    |> configure_session(renew: true)
  end

  defp put_current_player(conn, player) do
    token = Phoenix.Token.sign(conn, "player_id", player.id)
    Logger.info "signing token for user: #{token}"
    conn
    |> assign(:current_player, player.id)
    |> assign(:socket_token, token)
    |> put_session(:socket_token, token)

  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_user(conn, _opts) do
    Logger.info "authenticate_user: #{conn.assigns.current_player}"
    if conn.assigns.current_player do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access that page")
      |> redirect(to: Helpers.index_path(conn, :index))
      |> halt()
    end
  end
end
defmodule Server.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Server.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    
    player_id = get_session(conn, :player_id)

    if player = player_id && repo.get(Server.Player, player_id) do
      put_current_player(conn, player)
    else
      assign(conn, :current_player, nil)  
    end
    
  end

  def login(conn, player) do
    conn
    |> assign(:current_player, player)
    |> put_session(:player_id, player.id)
    |> configure_session(renew: true)
  end

  defp put_current_player(conn, player) do
    token = Phoenix.Token.sign(conn, "user socket", player.id)

    conn
    |> assign(:current_player, player)
    |> assign(:user_token, token)
    
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_player do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access that page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
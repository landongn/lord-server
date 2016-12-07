defmodule Server.PageController do
  use Server.Web, :controller
  alias Server.Router.Helpers
  alias Server.Player

  require Logger
  
  def index(conn, _params) do

    render conn, "index.html"
  end

  def login_form(conn, _) do
      changeset = Player.changeset(%Player{}, %{})
      render conn, "logged-out.html", changeset: changeset
  end


  def login(conn, %{"player" => player}) do
    Logger.info "attemping to login as #{inspect player}"
    pw = Map.get(player, :password)
    email = Map.get(player, :email)
      case Server.Repo.get_by(Player, email: email) do
        {:ok, user} ->
            Logger.info "Found user! #{inspect user}"
            Server.Auth.login(conn, user)
            conn.redirect(to: Helpers.page_path(conn, :index))
            conn.halt()
        _ -> 
            Logger.info "Could not find user, passed through."
            conn.redirect(to: Helpers.page_path(conn, :index))
            conn.halt()
      end
  end

  def logout(conn, _) do
    Server.Auth.logout(conn)
    conn.redirect(to: Helpers.page_path(conn, :index))
    conn.halt()
  end
end

defmodule Server.IndexController do
  use Server.Web, :controller
  alias Server.Router.Helpers
  alias Server.Player

  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login_form(conn, _) do
      changeset = Player.changeset(%Player{}, %{})
      render conn, "login.html", changeset: changeset
  end

  def play(conn, _) do

    render conn, "play.html", token: get_session(conn, :token)
  end

  def about(conn, _) do
    render conn, "about.html"
  end

  def signup(conn, _) do
    changeset = Player.new_account(%Player{}, %{})
    render conn, "signup.html", changeset: changeset
  end

  def register(conn, %{"player" => player_params}) do
    changeset = Player.new_account(%Player{}, player_params)

    case Repo.insert(changeset) do
      {:ok, _class} ->
        conn
        |> put_flash(:info, "Account Created!")
        |> redirect(to: index_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Cant create an account with those details.")
        render(conn, "signup.html", changeset: changeset)
    end
  end

  def login(conn, %{"player" => player}) do
    Logger.info "\n\nattemping to login as #{inspect player["email"]}\n\n"

      case Server.Repo.get_by(Player, email: player["email"]) do
        user ->
            Logger.info "\n\nFound user! #{inspect user}"
            Server.Auth.login(conn, user)

            # redirect conn, to: "/play"
            conn |> put_flash(:info, "You have logged in, #{user.email}")
            render conn, "login.html", %{changeset: Player.new_account(%Player{}, player)}

        {:error, _} ->
            conn |> put_flash(:error, "unable to log the user in, no record found")
            Logger.info "\n\nCould not find user, passed through."
            conn.put_flash(:error, "unable to find an account. Sorry.")
            render conn, "login.html"

        nil ->
          conn |> put_flash(:info, "unable to log the user in, no record found")
          render conn, "login.html"
      end
  end

  def logout(conn, _) do
    Server.Auth.logout(conn)
    conn.redirect(to: Helpers.page_path(conn, :index))
    conn.halt()
  end
end

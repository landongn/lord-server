defmodule Server.IndexController do
  use Server.Web, :controller
  alias Server.Router.Helpers
  alias Server.Player
  alias Server.Repo

  alias Server.Update

  require Logger

  def index(conn, _params) do
    updates = Repo.all from u in Update,
      limit: 10,
      order_by: [desc: :inserted_at]

    render conn, "index.html", %{updates: updates}
  end

  def login_form(conn, _params) do
    changeset = Player.changeset(%Player{}, %{})
    render conn, "login.html", changeset: changeset
  end

  def play(conn, _params) do
    player_id = get_session(conn, :player_id)
    if player_id == nil do

      conn
      |> Server.Auth.logout
      |> put_flash(:info, "you need to log in to play")
      |> redirect(to: index_path(conn, :login_form))
      |> halt
    end
    render conn, "play.html"
  end

  def about(conn, _) do
    render conn, "about.html"
  end

  def signup(conn, _) do
    changeset = Player.new_account(%Player{}, %{})
    render conn, "signup.html", changeset: changeset
  end

  def register(conn, %{"player" => %{"email" => email, "password" => password, "name" => name}}) do
    Logger.info "#{email}"
    case Server.Repo.get_by Player, email: email do
      nil ->
        changeset = Player.new_account(%Player{}, %{
          email: email, name: name, password: Comeonin.Bcrypt.hashpwsalt(password)
        })
        case Repo.insert(changeset) do
          {:ok, user} ->

            Logger.info "user registered: #{user.email}"
            conn
            |> Server.Auth.login(user)
            |> redirect(to: index_path(conn, :play))
            |> halt
          {:error, changeset} ->
            Logger.info "user failed: #{changeset.changes.email}"
            conn
            |> put_flash(:error, "Cant create an account. Try a different email address")
            render(conn, "signup.html", changeset: changeset)
        end
      existing ->
        Logger.info "already exists: #{email}"
        conn |> put_flash(:error, "email already exists.  Did you want to login instead?")
        render(conn, "signup.html", changeset: Player.new_account(%Player{}, %{}))
    end
    render(conn, "signup.html", changeset: Player.new_account(%Player{}, %{}))
  end

  def login(conn, %{"player" => player_params}) do
    Logger.info "attemping to login as #{inspect player_params}"

    case Repo.get_by Player, email: player_params["email"] do
      player ->
        case Comeonin.Bcrypt.checkpw(player_params["password"], player.password) do
          true ->
            Logger.info "Password match found"
            conn
            |> Server.Auth.login(player)
            |> redirect(to: "/play")
            |> halt
          false ->
            Logger.info "unable to match passwords for the user."
            conn |> put_flash(:error, "unable to log you in. no matching user for that username/password combo")
            render conn, "login.html", changeset: Player.changeset(%Player{}, %{})
        end
      nil ->
        Logger.info "unable to find a player, or player was nil."
        conn |> put_flash(:info, "unable to log the user in, no record found")
        render conn, "login.html", changeset: Player.changeset(%Player{}, %{})
      end
    render conn, "login.html", changeset: Player.changeset(%Player{}, %{})
  end

  def logout(conn, _) do
    Server.Auth.logout(conn)
    conn.redirect(to: Helpers.index_path(conn, :index))
    conn |> halt
  end
end

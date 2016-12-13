defmodule Server.WorldChannel do
  use Server.Web, :channel
  require Logger
  require Comeonin.Bcrypt

  alias Server.Player
  alias Phoenix.View
  alias Server.WorldView
  alias Server.News
  alias Server.CharacterView

  def join("world:system", _, socket) do
    msg = View.render_to_string(WorldView, "welcome_message.html", %{})
    {:ok, %{message: msg, opcode: "game.client.connect", actions: ["enter"]}, socket}
  end

  def handle_in("motd", _, socket) do
    push socket, "msg", %{
      message: View.render_to_string(WorldView, "motd.html", %{}),
      opcode: "game.client.motd",
      actions: ["enter"]
    }
    {:noreply, socket}
  end

  def handle_in("ident", _, socket) do
    push socket, "msg", %{
      message: View.render_to_string(WorldView, "ident.html", %{}),
      opcode: "game.client.ident-challenge",
      actions: ["e"]
    }
    {:noreply, socket}
  end

  def handle_in("game.client.world.news", _, socket) do
    posts = Repo.all from n in News,
      limit: 10

    push socket, "msg", %{
      message: View.render_to_string(WorldView, "news.html", %{posts: posts}),
      opcode: "game.zone.world.news",
      actions: ["enter", "space"]
    }
    {:noreply, socket}
  end

  def handle_in("email-ident", _, socket) do
    push socket, "msg", %{
      message: View.render_to_string(WorldView, "auth-email.html", %{}),
      opcode: "game.client.ident-email",
      actions: ["enter"]
    }
    {:noreply, socket}
  end

  def handle_in("email-identify", %{"email" => email}, socket) do

    case Server.Repo.get_by Player, email: email do
      record when record != nil ->
        push socket, "msg", %{
          message: View.render_to_string(WorldView, "password.html", record),
          opcode: "game.client.ident.validuser",
          actions: []
        }

      nil ->
        push socket, "msg", %{
          message: View.render_to_string(WorldView, "user-not-found.html", %{email: email}),
          opcode: "game.client.ident.notfound",
          actions: ["enter"]
        }

    end
    {:noreply, socket}
  end

  def handle_in("password-identify", %{"password" => password, "email" => email}, socket) do

    case Server.Repo.get_by Player, email: email do
      player when player != nil ->
        case Comeonin.Bcrypt.checkpw(password, player.password) do
          true ->
            token = Phoenix.Token.sign(Server.Endpoint, "player_id", player.id)
            updated = Ecto.Changeset.change player, secret: token
            Server.Repo.update updated

            push socket, "data", %{
              system: "session",
              opcode: "game.client.session.create",
              token: token,
              user_id: player.id
            }

            push socket, "msg", %{
              message: View.render_to_string(CharacterView, "character-select.html", %{}),
              opcode: "game.zone.character.select",
              actions: ["b", "l", "c", "d"]
            }
          _ ->
            push socket, "msg", %{
              message: View.render_to_string(WorldView, "ident.html", %{}),
              opcode: "game.client.ident-challenge",
              actions: ["e"]
            }
        end
      nil ->
        changeset = Player.changeset(%Player{}, %{
          email: email, password: Comeonin.Bcrypt.hashpwsalt(password)
        })
        case changeset.valid? do
          true ->
            case Server.Repo.insert(changeset) do
              {:ok, player} ->
                token = Phoenix.Token.sign(Server.Endpoint, "player_id", player.id)
                updated = Ecto.Changeset.change player, secret: token
                Server.Repo.update updated

                push socket, "data", %{
                  system: "session",
                  opcode: "game.client.session.create",
                  token: token,
                  user_id: player.id,
                }

                push socket, "msg", %{
                  message: View.render_to_string(CharacterView, "character-select.html", %{}),
                  opcode: "game.zone.character.select",
                  actions: []
                }
              {:error, _} ->
                push socket, "msg", %{opcode: "game.client.ident.error"}
            end
          false ->
            push socket, "msg", %{
              opcode: "game.client.ident.bad-password",
              message: "That password didn't work. Sorry.",
              actions: []
            }
        end
    end
    {:noreply, socket}
  end


  # # Channels can be used in a request/response fashion
  # # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end

  # # It is also common to receive messages from the client and
  # # broadcast to everyone in the current topic (world:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end
end

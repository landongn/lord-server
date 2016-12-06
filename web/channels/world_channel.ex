defmodule Server.WorldChannel do
  use Server.Web, :channel
  require Logger
  require Comeonin.Bcrypt

  alias Server.Player
  alias Phoenix.View
  alias Server.WorldView

  def join("world:system", _, socket) do
    msg = View.render_to_string(WorldView, "welcome_message.html", %{})
    {:ok, %{message: msg, opcode: "game.client.connect"}, socket}
  end

  def handle_in("motd", _, socket) do
    msg = View.render_to_string(WorldView, "motd.html", %{})
    push socket, "msg", %{message: msg, opcode: "game.client.motd", actions: ["enter", "space"]}
    {:noreply, socket}
  end

  def handle_in("ident", _, socket) do
    msg = View.render_to_string(WorldView, "auth_challenge.html", %{})
    push socket, "msg", %{message: msg, opcode: "game.client.ident-challenge", actions: ["e", "g"]}
    {:noreply, socket}
  end

  def handle_in("email-ident", _, socket) do
    msg = View.render_to_string(WorldView, "auth-email.html", %{})
    push socket, "msg", %{message: msg, opcode: "game.client.ident-email", actions: ["enter", "space"]}
    {:noreply, socket}
  end

  def handle_in("email-identify", %{"email" => payload}, socket) do

    case Server.Repo.get_by Player, email: payload do
      record when record != nil ->
        msg = View.render_to_string(WorldView, "password.html", record)
        push socket, "msg", %{message: msg, opcode: "game.client.ident.validuser"}

      nil ->
        msg = View.render_to_string(WorldView, "user-not-found.html", %{email: payload})
        push socket, "msg", %{message: msg, opcode: "game.client.ident.notfound"}

    end
    {:noreply, socket}
  end

  def handle_in("password-identify", %{"password" => password, "email" => email}, socket) do

    case Server.Repo.get_by Player, email: email do
      record when record != nil ->
        hash = Comeonin.Bcrypt.checkpw(password, record.password)
        push socket, "msg", %{message: View.render_to_string(WorldView, "welcome-back.html", %{name: record.name}), opcode: "game.client.ident.success"}
      nil ->
        changeset = Player.changeset(%Player{}, %{email: email, password: Comeonin.Bcrypt.hashpwsalt(password)})
        case changeset.valid? do
          true ->
            case Server.Repo.insert(changeset) do
              {:ok, _} ->
                push socket, "msg", %{message: View.render_to_string(WorldView, "email-identify.html", %{email: email}), opcode: "game.client.ident.success"}
              {:error, changeset} ->
                push socket, "msg", %{opcode: "game.client.ident.error"}
            end
          false ->
            push socket, "msg", %{opcode: "game.client.ident.bad-password", message: "That password wasn't accepted. Try harder."}
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

  # # Add authorization logic here as required.
  # defp authorized?(_payload) do
  #   true
  # end
end

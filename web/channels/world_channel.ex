defmodule Server.WorldChannel do
  use Server.Web, :channel
  require Logger
  require Comeonin.Bcrypt

  alias Server.Player
  alias Phoenix.View
  alias Server.WorldView
  alias Server.News
  alias Server.CharacterView

  def join("world:system", payload, socket) do
    if authorized?(socket, payload) do
      msg = View.render_to_string(WorldView, "welcome_message.html", %{})
      {:ok, %{message: msg, opcode: "game.client.connect", actions: ["enter"]}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(socket, payload) do
    if socket.assigns.player_id do
      true
    end
  end

  def handle_in("motd", _, socket) do
    push socket, "msg", %{
      message: View.render_to_string(WorldView, "motd.html", %{}),
      opcode: "game.client.motd",
      actions: ["enter"]
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


end

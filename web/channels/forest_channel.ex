defmodule Server.ForestChannel do
  use Server.Web, :channel

  alias Game.Forest

  def join("forest", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("game.zone.forest.loiter", payload, socket) do
    push socket, "msg", %{
      opcode: "game.zone.forest.loiter",
      message: View.render_to_string(ForestView, "loiter.html", %{}),
      actions: ["l", "h", "r", "v"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.healer.loiter", payload, socket) do
    push socket, "msg", %{
      opcode: "game.zone.forest.loiter",
      message: View.render_to_string(ForestView, "healer-loiter.html", %{}),
      actions: ["h", "r", "a"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.stats", payload, socket) do
    user = Game.Forest.lookup(socket.assigns[:user_id])
    push socket, "msg", %{
      message: View.render_to_string(ForestView, "stats.html", %{user: user}),
      opcode: "game.zone.forest.stats",
      user: user,
      actions: ["l", "h", "r", "v", "b"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.search", payload, socket) do
    case Game.Forest.spawn(socket.assigns[:user_id],
     socket.assigns[:token],
     payload["name"],
     payload["level"]) do
       {:reply, encounter, _} ->
        push socket, "msg", %{
          opcode: "game.zone.forest.fight",
          encounter: encounter,
          message: View.render_to_string(ForestView, "fight.html", %{encounter: encounter}),
          actions: ["a", "r", "s"]
        }
      :error ->
        push socket, "msg", %{
          opcode: "game.zone.forest.error",
          message: "shit! it broke"
        }
     end
    {:noreply, socket}
  end


  def handle_in("game.zone.forest.attack", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.forest.round",
      message: View.render_to_string(ForestView, "attack.html", %{}),
      actions: ["l", "h", "r"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.power-move", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.forest.round",
      message: View.render_to_string(ForestView, "power-move.html", %{}),
      actions: ["l", "h", "r"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.run-away", payload, socket) do
    push socket, "msg", %{
      message: View.render_to_string(ForestView, "run-away.html", %{}),
      opcode: "game.zone.forest.round",
      actions: ["l", "h", "r"]
    }
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

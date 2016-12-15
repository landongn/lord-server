defmodule Server.ZoneChannel do
  use Server.Web, :channel

  def join("zone", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end



  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (zone:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("status", payload, socket) do
    # <user> has entered <zone>
    # <user> has left <zone>
    # <user> hello
    # <user> has died via <mob|user>
    # <user> has gained a level
    {:noreply, socket}
  end

  def handle_in("game.zone.chat.level.up", payload, socket) do
    broadcast! socket, "game.zone.chat.level.up", %{
      from: payload["character"],
      message: View.render_to_string(ChatView, "level-up.html", %{payload: payload}),
      stamp: :os.system_time(:seconds)
    }
  end

   def handle_in("game.zone.broadcast", payload, socket) do
    payload =  %{
      from: payload["character"],
      message: payload["message"],
      stamp: :os.system_time(:seconds),
      opcode: 'game.zone.broadcast'
    }
    broadcast! socket, "game.zone.chat.shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

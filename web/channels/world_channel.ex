defmodule Server.WorldChannel do
  use Server.Web, :channel

  alias Phoenix.View
  alias Server.WorldView

  def join("world", _payload, socket) do
    msg = View.render_to_string(WorldView, "welcome_message.html", %{})
    {:ok, %{message: msg}, socket}
  end

  def handle_in('motd', _, socket) do
    msg = View.render_to_string(WorldView, "motd.html", %{})
    {:ok, %{message: msg, actions: []}, socket}
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

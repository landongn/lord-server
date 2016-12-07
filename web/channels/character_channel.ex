defmodule Server.CharacterChannel do
  use Server.Web, :channel

  alias Phoenix.View
  alias Server.CharacterView
  alias Server.Repo
  alias Server.Player
  alias Server.Character
  alias Ecto.Query

  def join("character", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("game.zone.character.list", %{"user_id" => user_id, "token" => token}, socket) do
    q = Character
      |> Query.where(player_id: ^user_id)
    results = Repo.all(q)

    push socket, "msg", %{
      opcode: "game.zone.character.list",
      characters: results,
      message: View.render_to_string(CharacterView, "character-list.html", %{characters: results})
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.create", payload, socket) do

    {:noreply, socket}
  end

  def handle_in("game.zone.character.new", payload, socket) do
    {:noreply, socket}
  end

  def handle_in("game.zone.character.delete", payload, socket) do
    {:noreply, socket}
  end

end

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

  def handle_in("game.zone.character.list", payload, socket) do
    q = Character
      |> Query.where(player_id: ^payload["user_id"])
    results = Repo.all(q)

    push socket, "msg", %{
      opcode: "game.zone.character.list",
      characters: results,
      message: View.render_to_string(CharacterView, "character-list.html", %{characters: results})
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.create", _payload, socket) do
    push socket, "msg", %{
      opcode: "game.zone.character.new",
      message: View.render_to_string(CharacterView, "new-character.html", %{})
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.select", payload, socket) do
    push socket, "msg", %{
      message: View.render_to_string(CharacterView, "character-select.html", %{}),
      opcode: "game.zone.character.select",
      actions: []
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.validate", payload, socket) do
    
    case Repo.get_by Character, name: payload["name"] do
      {:ok, user} ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-name-reject.html", %{}),
          opcode: "game.zone.character.name-reject",
          actions: []
        }
      nil ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-confirm.html", %{name: payload["name"]}),
          opcode: "game.zone.character.confirm",
          actions: []
        }
      {:noreply, socket}
    end

  end


  def handle_in("game.zone.character.new", payload, socket) do
    {:noreply, socket}
  end

  def handle_in("game.zone.character.delete", payload, socket) do
    {:noreply, socket}
  end

end

defmodule Server.CharacterChannel do
  use Server.Web, :channel
  require Logger
  alias Phoenix.View
  alias Server.CharacterView
  alias Server.VillageView
  alias Server.Repo

  alias Server.Character
  alias Server.Weapon
  alias Server.Armor
  alias Server.Class
  alias Server.Presence

  def join("character", payload, socket) do
    if authorized?(socket, payload) do
      {:ok, socket}
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

  def handle_in("game.zone.character.list", payload, socket) do
    player_id = socket.assigns.player_id
    chars = Repo.all from c in Character,
      join: w in Weapon, on: w.id == c.weapon_id,
      join: a in Armor, on: a.id == c.armor_id,
      join: k in Class, on: k.id == c.class_id,
      select: %{"id" => c.id, "name" => c.name, "level" => c.level, "gold" => c.gold, "armor" => a.name, "weapon" => w.name, "class" => k.name},
      where: c.player_id == ^player_id,
      where: c.is_alive == true

    push socket, "msg", %{
      opcode: "game.zone.character.list",
      characters: chars,
      actions: [],
      message: View.render_to_string(CharacterView, "character-list.html", %{characters: chars})
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.play", payload, socket) do

    char = Character
      |> where(id: ^payload["char_id"])
      |> Repo.one!

    rec = %{
      id: payload["char_id"],
      name: char.name,
      level: char.level,
      experience: char.experience,
      gold: char.gold,
      gems: char.gems,
      is_alive: char.is_alive,
      health: char.health,
      defense: char.defense,
      strength: char.strength,
      endurance: char.endurance,
      luck: char.luck
    }


    Logger.info "welcoming #{inspect rec.name}"

    Game.Forest.enter(rec)

    push socket, "data", %{
      opcode: "game.client.character.update",
      payload: rec,
      system: "character",
    }

    push socket, "msg", %{
      opcode: "game.zone.village.loiter",
      char: rec,
      message: View.render_to_string(VillageView, "loiter.html", %{}),
      actions: ["f", "k", "h", "i", "y", "w", "c", "p", "s", "a", "v", "t", "l", "d", "o", "q"]
    }

    socket = assign(socket, :name, char.name)
    socket = assign(socket, :character_id, char.id)

    Server.Endpoint.broadcast("zone", "chat", %{
      from: '',
      message: "#{char.name} has come online.",
      stamp: :os.system_time(:seconds),
      opcode: "game.zone.broadcast"
    })
    {:noreply, socket}
  end

  def handle_in("game.zone.character.create", _payload, socket) do
    push socket, "msg", %{
      opcode: "game.zone.character.new",
      actions: ["space"],
      message: View.render_to_string(CharacterView, "new-character.html", %{})
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.select", _payload, socket) do
    push socket, "msg", %{
      message: View.render_to_string(CharacterView, "character-select.html", %{}),
      opcode: "game.zone.character.select",
      actions: []
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.validate", payload, socket) do

    case Repo.get_by Character, name: payload["name"] do
      struct ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-confirm.html", %{name: payload["name"], char: struct}),
          opcode: "game.zone.character.confirm",
          name: payload["name"],
          actions: ["k", "d", "l", "b"]
        }
      nil ->
        push socket, "msg", %{
          message: "",
          opcode: "game.zone.character.name-reject",
          name: payload["name"],
          actions: []
        }
    end
    {:noreply, socket}

  end


  def handle_in("game.zone.character.class-selected", payload, socket) do
    changeset = Character.new_character(%Character{}, %{
      name: payload["name"],
      class_id: payload["class"],
      player_id: socket.assigns.player_id
    })

    case Repo.insert!(changeset) do
      record ->
        case payload["class"] do
          1 ->
            push socket, "msg", %{
              message: View.render_to_string(CharacterView, "character-birth-dk.html", %{character: record}),
              opcode: "game.zone.character.birth",
              actions: []
            }
          2 ->
            push socket, "msg", %{
              message: View.render_to_string(CharacterView, "character-birth-mystic.html", %{character: record}),
              opcode: "game.zone.character.birth",
              actions: []
            }
          3 ->
            push socket, "msg", %{
              message: View.render_to_string(CharacterView, "character-birth-thief.html", %{character: record}),
              opcode: "game.zone.character.birth",
              actions: []
            }
        end
      :error ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-name-reject.html", %{}),
          opcode: "game.zone.character.invalid-character",
          actions: []
        }
    end

    char = Repo.get_by!(Character, name: payload["name"])
    push socket, "data", %{
      opcode: "game.client.character.update",
      payload: char,
      system: "character",
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.character.delete-confirm", payload, socket) do
    Logger.info "id given to delete: #{payload["id"]}"
    char = Repo.get(Character, payload["id"])
    Repo.delete! char

    push socket, "msg", %{
      message: View.render_to_string(CharacterView, "character-select.html", %{}),
      opcode: "game.zone.character.select",
      actions: ["l", "c", "d"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.delete", payload, socket) do
    chars = Repo.all from c in Character,
      join: w in Weapon, on: c.weapon_id == w.id,
      join: a in Armor, on: c.armor_id == a.id,
      join: k in Class, on: c.class_id == k.id,
      select: %{"name" => c.name, "level" => c.level, "gold" => c.gold, "armor" => a.name, "weapon" => w.name, "class" => c.name, "id" => c.id},
      where: c.player_id == ^payload["user_id"]

      push socket, "msg", %{
        message: View.render_to_string(CharacterView, "character-list.html", %{characters: chars}),
        opcode: "game.zone.character.delete",
        characters: chars,
        actions: ["l", "c", "d"]
      }
    {:noreply, socket}
  end

  def terminate(_, socket) do
    Logger.info "terminating character session: #{socket.assigns.player_id}"
    Server.Endpoint.broadcast("zone", "chat", %{
      from: '',
      message: "#{socket.assigns.player_id} has gone offline.",
      stamp: :os.system_time(:seconds),
      opcode: "game.zone.broadcast"
    })
  end

end

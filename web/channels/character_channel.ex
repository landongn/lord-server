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

  def join("character", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("game.zone.character.list", payload, socket) do

    chars = Repo.all from c in Character,
      join: w in Weapon, on: c.weapon_id == w.id,
      join: a in Armor, on: c.armor_id == a.id,
      join: k in Class, on: c.class_id == k.id,
      select: %{"name" => c.name, "level" => c.level, "gold" => c.gold, "armor" => a.name, "weapon" => w.name, "class" => c.name},
      where: c.player_id == ^payload["user_id"]

    push socket, "msg", %{
      opcode: "game.zone.character.list",
      characters: chars,
      message: View.render_to_string(CharacterView, "character-list.html", %{characters: chars})
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.play", _payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.loiter",
      message: View.render_to_string(VillageView, "loiter.html", %{}),
      actions: ["h", "i", "r", "w", "t", "f", "d"]
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
      nil ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-confirm.html", %{name: payload["name"]}),
          opcode: "game.zone.character.confirm",
          name: payload["name"],
          actions: ["k", "d", "l", "b"]
        }
      _ ->
        push socket, "msg", %{
          message: '',
          opcode: "game.zone.character.name-reject",
          name: payload["name"],
          actions: []
        }
    end
    {:noreply, socket}

  end


  def handle_in("game.zone.character.class-selected", payload, socket) do
    Logger.info "payload data: #{inspect payload}"
    changeset = Character.new_character(%Character{}, %{
      name: payload["name"],
      class_id: payload["class"],
      player_id: payload["user_id"]
    })

    case Repo.insert!(changeset) do
      record ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-birth.html", %{character: record}),
          opcode: "game.zone.character.birth",
          actions: []
        }
      :error ->
        push socket, "msg", %{
          message: View.render_to_string(CharacterView, "character-name-reject.html", %{}),
          opcode: "game.zone.character.invalid-character",
          actions: []
        }
    end

    {:noreply, socket}
  end

  def handle_in("game.zone.character.delete", payload, socket) do
    chars = Repo.all from c in Character,
      join: w in Weapon, on: c.weapon_id == w.id,
      join: a in Armor, on: c.armor_id == a.id,
      join: k in Class, on: c.class_id == k.id,
      select: %{"name" => c.name, "level" => c.level, "gold" => c.gold, "armor" => a.name, "weapon" => w.name, "class" => c.name},
      where: c.player_id == ^payload["user_id"]

    push socket, "msg", %{
      message: View.render_to_string(CharacterView, "character-list.html", %{characters: chars}),
      opcode: "game.zone.character.delete",
      characters: chars,
      actions: []
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.character.delete-confirm", payload, socket) do
    case Repo.get(Character, payload["id"]) do
      record ->
        case Repo.delete!(Character, payload["id"]) do
          :ok ->
            push socket, "msg", %{
              message: View.render_to_string(CharacterView, "character-was-deleted.html", %{character: record}),
              opcode: "game.zone.character.delete-success",
              actions: ["b"]
            }
        end
      end
    {:noreply, socket}
  end

end
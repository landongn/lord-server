defmodule Server.WorldChannel do
  use Server.Web, :channel
  require Logger
  require Comeonin.Bcrypt

  alias Server.Player
  alias Phoenix.View
  alias Server.WorldView
  alias Server.News
  alias Server.CharacterView
  alias Server.Character
  alias Server.Armor
  alias Server.Weapon
  alias Server.Class

  def join("world:system", payload, socket) do
    if authorized?(socket, payload) do
      msg = View.render_to_string(WorldView, "motd.html", %{})
      {:ok, %{
        message: msg,
        opcode: "game.client.connect",
        actions: ["enter", "space", "e", "i", "l"]
        }, socket}
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


  def handle_in("game.client.world.connect", _, socket) do
    push socket, "msg", %{
      message: View.render_to_string(WorldView, "motd.html", %{}),
      opcode: "game.client.connect",
      actions: ["enter", "space", "e", "i", "l"]
    }
    {:noreply, socket}
  end
  def handle_in("game.client.world.leaderboards", _, socket) do

    chars = Repo.all from(c in Character,
      join: w in Weapon, on: w.id == c.weapon_id,
      join: a in Armor, on: a.id == c.armor_id,
      join: k in Class, on: k.id == c.class_id,
      select: %{
        "id" => c.id,
        "name" => c.name,
        "level" => c.level,
        "gold" => c.gold,
        "experience" => c.experience,
        "armor" => a.name,
        "weapon" => w.name,
        "class" => k.name
      },
      order_by: [desc: c.experience])

    push socket, "msg", %{
      message: View.render_to_string(WorldView, "leaderboards.html", %{chars: chars}),
      opcode: "game.client.world.leaderboards",
      actions: ["enter", "r", "space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.client.world.instructions", _, socket) do
    push socket, "msg", %{
      message: View.render_to_string(WorldView, "instructions.html", %{}),
      opcode: "game.client.world.instructions",
      actions: ["enter", "r", "space"]
    }
    {:noreply, socket}
  end

  def handle_in("game.client.world.news", _, socket) do
    posts = Repo.all from n in News,
      limit: 10,
      order_by: [desc: :id]

    push socket, "msg", %{
      message: View.render_to_string(WorldView, "news.html", %{posts: posts}),
      opcode: "game.client.world.news",
      actions: ["enter", "space"]
    }
    {:noreply, socket}
  end


end

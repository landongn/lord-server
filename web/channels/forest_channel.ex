defmodule Server.ForestChannel do
  use Server.Web, :channel

  require Logger
  alias Server.ForestView
  alias Game.Forest
  alias Phoenix.View

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
    user = Forest.lookup(socket.assigns[:user_id])
    push socket, "msg", %{
      message: View.render_to_string(ForestView, "stats.html", %{user: user}),
      opcode: "game.zone.forest.stats",
      user: user,
      actions: ["l", "h", "r", "v", "b"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.search", payload, socket) do

    encounter = Forest.spawn("thock", 2)
    push socket, "msg", %{
      opcode: "game.zone.forest.fight",
      encounter: encounter,
      message: View.render_to_string(ForestView, "fight.html", encounter),
      actions: ["a", "r", "s"]
    }

    {:noreply, socket}
  end


  def handle_in("game.zone.forest.attack", payload, socket) do

    case Forest.lookup("thock") do
      {:ok, fight} ->
        Logger.info "STARTING FIGHT\n\n"
        char = fight.char
        mob = fight.mob
        charArmor = Repo.get(Server.Armor, char.armor_id)
        charWeapon = Repo.get(Server.Weapon, char.weapon_id)
        Logger.info "associations loaded\n\n"
        c_str = char.strength
        c_def = char.defense
        c_health = char.health
        c_armor = charArmor.defense
        c_weapon = charWeapon.damage
        Logger.info "char stats: #{c_str} #{c_def} #{c_health} #{c_armor} #{c_weapon}"

        m_str = mob.strength
        m_def = mob.defense
        m_health = mob.health
        m_armor = mob.defense
        m_damage = mob.damage
        Logger.info "mob stats: #{m_str} #{m_def} #{m_health} #{m_armor} #{m_damage}"
        Logger.info "Setup finished\n\n"
        damage_dealt = ((c_str * c_weapon) - (m_def * m_armor))
        retaliation_suffered = ((m_str * m_damage) - (c_def * c_armor) * 0.05)

        mob = %{mob | health: (mob.health - damage_dealt)}
        char = %{char| health: (c_health - retaliation_suffered)}
        Logger.info "round calculated"
        if char.health <= 0 do
          # push death
          Logger.info "oh no, the character died!"
        else
          if mob.health <= 0 do
            #push victory
            Logger.info "oh no, the mob has died!"
          else
            Logger.info("ROUND SUCCESS\n\n")
            updatedFight = %{char: char, mob: mob, retaliation_suffered: retaliation_suffered, damage_dealt: damage_dealt}

            Forest.attack("thock", updatedFight)
            Logger.info("Updated Records")
            push socket, "msg", %{
              opcode: "game.zone.forest.round",
              fight: updatedFight,
              message: View.render_to_string(ForestView, "attack.html", updatedFight),
              actions: ["a", "s", "r"]
            }
          end
        end
      :error ->
        Logger.info "\n unable to lookup fight for thock\n"
    end
    Logger.info("All done\n\n")
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
      opcode: "game.zone.forest.loiter",
      actions: ["l", "h", "r"]
    }
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

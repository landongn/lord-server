defmodule Server.ForestChannel do
  use Server.Web, :channel

  require Logger
  alias Server.ForestView
  alias Game.Forest
  alias Phoenix.View

  alias Server.News
  alias Server.HealerView

  alias Server.Character
  alias Server.Armor
  alias Server.Weapon
  alias Server.Class

  def roll(sides) do
    case sides do
      5 ->
        Enum.random([1, 2, 3, 4, 5])
      10 ->
        Enum.random([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      20 ->
        Enum.random([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
    end
  end

  def join("forest", payload, socket) do
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

  def handle_in("game.zone.forest.loiter", payload, socket) do

    player = Repo.get(Character, payload["char_id"])
    weapon = Repo.get(Weapon, player.weapon_id)
    armor = Repo.get(Armor, player.armor_id)

    push socket, "msg", %{
      opcode: "game.zone.forest.loiter",
      message: View.render_to_string(ForestView, "loiter.html", %{char: player, weapon: weapon, armor: armor}),
      actions: ["l", "h", "r", "v"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.healer.loiter", payload, socket) do
    push socket, "msg", %{
      opcode: "game.zone.healer.loiter",
      message: View.render_to_string(HealerView, "healer-loiter.html", %{}),
      actions: ["h", "r", "a"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.stats", payload, socket) do

    char = Repo.get(Character, payload["id"])
    weapon = Repo.get(Weapon, char.weapon_id)
    armor = Repo.get(Armor, char.armor_id)
    class = Repo.get(Class, char.class_id)

    push socket, "msg", %{
      message: View.render_to_string(ForestView, "stats.html", %{
        char: char, class: class, armor: armor, weapon: weapon
      }),

      opcode: "game.zone.forest.stats",
      char: char,
      actions: ["l", "h", "r", "v", "b"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.forest.search", payload, socket) do

    encounter = Forest.spawn(payload["id"], payload["level"])
    push socket, "msg", %{
      opcode: "game.zone.forest.fight",
      encounter: encounter,
      message: View.render_to_string(ForestView, "fight.html", encounter),
      actions: ["a", "r", "s"]
    }

    {:noreply, socket}
  end


  def handle_in("game.zone.forest.attack", payload, socket) do

    charId = payload["id"]

    case Forest.lookup(charId) do
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
        damage_dealt = round((c_str * c_weapon) - (m_def * m_armor) * Enum.random([0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]))
        retaliation_suffered = round((m_str * m_damage) - (c_def * c_armor) * Enum.random([-0.5, -1.0, -1.5]))

        missed_me = false
        missed_them = false

        if retaliation_suffered <= 0 do
          missed_me = true
        else
          missed_me = false
          char = %{char | health: round(c_health - retaliation_suffered)}
        end

        if damage_dealt <= 0 do
          missed_them = true
        else
          mob = %{mob | health: round(mob.health - damage_dealt)}
          missed_them = false
        end

        Logger.info "round calculated"
        if char.health <= 0 do
          # push death
          char = %{char | is_alive: false, experience: round(char.experience + mob.experience), gold: round(char.gold + mob.gold)}
          Logger.info "oh no, the character died!"
          Forest.battle_report(char.id, %{char: char, mob: mob})

          changeset = Server.News.changeset(%Server.News{}, %{posted_by: mob.name, body: "#{mob.name} has murdered #{char.name} in cold blood."})
          Repo.insert!(changeset)

          changeset = Character.battle_report(%Character{id: char.id}, %{
            gold: char.gold,
            experience: char.experience,
            gems: char.gems,
            health: char.health,
            level: char.level,
            is_alive: char.is_alive
          })
          Repo.update!(changeset)

          push socket, "msg", %{
            opcode: "game.zone.forest.killed",
            message: View.render_to_string(ForestView, "killed.html", %{char: char, mob: mob, retaliation_suffered: retaliation_suffered}),
            actions: ["space"],
            fight: %{char: char, mob: mob}
          }

          Server.Endpoint.broadcast("zone", "chat", %{
            from: '',
            message: "#{mob.name} has slain #{char.name}.",
            stamp: :os.system_time(:seconds),
            opcode: "game.zone.broadcast"
          })

        else
          if mob.health <= 0 do
            #push victory
            Forest.battle_report(char.name, %{char: char, mob: mob})
            gemroll = roll 20
            gemdrop = false
            gemsfound = roll 5
            case roll 20 do
              r when r > 17 ->
                gemdrop = true
                char = %{char | gems: (char.gems + gemsfound), is_alive: true, experience: round(char.experience + mob.experience), gold: round(char.gold + mob.gold)}
              r when r < 17 ->
                char = %{char | is_alive: false, experience: round(char.experience + mob.experience), gold: round(char.gold + mob.gold)}
            end

            Logger.info "\n\n GEM DATA: \n #{inspect gemdrop} \n #{inspect gemsfound} \n #{inspect gemroll}"


            changeset = News.changeset(%News{}, %{posted_by: mob.name, body: "#{char.name} has slain #{mob.name}."})
            Repo.insert!(changeset)

            changeset = Character.battle_report(%Character{id: char.id}, %{
              gold: char.gold,
              experience: char.experience,
              gems: char.gems,
              health: char.health,
              level: char.level,
              is_alive: char.is_alive
            })
            Repo.update!(changeset)
            Logger.info "oh no, the mob has died!"
            push socket, "msg", %{
              opcode: "game.zone.forest.kill",
              fight: %{char: char, mob: mob, char_missed: missed_them, mob_missed: missed_me},
              message: View.render_to_string(ForestView, "kill.html", %{char: char, mob: mob, damage_dealt: damage_dealt, gemsfound: gemsfound, gemdrop: gemdrop}),
              actions: ["space"]
            }

            Server.Endpoint.broadcast("zone", "chat", %{
              from: '',
              message: "#{char.name} has slain #{mob.name}.",
              stamp: :os.system_time(:seconds),
              opcode: "game.zone.broadcast"
            })

          else
            Logger.info("ROUND SUCCESS\n\n")

            updatedFight = %{char: char, mob: mob, char_missed: missed_them, mob_missed: missed_me,
            retaliation_suffered: retaliation_suffered, damage_dealt: damage_dealt}

            Forest.attack(char.id, updatedFight)
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
      message: View.render_to_string(ForestView, "loiter.html", %{}),
      opcode: "game.zone.forest.loiter",
      actions: ["l", "h", "r"]
    }
    {:noreply, socket}
  end

end

defmodule Server.ForestChannel do
  use Server.Web, :channel

  alias Server.Combat
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
      100 ->
        round(:rand.uniform() * 100)
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
        c_str = char.strength
        c_def = char.defense
        c_health = char.health
        c_armor = charArmor.defense
        c_weapon = charWeapon.damage

        m_str = mob.strength
        m_def = mob.defense
        m_health = mob.health
        m_armor = mob.defense
        m_damage = mob.damage

        mob_base_damage = roll 10
        char_base_damage = roll 10

        charStats = %{
          strength: c_str,
          defense: c_def,
          health: c_health,
          armor: c_armor,
          weapon: c_weapon,
          level: char.level
        }

        mobStats = %{
          strength: m_str,
          defense: m_def,
          health: m_health,
          armor: m_armor,
          weapon: m_damage,
          level: mob.level
        }

        {charStats, mobStats, damage_dealt} = Combat.attack(charStats, mobStats)
        {mobStats, charStats, retaliation_suffered} = Combat.attack(mobStats, charStats)

        missed_me = false
        missed_them = false


        if retaliation_suffered <= 0 do
          missed_me = true
        else
          missed_me = false
        end

        if damage_dealt <= 0 do
          missed_them = true
        else
          missed_them = false
        end

        char = %{char | health: charStats.health}
        mob = %{mob | health: mobStats.health}

        if mob.health <= 0 do
          #push victory
          # reset health so death stuff doesn't damage chars
          char = %{char | health: fight.char.health}
          Forest.battle_report(char.name, %{char: char, mob: mob})
          gemroll = roll 100
          gemdrop = false
          gemsfound = 1
          case roll 100 do
            r when r >= 98 ->
              gemdrop = true
              char = %{char | gems: (char.gems + gemsfound),
              is_alive: true,
              experience: round(char.experience + mob.experience),
              gold: round(char.gold + mob.gold)}

            r when r <= 97 ->
              char = %{char | is_alive: true, experience: round(char.experience + mob.experience), gold: round(char.gold + mob.gold)}
          end

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

          if char.health <= 0 do
            # push death
            char = %{char | is_alive: false,
              experience: round(char.experience + mob.experience),
              gold: round(char.gold + mob.gold),
              health: charStats.health}

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
            char = %{char | health: charStats.health}
            mob = %{mob | health: mobStats.health}
            updatedFight = %{char: char, mob: mob, char_missed: missed_them,
            mob_missed: missed_me, retaliation_suffered: retaliation_suffered,
            damage_dealt: damage_dealt}

            Forest.attack(char.id, updatedFight)

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
    charId = payload["char_id"]

    case Forest.lookup(charId) do
      {:ok, fight} ->
        char = fight.char
        mob = fight.mob
        Forest.battle_report(char.id, %{char: char, mob: mob})

        changeset = Server.News.changeset(%Server.News{}, %{posted_by: mob.name, body: "#{char.name} ran away from #{mob.name} after being beaten nearly to death."})
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
    end

    push socket, "msg", %{
      message: View.render_to_string(ForestView, "run-away.html", %{}),
      opcode: "game.zone.forest.run-away",
      actions: ["space", "enter"]
    }
    {:noreply, socket}
  end

end

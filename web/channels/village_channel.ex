defmodule Server.VillageChannel do
  use Server.Web, :channel

  alias Phoenix.View
  alias Server.VillageView
  alias Server.Character
  alias Server.Repo
  alias Server.Weapon
  alias Server.Armor
  alias Server.News
  alias Server.Class
  alias Server.Master
  alias Server.Skill
  alias Server.Level
  alias Game.Forest
  alias Server.Combat


  require Logger

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

  def join("village", payload, socket) do
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


  def handle_in("game.zone.village.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.loiter",
      message: View.render_to_string(VillageView, "loiter.html", %{}),
      actions: ["f", "k", "h", "i", "y", "w", "c", "p", "s", "a", "v", "t", "l", "d", "o", "q"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.players.online", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.players.online",
      message: View.render_to_string(VillageView, "players-online.html", %{}),
      actions: ["f", "k", "h", "i", "y", "w", "c", "p", "s", "a", "v", "t", "l", "d", "o", "q"]
    }

    {:noreply, socket}
  end


  def handle_in("game.zone.village.stats", payload, socket) do
    char = Repo.get(Character, payload["char_id"])
    wep = Repo.get(Weapon, char.weapon_id)
    armor = Repo.get(Armor, char.armor_id)
    class = Repo.get(Class, char.class_id)
    master = Repo.get_by(Master, rank: char.level)
    skills = Repo.all from(s in Skill,
      where: s.class_id == ^char.class_id,
      where: s.rank <= ^char.level)

    push socket, "msg", %{
      opcode: "game.zone.village.stats",
      message: View.render_to_string(VillageView, "stats.html", %{
        char: char,
        weapon: wep,
        armor: armor,
        class: class,
        skills: skills,
        master: master
      }),
      actions: ["r"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.village.mail", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.mail",
      message: View.render_to_string(VillageView, "write-mail.html", %{}),
      actions: ["r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.loiter", payload, socket) do

    char = Repo.get(Character, payload["char_id"])
    weapon = Repo.get(Weapon, char.weapon_id)

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.loiter",
      message: View.render_to_string(VillageView, "weapons-loiter.html", %{wep: weapon, char: char}),
      actions: ["b", "s" ,"r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.buy", payload, socket) do
    char = Repo.get(Character, payload["char_id"])
    equipped_weapon = Repo.get(Weapon, char.weapon_id)
    weapons = Repo.all(Weapon)


    push socket, "msg", %{
      opcode: "game.zone.village.weapons.buy",
      equipment: weapons,
      message: View.render_to_string(VillageView, "weapons-buy.html", %{equipped_weapon: equipped_weapon, char: char, equipment: weapons}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.purchase", payload, socket) do
    weapon_payload = payload["weapon_id"]

    weapon = Repo.get(Weapon, weapon_payload)
    char = Repo.get(Character, payload["char_id"])

    if weapon.cost > char.gold do
      push socket, "msg", %{
        opcode: "game.zone.village.weapons.purchase",
        message: View.render_to_string(VillageView, "weapons-purchase-broke.html", %{char: char, weapon: weapon}),
        actions: ["space"]
      }
    else
      char = %{char | gold: (char.gold - weapon.cost), weapon_id: weapon.id}
      changeset = Character.buy_weapon(%Character{id: payload["char_id"]}, %{gold: char.gold, weapon_id: char.weapon_id})
      Repo.update!(changeset)

      push socket, "msg", %{
        opcode: "game.zone.village.weapons.purchase",
        message: View.render_to_string(VillageView, "weapons-purchase-confirm.html", %{char: char, weapon: weapon}),
        actions: ["space"]
      }
    end
    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.sell.offer", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.sell.offer",
      message: View.render_to_string(VillageView, "weapons-sell-offer.html", %{}),
      actions: ["n", "c"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.sell.confirm", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.sell.confirm",
      message: View.render_to_string(VillageView, "weapons-sell-confirm.html", %{}),
      actions: ["space", "enter"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.armor.loiter",
      message: View.render_to_string(VillageView, "armor-loiter.html", %{}),
      actions: ["b", "s", "r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.buy", payload, socket) do
    char = Repo.get(Character, payload["char_id"])
    equipped_armor = Repo.get(Armor, char.armor_id)
    armor = Repo.all(Armor)

    push socket, "msg", %{
      equipment: armor,
      opcode: "game.zone.village.armor.buy",
      message: View.render_to_string(VillageView, "armor-purchase.html", %{equipped_armor: equipped_armor, char: char, equipment: armor}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.purchase", payload, socket) do

    armor_payload = payload["armor_id"]

    armor = Repo.get(Armor, armor_payload)
    char = Repo.get(Character, payload["char_id"])

    if armor.cost > char.gold do
      push socket, "msg", %{
        opcode: "game.zone.village.armor.purchase",
        message: View.render_to_string(VillageView, "armor-purchase-broke.html", %{char: char, armor: armor}),
        actions: ["space"]
      }
    else
      char = %{char | gold: (char.gold - armor.cost), armor_id: armor.id}
      changeset = Character.buy_armor(%Character{id: payload["char_id"]}, %{gold: char.gold, armor_id: armor.id})
      Repo.update!(changeset)

      push socket, "msg", %{
        opcode: "game.zone.village.armor.purchase",
        message: View.render_to_string(VillageView, "armor-purchase-confirm.html", %{char: char, armor: armor}),
        actions: ["space"]
      }
    end

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.sell.offer", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.armor.sell.offer",
      message: View.render_to_string(VillageView, "armor-sell-offer.html", %{}),
      actions: ["n", "c"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.sell.confirm", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.armor.sell.confirm",
      message: View.render_to_string(VillageView, "armor-sell-confirm.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.loiter",
      message: View.render_to_string(VillageView, "trainer-loiter.html", %{}),
      actions: ["q", "a", "v", "r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.question", payload, socket) do

    char = Repo.get(Character, payload["char_id"])
    next_level = Repo.get_by(Level, rank: (char.level + 1))
    master = Repo.get_by(Master, rank: char.level)
    push socket, "msg", %{
      opcode: "game.zone.village.trainer.question",
      message: View.render_to_string(VillageView, "trainer-question.html", %{
        master: master,
        next_level: next_level,
        char: char
      }),
      actions: ["space", "r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.challenge", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.challenge",
      message: View.render_to_string(VillageView, "trainer-challenge.html", %{}),
      actions: ["space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.lose", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.lose",
      message: View.render_to_string(VillageView, "trainer-lose.html", %{}),
      actions: ["space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.win", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.win",
      message: View.render_to_string(VillageView, "trainer-win.html", %{}),
      actions: ["space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.players.list", _, socket) do

    chars = Repo.all from(c in Character,
      join: w in Weapon, on: w.id == c.weapon_id,
      join: a in Armor, on: a.id == c.armor_id,
      join: k in Class, on: k.id == c.class_id,
      select: %{
        "id" => c.id,
        "name" => c.name,
        "level" => c.level,
        "gold" => c.gold,
        "is_alive" => c.is_alive,
        "experience" => c.experience,
        "armor" => a.name,
        "weapon" => w.name,
        "class" => k.name
      },
      order_by: [desc: c.experience],
      limit: 100)

    push socket, "msg", %{
      opcode: "game.zone.village.leaderboards",
      message: View.render_to_string(VillageView, "player-leaderboards.html", %{chars: chars}),
      actions: ["enter", "space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.news.read", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.news.read",
      message: View.render_to_string(VillageView, "news-read.html", %{}),
      actions: ["space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.loiter",
      message: View.render_to_string(VillageView, "inn-loiter.html", %{}),
      actions: ["c", "d", "f", "g", "t", "v", "h", "r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.violet", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.violet",
      message: View.render_to_string(VillageView, "inn-violet.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.room.ask", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.room.ask",
      message: View.render_to_string(VillageView, "inn-room-ask.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.bartender", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.bartender",
      message: View.render_to_string(VillageView, "inn-bartender.html", %{}),
      actions: []
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.stats", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.stats",
      message: View.render_to_string(VillageView, "inn-stats.html", %{}),
      actions: []
    }
    {:noreply, socket}
  end



  def handle_in("game.zone.village.inn.bard", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.bard",
      message: View.render_to_string(VillageView, "inn-bard.html", %{}),
      actions: []
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.messageboard", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.messageboard",
      message: View.render_to_string(VillageView, "inn-messageboard.html", %{}),
      actions: []
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.village.healer.loiter", payload, socket) do

    char = Repo.get(Character, payload["char_id"])
    missing_health = char.m_health - char.health

    push socket, "msg", %{
      opcode: "game.zone.village.healer.loiter",
      message: View.render_to_string(VillageView, "healer-loiter.html", %{char: char, missing_health: missing_health}),
      actions: ["h", "a", "r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.healer.heal-all", payload, socket) do

    char = Repo.get(Character, payload["id"])
    case char.health < char.m_health do
      true ->
        cost = round(round((char.m_health - char.health) * char.level))
        amount = round(char.m_health - char.health)
        gold = round(char.gold - round((char.m_health - char.health) * round(char.level + 3)))

        char = Character.healer_full(char, %{gold: gold, health: char.m_health})


        {:ok, delta} = Repo.update(char)
        IO.inspect delta
        push socket, "msg", %{
          opcode: "game.zone.village.healer.heal-all",
          message: View.render_to_string(VillageView, "healer-heal-all.html", %{amount: amount, cost: cost}),
          actions: ["space", "enter"]
        }
        push socket, "data", %{
          opcode: "game.client.character.update",
          payload: delta,
          system: "character",
        }
      false ->
        push socket, "msg", %{
          opcode: "game.zone.village.healer.heal-all",
          message: View.render_to_string(VillageView, "healer-heal-full.html", %{}),
          actions: ["space", "enter"]
        }
    end

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.fight.start", payload, socket) do

    encounter = Forest.spawn(payload["id"], payload["level"])
    push socket, "msg", %{
      opcode: "game.zone.village.trainer.fight",
      encounter: encounter,
      message: View.render_to_string(VillageView, "trainer-fight.html", encounter),
      actions: ["a", "r", "s"]
    }

    {:noreply, socket}
  end

  def handle_in('game.zone.village.trainer.fight', payload, socket) do
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
          gemroll = roll 20
          gemdrop = false
          gemsfound = roll 5
          case roll 20 do
            r when r >= 17 ->
              gemdrop = true
              char = %{char | gems: (char.gems + gemsfound),
              is_alive: true,
              experience: round(char.experience + mob.experience),
              gold: round(char.gold + mob.gold)}

            r when r < 17 ->
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


end

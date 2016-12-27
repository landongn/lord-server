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
      actions: ["q", "c", "v", "r"]
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

  def handle_in("game.zone.village.trainer.challenge", payload, socket) do

    char = Repo.get(Character, payload["char_id"])
    master = Repo.get_by(Master, rank: char.level)
    next_level = Repo.get_by(Level, rank: (char.level + 1))

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.challenge",
      message: View.render_to_string(VillageView, "trainer-challenge.html", %{char: char, next_level: next_level, master: master, char: char}),
      actions: ["d", "a", "r"]
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
      actions: ["v", "g", "b", "r"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.bartender.gems", payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.bartender.gems",
      message: View.render_to_string(VillageView, "inn-bartender-gems.html", %{}),
      actions: ["r", "b", "g", "n"]
    }
    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.bartender.gem-purchase", payload, socket) do

    kind = payload["gemtype"]
    char = Repo.get(Character, payload["char_id"])

    if char.gems <= 1 do
      push socket, "msg", %{
        opcode: "game.zone.village.inn.bartender.gem.fail",
        message: View.render_to_string(VillageView, "inn-bartender-gem-fail.html", %{}),
        actions: ["r"]
      }
    end

    case kind do
      "green" ->
        changeset = Character.buy_green_gem(%Character{id: char.id}, %{health: (char.health + 2),
          gems: (char.gems - 2)})
        Repo.update(changeset);
        push socket, "msg", %{
          opcode: "game.zone.village.inn.bartender.gem.done",
          message: View.render_to_string(VillageView, "inn-bartender-gem-green-imbibe.html", %{}),
          actions: ["space", "enter"]
        }
      "red" ->
        changeset = Character.buy_red_gem(%Character{id: char.id}, %{strength: (char.strength + 1),
          gems: (char.gems - 2)})
        Repo.update(changeset);
        push socket, "msg", %{
          opcode: "game.zone.village.inn.bartender.gem.done",
          message: View.render_to_string(VillageView, "inn-bartender-gem-red-imbibe.html", %{}),
          actions: ["space", "enter"]
        }
      "blue" ->
        changeset = Character.buy_blue_gem(%Character{id: char.id}, %{defense: (char.defense + 1),
          gems: (char.gems - 2)})
        Repo.update(changeset);
        push socket, "msg", %{
          opcode: "game.zone.village.inn.bartender.gem.done",
          message: View.render_to_string(VillageView, "inn-bartender-gem-blue-imbibe.html", %{}),
          actions: ["space", "enter"]
        }
    end

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

  def handle_in("game.zone.village.trainer.fight", payload, socket) do

    encounter = Forest.duel(payload["char_id"])
    push socket, "msg", %{
      opcode: "game.zone.village.trainer.fight",
      encounter: encounter,
      message: View.render_to_string(VillageView, "trainer-fight.html", encounter),
      actions: ["a", "r", "s"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.attack", payload, socket) do
    charId = payload["char_id"]

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
          level: mob.rank
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

          changeset = News.changeset(%News{}, %{posted_by: mob.name, body: "#{char.name} has defeated #{mob.name} in a duel! #{char.name} has become level #{char.level + 1}!"})
          Repo.insert!(changeset)

          new_level = Repo.get_by(Level, rank: char.level + 1)
          character = Repo.get(Character, char.id)

          changeset = Character.defeat_master(%Character{id: char.id}, %{
            level: new_level.rank,
            health: (character.m_health + new_level.health),
            m_health: (character.m_health + new_level.health),
            strength: (character.strength + new_level.str),
            defense: (character.defense + new_level.def),
            endurance: (character.endurance + new_level.endurance),
            mana: (character.mana + new_level.mana),
            reputation: (character.reputation + new_level.reputation)
          })

          Repo.update!(changeset)
          Logger.info "oh no, the mob has died!"
          push socket, "msg", %{
            opcode: "game.zone.village.trainer.win",
            fight: %{char: char, mob: mob, char_missed: missed_them, mob_missed: missed_me},
            message: View.render_to_string(VillageView, "trainer-win.html", %{char: char, mob: mob, damage_dealt: damage_dealt}),
            actions: ["space"]
          }

          Server.Endpoint.broadcast("zone", "chat", %{
            from: '',
            message: "#{char.name} has defeated #{mob.name}!",
            stamp: :os.system_time(:seconds),
            opcode: "game.zone.broadcast"
          })
        else

          if char.health <= 0 do
            # push death
            char = %{char | health: 1}

            Logger.info "oh no, the character died!"
            Forest.battle_report(char.id, %{char: char, mob: mob})

            changeset = Server.News.changeset(%Server.News{}, %{posted_by: mob.name, body: "#{mob.name} has defeated #{char.name} in a duel."})
            Repo.insert!(changeset)

            changeset = Character.master_fail(%Character{id: char.id}, %{
              health: char.health,
            })
            Repo.update!(changeset)

            push socket, "msg", %{
              opcode: "game.zone.village.trainer.fail",
              message: View.render_to_string(VillageView, "trainer-lose.html", %{char: char, mob: mob, retaliation_suffered: retaliation_suffered}),
              actions: ["space"],
              fight: %{char: char, mob: mob}
            }

            Server.Endpoint.broadcast("zone", "chat", %{
              from: '',
              message: "#{mob.name} has defeated #{char.name} in a duel!",
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
              opcode: "game.zone.village.trainer.round",
              fight: updatedFight,
              message: View.render_to_string(VillageView, "trainer-attack.html", updatedFight),
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

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

    push socket, "msg", %{
      opcode: "game.zone.village.stats",
      message: View.render_to_string(VillageView, "stats.html", %{
        char: char,
        weapon: wep,
        armor: armor,
        class: class
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
      opcode: "game.zone.village.mail",
      message: View.render_to_string(VillageView, "trainer-loiter.html", %{}),
      actions: ["q", "a", "v", "r"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.talk", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.talk",
      message: View.render_to_string(VillageView, "trainer-talk.html", %{}),
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

  def handle_in("game.zone.village.trainer.defeat", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.defeat",
      message: View.render_to_string(VillageView, "trainer-defeat.html", %{}),
      actions: ["space"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.fail", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.fail",
      message: View.render_to_string(VillageView, "trainer-fail.html", %{}),
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



end

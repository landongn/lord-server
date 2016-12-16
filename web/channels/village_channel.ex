defmodule Server.VillageChannel do
  use Server.Web, :channel

  alias Phoenix.View
  alias Server.VillageView
  alias Server.Character
  alias Server.Repo

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
      opcode: "game.zone.village.loiter",
      message: View.render_to_string(VillageView, "players-online.html", %{}),
      actions: ["f", "k", "h", "i", "y", "w", "c", "p", "s", "a", "v", "t", "l", "d", "o", "q"]
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.mail", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.mail",
      message: View.render_to_string(VillageView, "write-mail.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.loiter",
      message: View.render_to_string(VillageView, "weapons-loiter.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.buy", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.mail",
      message: View.render_to_string(VillageView, "weapons-buy.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.purchase", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.purchase",
      message: View.render_to_string(VillageView, "weapons-purchase.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.sell.offer", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.sell.offer",
      message: View.render_to_string(VillageView, "weapons-sell-offer.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.weapons.sell.confirm", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.weapons.sell.confirm",
      message: View.render_to_string(VillageView, "weapons-sell-confirm.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.armor.loiter",
      message: View.render_to_string(VillageView, "armor-loiter.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.buy", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.mail",
      message: View.render_to_string(VillageView, "armor-buy.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.purchase", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.armor.purchase",
      message: View.render_to_string(VillageView, "armor-purchase.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.armor.sell.offer", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.armor.sell.offer",
      message: View.render_to_string(VillageView, "armor-sell-offer.html", %{}),
      actions: []
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
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.talk", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.talk",
      message: View.render_to_string(VillageView, "trainer-talk.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.challenge", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.challenge",
      message: View.render_to_string(VillageView, "trainer-challenge.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.defeat", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.defeat",
      message: View.render_to_string(VillageView, "trainer-defeat.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.trainer.fail", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.trainer.fail",
      message: View.render_to_string(VillageView, "trainer-fail.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.leaderboards", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.leaderboards",
      message: View.render_to_string(VillageView, "players-leaderboards.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.news.read", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.news.read",
      message: View.render_to_string(VillageView, "news-read.html", %{}),
      actions: []
    }

    {:noreply, socket}
  end

  def handle_in("game.zone.village.inn.loiter", _, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.inn.loiter",
      message: View.render_to_string(VillageView, "inn-loiter.html", %{}),
      actions: []
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

  def handle_in("game.zone.village.healer.loiter", _payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.healer.loiter",
      message: View.render_to_string(VillageView, "healer-loiter.html", %{}),
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
        gold = round(char.gold - round((char.m_health - char.health) * char.level))

        char = Character.healer_full(char, %{gold: gold, health: char.m_health})


        {:ok, delta} = Repo.update(char)
        IO.inspect delta
        push socket, "msg", %{
          opcode: "game.zone.village.healer.heal-all",
          message: View.render_to_string(VillageView, "healer-heal-all.html", %{amount: amount, cost: cost}),
          actions: ["space"]
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

  def handle_in("game.zone.village.healer.loiter", _payload, socket) do

    push socket, "msg", %{
      opcode: "game.zone.village.healer.heal-all",
      message: View.render_to_string(VillageView, "healer-heal-all.html", %{}),
      actions: ["h", "a", "r"]
    }

    {:noreply, socket}
  end

end

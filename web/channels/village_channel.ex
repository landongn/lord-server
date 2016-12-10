defmodule Server.VillageChannel do
  use Server.Web, :channel

  alias Phoenix.View
  alias Server.VillageView

  def join("village", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
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



  # Add authorization logic here as required.
  defp authorized?(__) do
    true
  end
end

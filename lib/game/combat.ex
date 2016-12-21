defmodule Server.Combat do
  require Logger

  def roll(sides) do
    case sides do
      5 ->
        Enum.random([1, 2, 3, 4, 5])
      10 ->
        Enum.random([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      20 ->
        Enum.random([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
      luck ->
        Enum.max([round(:rand.uniform() * 100), round(:rand.uniform() * 100), round(:rand.uniform() * 100), round(:rand.uniform() * 100), round(:rand.uniform() * 100), round(:rand.uniform() * 100)])
      100 ->
        round(:rand.uniform() * 100)
    end
  end

  def hit_chance(level_difference) do
    hit_chance = roll 100
    cond do
      level_difference >= 4 ->
        hit_chance = hit_chance + -40
      level_difference == 3 ->
        hit_chance = hit_chance + -30
      level_difference == 2 ->
        hit_chance = hit_chance + -20
      level_difference == 1 ->
        hit_chance = hit_chance + -10
      level_difference == 0 ->
        hit_chance = hit_chance
      level_difference == -1 ->
        hit_chance = hit_chance + 10
      level_difference == -2 ->
        hit_chance = hit_chance + 20
      level_difference == -3 ->
        hit_chance = hit_chance + 30
      level_difference >= -4 ->
        hit_chance = hit_chance + 40
    end
    Logger.info "combat.round: hit chance calculated #{hit_chance}"
    hit_chance
  end

  def armor_class(_attacker, defender) do
    armor_class = defender.level * round((defender.defense + defender.armor))
    Logger.info "combat.armor_class: defender armor class is: #{armor_class}"
    armor_class
  end



  def attack(attacker, defender) do
    to_hit = hit_chance(defender.level - attacker.level)
    Logger.info "combat.attack: to_hit #{round(to_hit / 100)}"
    ac = armor_class(attacker, defender)
    Logger.info "combat.attack: ap no to_hit #{round((attacker.strength + attacker.weapon) * attacker.level)}"

    attack_power = round((attacker.strength + attacker.weapon) ) * round(to_hit * 0.025)
    Logger.info "combat.attack: attack_power #{attack_power}"

    damage_inflicted = attack_power - ac
    Logger.info "combat.attack: inflicted #{damage_inflicted}"

    if damage_inflicted <= 0 do
      damage_inflicted = 0
    end

    defender = %{defender | health: (defender.health - damage_inflicted)}

    {attacker, defender, damage_inflicted}
  end
end
defmodule Game.Forest do
  use GenServer

  require Logger

  alias Server.Repo
  alias Server.Character
  alias Server.Entity

  def start_link(initial_state) do
   GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @doc """
  returns a `value` for a given `key`, within the root of the map.
  """
  def lookup(name) do
    GenServer.call(__MODULE__, {:lookup, name})
  end

  @doc """
  fired when player `char` enters the forest.
  """
  def enter(char) do
    GenServer.call(__MODULE__, {:enter, char})
  end

  @doc """
  fired when a player looks for a fight in the forest.
  """
  def spawn(name, level) do
    Logger.info "all the args #{inspect name} #{inspect level}"
    GenServer.call(__MODULE__, {:spawn, name, level})
  end

  @doc """
  fired when a fight has finished.
  """
  def battle_report(name, encounter) do
    GenServer.call(__MODULE__, {:attack, name, encounter})
  end

  @doc """
  fired each combat attack
  """
  def attack(name, encounter) do
    GenServer.call(__MODULE__, {:attack, name, encounter})
  end

  ## Server Callbacks

  def handle_call({:other_players}, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:battle_report, name, encounter}, _from, state) do
    new_state = Map.put(state, name, encounter)
    {:reply, new_state, new_state}
  end

  def handle_call({:attack, name, encounter}, _from, state) do
    new_state = Map.put(state, name, encounter)
    {:reply, new_state, new_state}
  end

  def handle_call({:leave, char_id}, _from, state) do
    {:reply, Map.pop(:presence, char_id), state}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state, name), state}
  end

  def handle_call({:enter, char}, _from, state) do
    #
    {:reply, state, state}
  end

  @doc """
  spawns a monster for a given `name` and `level`, and stores it until dead/runs away
  """
  def handle_call({:spawn, name, level}, _from, state) do

    min = level - 1
    max = level + 5
    choices = Repo.all Entity,
      select: [:name, :level, :gold, :experience, :armor, :weapon, :health, :defense,
               :s_hit, :s_atk, :s_die, :s_miss],
      where: :level >= min,
      where: :level <= max

    mob = Enum.random(choices)
    character = Repo.get_by Character, name: name
    encounter = %{
        mob: mob,
        char: character
    }

    Logger.info "spawning mob: #{mob.name}"
    new_state = Map.put(state, name, encounter)
    {:reply, encounter, new_state}
  end
end
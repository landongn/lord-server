defmodule Game.Forest do
  use GenServer

  require Logger
  alias Server.Master
  alias Server.Repo
  alias Server.Character
  alias Server.Entity
  import Ecto.Query
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
  def spawn(id, level) do
    Logger.info "all the args #{inspect id} #{inspect level}"
    GenServer.call(__MODULE__, {:spawn, id, level})
  end

  def duel(id) do
    Logger.info "starting player with master"
    GenServer.call(__MODULE__, {:duel, id})
  end

  @doc """
  fired when a fight has finished.
  """
  def battle_report(id, encounter) do
    GenServer.call(__MODULE__, {:attack, id, encounter})
  end

  @doc """
  fired each combat attack
  """
  def attack(id, encounter) do
    GenServer.call(__MODULE__, {:attack, id, encounter})
  end

  ## Server Callbacks

  def handle_call({:other_players}, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:battle_report, id, encounter}, _from, state) do
    new_state = Map.put(state, id, encounter)
    {:reply, new_state, new_state}
  end

  def handle_call({:attack, id, encounter}, _from, state) do
    new_state = Map.put(state, id, encounter)
    {:reply, new_state, new_state}
  end

  def handle_call({:leave, id}, _from, state) do
    {:reply, Map.pop(:presence, id), state}
  end

  def handle_call({:lookup, id}, _from, state) do
    {:reply, Map.fetch(state, id), state}
  end

  def handle_call({:enter, char}, _from, state) do
    #
    {:reply, state, state}
  end


  def handle_call({:duel, id}, _from, state) do
    character = Repo.get Character, id
    duelist = Repo.get_by Master, rank: character.level

    encounter = %{
      char: character,
      mob: duelist
    }

    new_state = Map.put(state, id, encounter)
    {:reply, encounter, new_state}

  end

  @doc """
  spawns a monster for a given `name` and `level`, and stores it until dead/runs away
  """
  def handle_call({:spawn, id, level}, _from, state) do

    character = Repo.get_by Character, id: id

    choices = Repo.all from e in Entity,
      select: [:name, :level, :gold, :experience, :armor, :weapon, :health, :defense,
               :s_hit, :s_atk, :s_die, :s_miss],
      where: e.level == ^character.level

    mob = Enum.random(choices)

    encounter = %{
        mob: mob,
        char: character
    }

    Logger.info "spawning mob: #{mob.name}"
    new_state = Map.put(state, id, encounter)
    {:reply, encounter, new_state}
  end
end
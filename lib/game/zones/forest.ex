defmodule Game.Forest do
  use GenServer

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
  def spawn(id, name, token, level) do
    GenServer.call(__MODULE__, {:spawn, id, name, token, level})
  end

  @doc """
  fired when a fight has finished.
  """
  def battle_result(session_hash, character_id) do
    GenServer.call(__MODULE__, {:round, session_hash, character_id})
  end

  @doc """
  fired each combat round
  """
  def round(session_hash, command) do
    GenServer.call(__MODULE__, {:round, session_hash, command})
  end

  ## Server Callbacks

  def handle_call({:other_players}, _from, state) do
    {:reply, Map.get(state, :presence), state}
  end

  def handle_call({:round, session_hash, _command}, _from, state) do
    {:reply, Map.get(:encounters, session_hash)}
  end

  def handle_call({:leave, char_id}, _from, state) do
    {:reply, Map.pop(:presence, char_id), state}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state, name), state}
  end

  def handle_call({:enter, char}, _from, state) do
    new_state = case Map.get(state.presence, char) do
      nil ->
        Map.put(state, :presence, [char])
      roster ->
        Kernel.put_in(state.presence, Enum.uniq([char | roster]))
    end
    {:reply, new_state.presence, new_state}
  end

  @doc """
  spawns a monster for a given `name` and `level`, and stores it until dead/runs away
  """
  def handle_call({:spawn, id, name, token, level}, _from, state) do

    min = level - 1
    max = level + 5
    choices = Repo.all Entity,
      select: [:name, :level, :gold, :experience, :armor, :weapon, :health, :defense,
               :s_hit, :s_atk, :s_die, :s_miss],
      where: :level >= min,
      where: :level <= max

    mob = Enum.random(choices)

    encounter = %{
        mob: mob,
        player: Repo.one(Character, id)
    }

    Kernel.put_in(state.encounters, token, encounter)
    {:reply, encounter, state}
  end
end
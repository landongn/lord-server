defmodule Game.Forest do

    @doc """
    Creates the forest state container
    """
    def start_link do
        Agent.start_link(fn -> %{} end)
    end

    @doc """
    gets a player record who's currently in the `forest` by `key`
    """
    def get(forest, key) do
        Agent.get(forest, &Map.get(&1, key))
    end

    @doc """
    puts a player `value` (Character{}) into the `forest` via `key`
    """
    def put(forest, key, value) do
        Agent.update(forest, &Map.put(&1, key, value))
    end
end
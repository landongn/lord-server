defmodule Server.LevelTest do
  use Server.ModelCase

  alias Server.Level

  @valid_attrs %{class_id: 42, def: 42, endurance: 42, health: 42, minimum: 42, rank: 42, str: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Level.changeset(%Level{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Level.changeset(%Level{}, @invalid_attrs)
    refute changeset.valid?
  end
end

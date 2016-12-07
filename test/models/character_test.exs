defmodule Server.CharacterTest do
  use Server.ModelCase

  alias Server.Character

  @valid_attrs %{attractiveness: 42, defense: 42, experience: 42, gems: 42, gold: 42, health: 42, is_admin: true, is_alive: true, level: 42, married: true, name: "some content", sex: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Character.changeset(%Character{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Character.changeset(%Character{}, @invalid_attrs)
    refute changeset.valid?
  end
end

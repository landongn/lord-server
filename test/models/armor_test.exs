defmodule Server.ArmorTest do
  use Server.ModelCase

  alias Server.Armor

  @valid_attrs %{cost: 42, defense: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Armor.changeset(%Armor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Armor.changeset(%Armor{}, @invalid_attrs)
    refute changeset.valid?
  end
end

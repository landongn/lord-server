defmodule Server.WeaponTest do
  use Server.ModelCase

  alias Server.Weapon

  @valid_attrs %{cost: 42, damage: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Weapon.changeset(%Weapon{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Weapon.changeset(%Weapon{}, @invalid_attrs)
    refute changeset.valid?
  end
end

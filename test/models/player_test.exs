defmodule Server.PlayerTest do
  use Server.ModelCase

  alias Server.Player

  @valid_attrs %{challenge: "some content", email: "some content", experience: 42, name: "some content", secret: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Player.changeset(%Player{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Player.changeset(%Player{}, @invalid_attrs)
    refute changeset.valid?
  end
end

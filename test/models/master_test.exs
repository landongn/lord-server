defmodule Server.MasterTest do
  use Server.ModelCase

  alias Server.Master

  @valid_attrs %{armor: 42, challenge_message: "some content", damage: 42, defense: 42, master_defeat: "some content", name: "some content", player_defeat: "some content", rank: 42, s_att: "some content", s_die: "some content", s_hit: "some content", s_miss: "some content", strength: 42, talk_message: "some content", weapon: "some content", welcome_message: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Master.changeset(%Master{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Master.changeset(%Master{}, @invalid_attrs)
    refute changeset.valid?
  end
end

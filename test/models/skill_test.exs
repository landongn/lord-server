defmodule Server.SkillTest do
  use Server.ModelCase

  alias Server.Skill

  @valid_attrs %{attack_message: "some content", class_id: 42, damage_modifier: 42, mana_cost: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Skill.changeset(%Skill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Skill.changeset(%Skill{}, @invalid_attrs)
    refute changeset.valid?
  end
end

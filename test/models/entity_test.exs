defmodule Server.EntityTest do
  use Server.ModelCase

  alias Server.Entity

  @valid_attrs %{experience: 42, gold: 42, is_vendor: true, level: 42, name: "some content", sex: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entity.changeset(%Entity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entity.changeset(%Entity{}, @invalid_attrs)
    refute changeset.valid?
  end
end

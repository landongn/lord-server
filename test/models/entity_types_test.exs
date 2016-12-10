defmodule Server.EntityTypesTest do
  use Server.ModelCase

  alias Server.EntityTypes

  @valid_attrs %{art_url: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = EntityTypes.changeset(%EntityTypes{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = EntityTypes.changeset(%EntityTypes{}, @invalid_attrs)
    refute changeset.valid?
  end
end

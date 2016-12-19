defmodule Server.UpdateTest do
  use Server.ModelCase

  alias Server.Update

  @valid_attrs %{body: "some content", posted_by: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Update.changeset(%Update{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Update.changeset(%Update{}, @invalid_attrs)
    refute changeset.valid?
  end
end

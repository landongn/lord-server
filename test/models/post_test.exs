defmodule Server.PostTest do
  use Server.ModelCase

  alias Server.Post

  @valid_attrs %{body: "some content", location: 42, posted_by: "some content", reply_to: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end

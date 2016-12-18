defmodule Server.UpdateControllerTest do
  use Server.ConnCase

  alias Server.Update
  @valid_attrs %{body: "some content", posted_by: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, update_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing updates"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, update_path(conn, :new)
    assert html_response(conn, 200) =~ "New update"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, update_path(conn, :create), update: @valid_attrs
    assert redirected_to(conn) == update_path(conn, :index)
    assert Repo.get_by(Update, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, update_path(conn, :create), update: @invalid_attrs
    assert html_response(conn, 200) =~ "New update"
  end

  test "shows chosen resource", %{conn: conn} do
    update = Repo.insert! %Update{}
    conn = get conn, update_path(conn, :show, update)
    assert html_response(conn, 200) =~ "Show update"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, update_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    update = Repo.insert! %Update{}
    conn = get conn, update_path(conn, :edit, update)
    assert html_response(conn, 200) =~ "Edit update"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    update = Repo.insert! %Update{}
    conn = put conn, update_path(conn, :update, update), update: @valid_attrs
    assert redirected_to(conn) == update_path(conn, :show, update)
    assert Repo.get_by(Update, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    update = Repo.insert! %Update{}
    conn = put conn, update_path(conn, :update, update), update: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit update"
  end

  test "deletes chosen resource", %{conn: conn} do
    update = Repo.insert! %Update{}
    conn = delete conn, update_path(conn, :delete, update)
    assert redirected_to(conn) == update_path(conn, :index)
    refute Repo.get(Update, update.id)
  end
end

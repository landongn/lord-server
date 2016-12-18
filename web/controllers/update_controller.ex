defmodule Server.UpdateController do
  use Server.Web, :controller

  alias Server.Update

  def index(conn, _params) do
    updates = Repo.all(Update)
    render(conn, "index.html", updates: updates)
  end

  def new(conn, _params) do
    changeset = Update.changeset(%Update{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"update" => update_params}) do
    changeset = Update.changeset(%Update{}, update_params)

    case Repo.insert(changeset) do
      {:ok, _update} ->
        conn
        |> put_flash(:info, "Update created successfully.")
        |> redirect(to: update_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    update = Repo.get!(Update, id)
    render(conn, "show.html", update: update)
  end

  def edit(conn, %{"id" => id}) do
    update = Repo.get!(Update, id)
    changeset = Update.changeset(update)
    render(conn, "edit.html", update: update, changeset: changeset)
  end

  def update(conn, %{"id" => id, "update" => update_params}) do
    update = Repo.get!(Update, id)
    changeset = Update.changeset(update, update_params)

    case Repo.update(changeset) do
      {:ok, update} ->
        conn
        |> put_flash(:info, "Update updated successfully.")
        |> redirect(to: update_path(conn, :show, update))
      {:error, changeset} ->
        render(conn, "edit.html", update: update, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    update = Repo.get!(Update, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(update)

    conn
    |> put_flash(:info, "Update deleted successfully.")
    |> redirect(to: update_path(conn, :index))
  end
end

defmodule Server.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :location, :integer
      add :posted_by, :string
      add :body, :text
      add :reply_to, :integer

      timestamps()
    end

  end
end

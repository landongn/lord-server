defmodule Server.Repo.Migrations.CreateNews do
  use Ecto.Migration

  def change do
    create table(:news) do
      add :body, :string
      add :posted_by, :string

      timestamps()
    end
    create index(:news, [:posted_by])

  end
end

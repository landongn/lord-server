defmodule Server.Repo.Migrations.CreateUpdate do
  use Ecto.Migration

  def change do
    create table(:updates) do
      add :posted_by, :string
      add :body, :string

      timestamps()
    end

  end
end

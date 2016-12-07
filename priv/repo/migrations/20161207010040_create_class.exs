defmodule Server.Repo.Migrations.CreateClass do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end

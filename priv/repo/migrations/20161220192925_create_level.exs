defmodule Server.Repo.Migrations.CreateLevel do
  use Ecto.Migration

  def change do
    create table(:levels) do
      add :minimum, :integer
      add :class_id, :integer
      add :str, :integer
      add :def, :integer
      add :health, :integer
      add :endurance, :integer
      add :rank, :integer

      timestamps()
    end

  end
end

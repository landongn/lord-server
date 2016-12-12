defmodule Server.Repo.Migrations.AddMissingEntityData do
  use Ecto.Migration

  def change do
    alter table(:entities) do
      add :damage, :integer
      add :armor_value, :integer
    end
  end
end

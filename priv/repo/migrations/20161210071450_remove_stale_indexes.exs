defmodule Server.Repo.Migrations.RemoveStaleIndexes do
  use Ecto.Migration

  def change do
    drop index(:characters, [:armor_id])
    drop index(:characters, [:weapon_id])
    drop index(:characters, [:class])
    drop index(:characters, [:player_id])
  end
end

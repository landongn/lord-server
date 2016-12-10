defmodule Server.Repo.Migrations.UpdateEntitiesDropIds do
  use Ecto.Migration

  def up do
    alter table(:entities) do
        remove :armor_id
        remove :weapon_id
        add :s_hit, :string
        add :s_die, :string
        add :s_atk, :string
        add :s_miss, :string
        add :armor, :string
        add :weapon, :string
    end
  end

  def down do
    alter table(:entities) do
        add :armor_id, :integer
        add :weapon_id, :integer

        remove :armor
        remove :weapon
    end
  end
end

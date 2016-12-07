defmodule Server.Repo.Migrations.CreateEntity do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :level, :integer
      add :gold, :integer
      add :experience, :integer
      add :sex, :string
      add :is_vendor, :boolean, default: false, null: false
      add :armor_id, references(:armor, on_delete: :nothing)
      add :weapon_id, references(:weapons, on_delete: :nothing)

      timestamps()
    end
    create index(:entities, [:armor_id])
    create index(:entities, [:weapon_id])

  end
end

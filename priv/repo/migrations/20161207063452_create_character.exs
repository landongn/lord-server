defmodule Server.Repo.Migrations.CreateCharacter do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :level, :integer
      add :experience, :integer
      add :gold, :integer
      add :gems, :integer
      add :is_alive, :boolean, default: false, null: false
      add :health, :integer
      add :defense, :integer
      add :is_admin, :boolean, default: false, null: false
      add :sex, :string
      add :attractiveness, :integer
      add :married, :boolean, default: false, null: false
      add :armor_id, references(:armor, on_delete: :nothing)
      add :weapon_id, references(:weapons, on_delete: :nothing)
      add :class, references(:classes, on_delete: :nothing)

      timestamps()
    end
    create index(:characters, [:armor_id])
    create index(:characters, [:weapon_id])
    create index(:characters, [:class])

  end
end

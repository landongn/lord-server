defmodule Server.Repo.Migrations.UpdateEntityFieldsForBehaviors do
  use Ecto.Migration

  def change do
    alter table(:entities) do
      add :strength, :integer, default: 10
      add :endurance, :integer, default: 10
      add :attractiveness, :integer, default: 0
      add :entity_type, :integer, default: 0
      add :reputation, :integer, default: 0
      add :luck, :integer, default: 0
    end

    alter table(:characters) do
      add :strength, :integer, default: 1
      add :endurance, :integer, default: 10
      add :luck, :integer, default: 0
      add :reputation, :integer, default: 0

    end
  end
end

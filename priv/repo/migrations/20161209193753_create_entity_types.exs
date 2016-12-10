defmodule Server.Repo.Migrations.CreateEntityTypes do
  use Ecto.Migration

  def change do
    create table(:entity_types) do
      add :name, :string
      add :can_flee, :boolean, default: false
      add :invuln, :boolean, default: false
      add :description, :string, default: nil
      add :player_kills_to_date, :integer, default: 0
      add :player_murders_to_date, :integer, default: 0
      add :gold_invested_into_econ, :integer, default: 0

      timestamps()
    end

  end
end

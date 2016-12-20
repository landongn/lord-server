defmodule Server.Repo.Migrations.CreateSkill do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string
      add :attack_message, :string
      add :class_id, :integer
      add :damage_modifier, :integer
      add :mana_cost, :integer

      timestamps()
    end

  end
end

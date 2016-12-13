defmodule Server.Repo.Migrations.AddMaxHealth do
  use Ecto.Migration

  def change do
    alter table(:characters) do
        add :m_health, :integer, default: 25
        add :m_mana, :integer, default: 25
    end

    alter table(:entities) do
        add :m_health, :integer, default: 25
        add :m_mana, :integer, default: 25
    end
  end
end

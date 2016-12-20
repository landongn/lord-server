defmodule Server.Repo.Migrations.Fixmasters do
  use Ecto.Migration

  def change do
    alter table(:masters) do
      add :health, :integer, default: 0
      add :m_health, :integer, default: 0
    end
  end
end

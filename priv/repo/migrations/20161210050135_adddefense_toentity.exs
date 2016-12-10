defmodule Server.Repo.Migrations.AdddefenseToentity do
  use Ecto.Migration

  def change do
    alter table(:entities) do
        add :defense, :integer
        add :health, :integer
    end
  end
end

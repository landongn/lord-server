defmodule Server.Repo.Migrations.AddManaToLevel do
  use Ecto.Migration

  def change do
    alter table(:levels) do
      add :mana, :integer, default: 10
      add :reputation, :integer, default: 1
    end
  end
end

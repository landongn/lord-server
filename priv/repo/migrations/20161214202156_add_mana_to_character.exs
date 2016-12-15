defmodule Server.Repo.Migrations.AddManaToCharacter do
  use Ecto.Migration

  def change do
    alter table(:characters) do
        add :mana, :integer, default: 20
    end
  end
end

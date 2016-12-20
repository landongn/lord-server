defmodule Server.Repo.Migrations.AddBank do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :banked_gold, :integer, default: 0
    end
  end
end

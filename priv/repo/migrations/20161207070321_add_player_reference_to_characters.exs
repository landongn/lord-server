defmodule Server.Repo.Migrations.AddPlayerReferenceToCharacters do
  use Ecto.Migration

  def change do
    alter table(:characters) do
        add :player_id, references(:players, on_delete: :nothing)
    end

    create index(:characters, [:player_id])
  end
end

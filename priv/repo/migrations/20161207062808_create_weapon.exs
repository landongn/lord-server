defmodule Server.Repo.Migrations.CreateWeapon do
  use Ecto.Migration

  def change do
    create table(:weapons) do
      add :name, :string
      add :damage, :integer
      add :cost, :integer

      timestamps()
    end

  end
end

defmodule Server.Repo.Migrations.CreateArmor do
  use Ecto.Migration

  def change do
    create table(:armor) do
      add :name, :string
      add :defense, :integer
      add :cost, :integer

      timestamps()
    end

  end
end

defmodule Server.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :experience, :integer
      add :secret, :string
      add :challenge, :string
      add :email, :string

      timestamps()
    end

  end
end

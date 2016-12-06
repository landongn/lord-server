defmodule Server.Repo.Migrations.ChangePasswordFieldForPlayers do
  use Ecto.Migration

  def change do
    rename table(:players), :challenge, to: :password
  end
end

defmodule Server.Repo.Migrations.Playeradmin do
  use Ecto.Migration

  def change do
    alter table(:players) do
        add :is_admin, :boolean, default: false
        add :is_banned, :boolean, default: false
        add :verified_account, :boolean, default: false
        add :premium_member, :boolean, default: false
    end
  end
end

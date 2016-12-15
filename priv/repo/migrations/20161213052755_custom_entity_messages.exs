defmodule Server.Repo.Migrations.CustomEntityMessages do
  use Ecto.Migration

  def change do
    alter table(:entities) do
        add :death_msg, :text
        add :kill_msg, :text
    end
  end
end

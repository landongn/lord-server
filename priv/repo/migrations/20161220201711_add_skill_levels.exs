defmodule Server.Repo.Migrations.AddSkillLevels do
  use Ecto.Migration

  def change do
    alter table(:skills) do
        add :rank, :integer
    end
  end
end

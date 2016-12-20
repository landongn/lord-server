defmodule Server.Repo.Migrations.CreateMaster do
  use Ecto.Migration

  def change do
    create table(:masters) do
      add :rank, :integer
      add :welcome_message, :string
      add :talk_message, :string
      add :challenge_message, :string
      add :player_defeat, :text
      add :master_defeat, :string
      add :name, :string
      add :weapon, :string
      add :armor, :integer
      add :strength, :integer
      add :defense, :integer
      add :damage, :integer
      add :s_hit, :string
      add :s_att, :string
      add :s_miss, :string
      add :s_die, :string

      timestamps()
    end

  end
end

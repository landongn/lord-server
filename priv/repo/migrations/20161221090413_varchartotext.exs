defmodule Server.Repo.Migrations.Varchartotext do
  use Ecto.Migration

  def change do
    alter table(:updates) do
      modify :body, :text
      add :title, :string
    end
  end
end

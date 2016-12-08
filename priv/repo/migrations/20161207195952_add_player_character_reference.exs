defmodule Server.Repo.Migrations.AddPlayerCharacterReference do
  use Ecto.Migration

  def change do
    rename table(:characters), :class, to: :class_id
  end
end

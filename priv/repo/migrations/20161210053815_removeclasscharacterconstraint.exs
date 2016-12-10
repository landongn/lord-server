defmodule Server.Repo.Migrations.Removeclasscharacterconstraint do
  use Ecto.Migration

  def change do
    drop constraint(:characters, "characters_class_fkey")
  end
end

defmodule Server.Repo.Migrations.Droprelationstocharacter do
  use Ecto.Migration

  def change do
    drop constraint(:characters, "characters_armor_id_fkey")
    drop constraint(:characters, "characters_weapon_id_fkey")
    drop constraint(:characters, "characters_player_id_fkey")
  end
end

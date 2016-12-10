# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Server.Repo.insert!(%Server.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Server.Repo


# Create Armor Tables
Repo.delete_all Server.Armor
Repo.insert!(%Server.Armor{"name": "Nothing", "cost": 0, "defense": 0})
Repo.insert!(%Server.Armor{"name": "Coat", "cost": 200, "defense": 1})
Repo.insert!(%Server.Armor{"name": "Heavy Coat", "cost": 1000, "defense": 2})
Repo.insert!(%Server.Armor{"name": "Leather Vest", "cost": 3000, "defense": 4})
Repo.insert!(%Server.Armor{"name": "Bronze Armor", "cost": 10000, "defense": 8})
Repo.insert!(%Server.Armor{"name": "Iron Armor", "cost": 30000, "defense": 16})
Repo.insert!(%Server.Armor{"name": "Graphite Armor", "cost": 60000, "defense": 20})
Repo.insert!(%Server.Armor{"name": "Edrick's Armor", "cost": 150000, "defense": 28})
Repo.insert!(%Server.Armor{"name": "Armor of Death", "cost": 200000, "defense": 40})
Repo.insert!(%Server.Armor{"name": "Able's Armor", "cost": 400000, "defense": 48})
Repo.insert!(%Server.Armor{"name": "Full Body Armor", "cost": 1000000, "defense": 52})
Repo.insert!(%Server.Armor{"name": "Blood Armor", "cost": 4000000, "defense": 64})
Repo.insert!(%Server.Armor{"name": "Magic Ward", "cost": 10000000, "defense": 78})
Repo.insert!(%Server.Armor{"name": "Belar's Mail", "cost": 40000000, "defense": 90})
Repo.insert!(%Server.Armor{"name": "Golden Armor", "cost": 100000000, "defense": 120})
Repo.insert!(%Server.Armor{"name": "Armor of Lore", "cost": 400000000, "defense": 200})

# Create Weapon Tables
Repo.delete_all Server.Weapon
Repo.insert!(%Server.Weapon{"name": "Nothing", "cost": 0, "damage": 0})
Repo.insert!(%Server.Weapon{"name": "Stick", "cost": 200, "damage": 1})
Repo.insert!(%Server.Weapon{"name": "Dagger", "cost": 1000, "damage": 2})
Repo.insert!(%Server.Weapon{"name": "Short Sword", "cost": 3000, "damage": 4})
Repo.insert!(%Server.Weapon{"name": "Long Sword", "cost": 10000, "damage": 8})
Repo.insert!(%Server.Weapon{"name": "Huge Axe", "cost": 30000, "damage": 16})
Repo.insert!(%Server.Weapon{"name": "Bone Cruncher", "cost": 60000, "damage": 20})
Repo.insert!(%Server.Weapon{"name": "Twin Swords", "cost": 150000, "damage": 28})
Repo.insert!(%Server.Weapon{"name": "Power Axe", "cost": 200000, "damage": 40})
Repo.insert!(%Server.Weapon{"name": "Able's Sword", "cost": 400000, "damage": 48})
Repo.insert!(%Server.Weapon{"name": "Wan's Weapon", "cost": 1000000, "damage": 52})
Repo.insert!(%Server.Weapon{"name": "Spear of Gold", "cost": 4000000, "damage": 64})
Repo.insert!(%Server.Weapon{"name": "Crystal Shank", "cost": 10000000, "damage": 78})
Repo.insert!(%Server.Weapon{"name": "Niras's Teeth", "cost": 40000000, "damage": 90})
Repo.insert!(%Server.Weapon{"name": "Blood Sword", "cost": 100000000, "damage": 120})
Repo.insert!(%Server.Weapon{"name": "Death Sword", "cost": 400000000, "damage": 200})


#Fill out the Entity Map for Monsters, etc
Repo.delete_all Server.EntityTypes
# Repo.insert!(%Server.EntityTypes{"name": "Old Man"})

Repo.delete_all Server.Entity
# Repo.insert!(%Server.Entities{name: "Rude Boy", health: 25})
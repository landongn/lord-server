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
Repo.insert!(%Server.Armor{id: 1, "name": "Nothing", "cost": 0, "defense": 0})
Repo.insert!(%Server.Armor{id: 2, "name": "Coat", "cost": 200, "defense": 1})
Repo.insert!(%Server.Armor{id: 3, "name": "Heavy Coat", "cost": 1000, "defense": 2})
Repo.insert!(%Server.Armor{id: 4, "name": "Leather Vest", "cost": 3000, "defense": 4})
Repo.insert!(%Server.Armor{id: 5, "name": "Bronze Armor", "cost": 10000, "defense": 8})
Repo.insert!(%Server.Armor{id: 6, "name": "Iron Armor", "cost": 30000, "defense": 16})
Repo.insert!(%Server.Armor{id: 7, "name": "Graphite Armor", "cost": 60000, "defense": 20})
Repo.insert!(%Server.Armor{id: 8, "name": "Edrick's Armor", "cost": 150000, "defense": 28})
Repo.insert!(%Server.Armor{id: 9, "name": "Armor of Death", "cost": 200000, "defense": 40})
Repo.insert!(%Server.Armor{id: 10, "name": "Able's Armor", "cost": 400000, "defense": 48})
Repo.insert!(%Server.Armor{id: 11, "name": "Full Body Armor", "cost": 1000000, "defense": 52})
Repo.insert!(%Server.Armor{id: 12, "name": "Blood Armor", "cost": 4000000, "defense": 64})
Repo.insert!(%Server.Armor{id: 13, "name": "Magic Ward", "cost": 10000000, "defense": 78})
Repo.insert!(%Server.Armor{id: 14, "name": "Belar's Mail", "cost": 40000000, "defense": 90})
Repo.insert!(%Server.Armor{id: 15, "name": "Golden Armor", "cost": 100000000, "defense": 120})
Repo.insert!(%Server.Armor{id: 16, "name": "Armor of Lore", "cost": 400000000, "defense": 200})

# Create Weapon Tables
Repo.delete_all Server.Weapon
Repo.insert!(%Server.Weapon{id: 1, "name": "Nothing", "cost": 0, "damage": 0})
Repo.insert!(%Server.Weapon{id: 2, "name": "Stick", "cost": 200, "damage": 1})
Repo.insert!(%Server.Weapon{id: 3, "name": "Dagger", "cost": 1000, "damage": 2})
Repo.insert!(%Server.Weapon{id: 4, "name": "Short Sword", "cost": 3000, "damage": 4})
Repo.insert!(%Server.Weapon{id: 5, "name": "Long Sword", "cost": 10000, "damage": 8})
Repo.insert!(%Server.Weapon{id: 6, "name": "Huge Axe", "cost": 30000, "damage": 16})
Repo.insert!(%Server.Weapon{id: 7, "name": "Bone Cruncher", "cost": 60000, "damage": 20})
Repo.insert!(%Server.Weapon{id: 8, "name": "Twin Swords", "cost": 150000, "damage": 28})
Repo.insert!(%Server.Weapon{id: 9, "name": "Power Axe", "cost": 200000, "damage": 40})
Repo.insert!(%Server.Weapon{id: 10, "name": "Able's Sword", "cost": 400000, "damage": 48})
Repo.insert!(%Server.Weapon{id: 11, "name": "Wan's Weapon", "cost": 1000000, "damage": 52})
Repo.insert!(%Server.Weapon{id: 12, "name": "Spear of Gold", "cost": 4000000, "damage": 64})
Repo.insert!(%Server.Weapon{id: 13, "name": "Crystal Shank", "cost": 10000000, "damage": 78})
Repo.insert!(%Server.Weapon{id: 14, "name": "Niras's Teeth", "cost": 40000000, "damage": 90})
Repo.insert!(%Server.Weapon{id: 15, "name": "Blood Sword", "cost": 100000000, "damage": 120})
Repo.insert!(%Server.Weapon{id: 16, "name": "Death Sword", "cost": 400000000, "damage": 200})

#Fill out the Entity Map for Monsters, etc
Repo.delete_all Server.EntityTypes
Repo.insert!(%Server.EntityTypes{"name": "Forest Creature"})

Repo.delete_all Server.Entity
Repo.insert!(%Server.Entity{
    name: "Rude Gnome",
    level: 1,
    strength: 1,
    endurance: 10,
    s_hit: "gethit2ml",
    s_die: "death_ml",
    health: 25,
    gold: 25,
    weapon: "Makeshift Makeshift"
})

Repo.insert!(%Server.Entity{
    name: "Decaying Skeleton",
    level: 1,
    strength: 1,
    endurance: 10,
    health: 25,
    gold: 50,
    s_hit: "skel_hit",
    s_atk: "skel_att1",
    s_die: "skel_die",
    weapon: "Fist"
})

Repo.insert!(%Server.Entity{
    name: "Giant Bat",
    level: 1,
    strength: 1,
    endurance: 10,
    gold: 5,
    health: 25,
    s_hit: "bat_hit",
    s_atk: "bat_att",
    s_die: "bat_die",
    weapon: "Fangs"
})

Repo.insert!(%Server.Entity{
    name: "Old Man",
    level: 1,
    strength: 1,
    endurance: 10,
    health: 25,
    gold: 250,
    s_hit: "gethit2ml",
    s_atk: "",
    s_die: "death_ml",
    s_miss: "",
    weapon: "Cane"
})

Repo.insert!(%Server.Entity{
    name: "Bran the Warrior",
    level: 1,
    strength: 3,
    endurance: 10,
    health: 50,
    gold: 150,
    s_hit: "gethit3mb",
    s_die: "death_mb",
    weapon: "Short Sword"
})



# Populate Classes
Repo.delete_all Server.Class
Repo.insert!(%Server.Class{id: 1, name: "Death Knight", description: ""})
Repo.insert!(%Server.Class{id: 2, name: "Thief", description: ""})
Repo.insert!(%Server.Class{id: 3, name: "Wizard", description: ""})

# Extra Extra
Repo.delete_all Server.News
Repo.insert!(%Server.News{body: "It's a sad state of affairs when there are no heros to speak of in the land.", posted_by: "A Villager"})
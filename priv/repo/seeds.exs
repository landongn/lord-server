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
    name: "a Rude Gnome",
    level: 1,
    strength: 6,
    endurance: 10,
    s_hit: "gethit2ml",
    s_die: "death_ml",
    health: 25,
    armor_value: 1,
    damage: 5,
    experience: 10,
    m_health: 25,
    m_mana: 25,
    gold: 25,
    death_msg: "You begin fumbling to keep hold of your weapon before it falls and hits the gnome and impales itself in his skull.As you lean in to remove your weapon, a foul stench erupts from the other end of him.  It's probably wise to move on, quickly.",
    kill_msg: "\"What a moron\", the Gnome blurts as he draws his blade from your gushing throat.",
    weapon: "Makeshift Shank"
})

Repo.insert!(%Server.Entity{
    name: "a decaying skeleton",
    level: 1,
    strength: 7,
    endurance: 10,
    health: 25,
    m_health: 25,
    m_mana: 25,
    gold: 50,
    armor_value: 1,
    damage: 3,
    experience: 2,
    s_hit: "skel_hit",
    s_atk: "skelatt1",
    s_die: "skel_die",
    death_msg: "The final blow knocks the entire ribcage of the skeleton tumbling off into the distance as it collapses into a pile of dusty bones.",
    kill_msg: "\"Yeehehehehe\", the skeleton laughs as it begins ripping your corpse to shreds. After a few moments, there's nothing left but your weapon, and your gold.",
    weapon: "Rusty Long Sword"
})

Repo.insert!(%Server.Entity{
    name: "a Giant Bat",
    level: 1,
    strength: 8,
    endurance: 10,
    armor_value: 1,
    damage: 2,
    gold: 5,
    m_health: 25,
    experience: 3,
    m_mana: 25,
    health: 25,
    s_hit: "bat_hit",
    s_atk: "bat_att",
    s_die: "bat_die",
    kill_msg: "The bat sinks its fangs into your jugular, popping open the artery. A fountain of blood flows from the wound as you slowly writhe on the ground, gasping your final breaths.",
    death_msg: "You snag the left wing of the bat with your right hand and yank the wing clean off. The creature flops around on the ground, in shock. You lean over it and crush its pathetic skull with your boot. ",
    weapon: "Fangs"
})

Repo.insert!(%Server.Entity{
    name: "an Old Man",
    level: 1,
    strength: 4,
    endurance: 10,
    health: 25,
    gold: 250,
    armor_value: 1,
    damage: 4,
    m_health: 25,
    experience: 8,
    m_mana: 25,
    death_msg: "As you lean in to strike, the old man clutches his chest and shouts \"Bedalia!\", before collapsing into a heap.",
    kill_msg: "\"Are you KIDDING me?\", you exclaim, moments before the man's Cane caves your skull in.  The Old Man seems to have forgotten what was happening.",
    s_hit: "gethit2ml",
    s_atk: "",
    s_die: "death_ml",
    s_miss: "",
    weapon: "Cane"
})

Repo.insert!(%Server.Entity{
    name: "Bran the Warrior",
    level: 1,
    strength: 7,
    endurance: 10,
    experience: 10,
    health: 50,
    m_health: 50,
    m_mana: 25,
    armor_value: 1,
    damage: 4,
    gold: 150,
    kill_msg: "\"Holy shit!\", an incredulous Bran stares at you, mouth agape. \"I did NOT think that would work!\".  You quietly die as Bran appears to be giving himself a high five.  How embarassing.",
    death_msg: "As you land a vicious blow to Bran's arm, he screams out \"You cheating bastard!\", and runs away.  He appears to have dropped his gold, which you nab before moving on, confused.",
    s_hit: "gethit3mb",
    s_die: "death_mb",
    weapon: "Short Sword"
})

Repo.insert!(%Server.Entity{
    name: "a spiderling",
    level: 1,
    strength: 4,
    endurance: 10,
    s_atk: "spid_att",
    s_die: "spid_die",
    s_hit: "spid_hit",
    s_miss: "spid_wlk",
    health: 25,
    armor_value: 1,
    damage: 3,
    experience: 10,
    m_health: 25,
    m_mana: 25,
    kill_msg: "In an instant, the tiny spider seems to disappear.  As you look around for that tiny rat bastard, you realize it, along with a half dozen other spiders, have crawled onto your back and injected you with toxins.  You messily expire as several other larger spiders head toward the kill.",
    death_msg: "A decisive crunch reverberates as you crush the spider with the palm of your gauntlet. Gross.",
    gold: 25,
    weapon: "Tiny Venomous Fangs"
})

Repo.insert!(%Server.Entity{
    name: "a fire beetle",
    level: 1,
    strength: 4,
    endurance: 10,
    s_atk: "beetlatt",
    s_die: "beetldie",
    s_hit: "beetlhit",
    s_miss: "beetlwlk",
    health: 25,
    armor_value: 2,
    kill_msg: "",
    death_msg: "",
    damage: 4,
    experience: 10,
    m_health: 25,
    kill_msg: "Somehow, a beetle the size of a football managed to kill a warrior.  A tiny, pathetic beetle. ",
    death_msg: "you grunt as your blade rips through the chitin of the beetle, severing it in twain. It squeals in stereo. ",
    m_mana: 25,
    gold: 25,
    weapon: "Glowing Mandible"
})

Repo.insert!(%Server.Entity{
    name: "a big rat",
    level: 1,
    strength: 1,
    endurance: 10,
    s_atk: "rat_att",
    s_die: "rat_die",
    s_hit: "rat_hit",
    s_miss: "rat_idl",
    health: 25,
    armor_value: 1,
    damage: 5,
    experience: 10,
    m_health: 25,
    m_mana: 25,
    kill_msg: "A confused rat stares at you as an adult person simply falls over backwards.  When you hit the ground, you somehow manage to impale yourself on a nearby post. Great job.",
    death_msg: "The rat squeals as you stab it through the skull.  You're one sick puppy. Maybe it's time to find something to kill that can defend itself? ",
    gold: 25,
    weapon: "Filthy Teeth"
})

Repo.insert!(%Server.Entity{
    name: "an orc pawn",
    level: 1,
    strength: 5,
    endurance: 10,
    s_atk: "orc_att",
    s_die: "orc_die",
    s_hit: "orc_hit",
    health: 45,
    armor_value: 1,
    damage: 1,
    experience: 10,
    m_health: 45,
    m_mana: 25,
    kill_msg: "As the orc pulls the spear out of your chest, he exclaims, \"The Legionnares will be pleased with this kill!\". The beast begins to scream and howl, alerting other nearby orcs.",
    death_msg: "\"The Legionnares will avenge my death!\", predicts the orc.  You bring your leg up to its hip to give you some leverage to pull it back out of the orcs chestplate when you stumble and bonk the orc in the forehead.",
    gold: 50,
    weapon: "Makeshift Spear"
})

Repo.insert!(%Server.Entity{
    name: "a black bear",
    level: 2,
    strength: 8,
    endurance: 20,
    s_atk: "bear_att",
    s_die: "bear_die",
    s_hit: "bear_hit",
    s_miss: "bear_idl",
    health: 45,
    armor_value: 2,
    damage: 4,
    experience: 20,
    m_health: 45,
    m_mana: 25,
    death_msg: "Blood pours out of the beast at an alarming rate as it falls to the ground, lifeless.",
    kill_msg: "The beast swipes across your chest, taking a significant portion of your ribcage along with it.",
    gold: 50,
    weapon: "Bear Claw"
})

Repo.insert!(%Server.Entity{
    name: "a Birdperson",
    level: 2,
    strength: 2,
    endurance: 20,
    s_atk: "aviakatt",
    s_die: "aviakatt",
    s_hit: "aviakhit",
    s_miss: "aviakhit",
    health: 80,
    armor_value: 2,
    damage: 6,
    experience: 20,
    m_health: 80,
    m_mana: 25,
    death_msg: "Birdperson takes a moment to look into your eye as your blade exits its gullet. \"Dick move.\", it says, as it slumps forward.",
    kill_msg: "Birdperson laughs as you fumble to put your entrails back into the gaping wound in your stomach.",
    gold: 50,
    weapon: "Staff"
})


# Populate Classes
Repo.delete_all Server.Class
Repo.insert!(%Server.Class{id: 1, name: "Death Knight", description: ""})
Repo.insert!(%Server.Class{id: 2, name: "Thief", description: ""})
Repo.insert!(%Server.Class{id: 3, name: "Wizard", description: ""})

Repo.delete_all Server.Master
Repo.insert!(%Server.Master{
    id: 1,
    name: "Halder",
    weapon: "Short Sword",
    rank: 1,
    health: 50,
    m_health: 50,
    armor: 5,
    damage: 4,
    defense: 10,
    strength: 10,
    s_att: "swing",
    s_die: "death_mb",
    s_hit: "gethit4l",
    s_miss: "",
    welcome_message: "",
    challenge_message: "Gee, your muscles are getting bigger than mine...",
    talk_message: "Hi there.  Although I may not look muscular, I ain't all that weak.  You cannot advance to another Master until you can best me in battle.  I don't really have any advice except wear a groin cup at all times.  I learned the hard way.",
    player_defeat: "Ha! Next time, aim for the groin! Halder taps his groin area, which makes a slightly metallic bong.",
    master_defeat: "You are truly a great warrior!"
})

Repo.insert!(%Server.Master{
    id: 2,
    name: "Barak",
    weapon: "Battle Axe",
    rank: 2,
    health: 100,
    m_health: 100,
    armor: 7,
    damage: 8,
    defense: 16,
    strength: 20,
    s_att: "swing",
    s_die: "death_mb",
    s_hit: "gethit3mb",
    s_miss: "",
    welcome_message: "",
    challenge_message: "You know, you are actually getting pretty good with that thing...",
    talk_message: "You are now level two, and a respected warrior. Try talking to the Bartender, he will see you now.  He is a worthy asset... Remember, your ultimate goal is to reach Ultimate Warrior status, which is level twelve.",
    player_defeat: "Another time, perhaps.",
    master_defeat: "You have bested me??!"
})

Repo.insert!(%Server.Master{
    id: 3,
    name: "Aragorn",
    weapon: "Twin Swords",
    rank: 3,
    health: 120,
    m_health: 120,
    armor: 10,
    damage: 15,
    defense: 18,
    strength: 25,
    s_att: "swing",
    s_die: "death_mb",
    s_hit: "gethit3mb",
    s_miss: "",
    welcome_message: "",
    challenge_message: "You have learned everything I can teach you",
    talk_message: "You are now level three, and you are actually becoming well known in the realm.  I heard your name being mentioned by Violet....",
    player_defeat: "Another time, perhaps.",
    master_defeat: "You have bested me??!"
})

Repo.insert!(%Server.Master{
    id: 4,
    name: "Olodrin",
    weapon: "Power Axe",
    rank: 4,
    health: 180,
    m_health: 180,
    armor: 15,
    damage: 22,
    defense: 25,
    strength: 35,
    s_att: "swing",
    s_die: "death_mb",
    s_hit: "gethit3mb",
    s_miss: "",
    welcome_message: "",
    challenge_message: "You're becoming a very skilled warrior.",
    talk_message: "You are now level four. But don't get cocky - There are many in the realm that could kick your...  Nevermind, I'm just not good at being insperational.",
    player_defeat: "Another time, perhaps.",
    master_defeat: "You have bested me??!"
})

Repo.delete_all Server.Level
Repo.insert!(%Server.Level{
    rank: 1,
    minimum: 3000,
    class_id: 1,
    str: 3,
    def: 3,
    health: 20,
    endurance: 10,
})
Repo.insert!(%Server.Level{
    rank: 2,
    minimum: 10000,
    class_id: 1,
    str: 3,
    def: 3,
    health: 30,
    endurance: 20,
})
Repo.insert!(%Server.Level{
    rank: 3,
    minimum: 20000,
    class_id: 1,
    str: 10,
    def: 10,
    health: 45,
    endurance: 20,
})

Repo.delete_all Server.Skill
Repo.insert!(%Server.Skill{
    name: "Warcry",
    attack_message: "You let loose a warcry! You'll do extra damage throughout this encounter.",
    class_id: 1,
    damage_modifier: 10,
    mana_cost: 10,
})

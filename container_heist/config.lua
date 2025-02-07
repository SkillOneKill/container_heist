Config = {}

Config.Containers = {
    {coords = vector3(987.6680, -3130.9883, 5.9008)}, -- Add more positions
    {coords = vector3(995.0612, -3131.0527, 5.9008)},
    {coords = vector3(999.6516, -3130.9478, 5.9008)},
    {coords = vector3(1007.0074, -3131.1282, 5.9008)},
    {coords = vector3(1011.2383, -3131.3933, 5.9008)},
    {coords = vector3(1024.0684, -3130.6460, 5.9008)},
    {coords = vector3(1036.3625, -3130.9692, 5.9008)},
    {coords = vector3(1040.5018, -3130.9875, 5.9008)},
    {coords = vector3(1048.4359, -3131.4548, 5.9008)},
    {coords = vector3(1060.6362, -3131.0850, 5.9008)},
    {coords = vector3(1068.3149, -3131.7161, 5.8999)},
    {coords = vector3(1064.2330, -3154.4812, 5.9008)},
    {coords = vector3(1043.8734, -3153.9097, 5.9008)},
    {coords = vector3(1031.9733, -3154.4841, 5.9008)},
    {coords = vector3(1027.7123, -3154.7769, 5.9008)}


}

Config.RequiredItem = "weapon_crowbar" -- Name of the crowbar in inventory

Config.Rewards = {
    items = { 
        {name = "money", amount = {500, 1000}}, 
        {name = "scrapmetal", amount = {1, 13}}, 
        {name = "gazbottle", amount = {1, 4}},    
        {name = "armour", amount = {1, 1}},
        {name = "garbage", amount = {1, 2}}, 
        {name = "weapon_pistol", amount = {1, 1}}, 
        {name = "diamond", amount = {1, 1}}
    },
    weapons = {
        {name = "WEAPON_PISTOL", amount = {1, 1}},
        {name = "WEAPON_SMG", amount = {1, 1}}
    }
}

Config.OpenChance = 65 -- Probability of success in percent
Config.OpenChanceWeapon = 65 --Probability of success in percent
Config.Cooldown = 1800 -- Cooldown in seconds per container
Config.OpenDuration = 18000 -- Duration of opening (milliseconds)

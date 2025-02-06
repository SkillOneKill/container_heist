Config = {}

Config.Containers = {
    {coords = vector3(987.6680, -3130.9883, 5.9008)}, -- Füge mehr Positionen hinzu
    {coords = vector3(995.0612, -3131.0527, 5.9008)},
    {coords = vector3(999.6516, -3130.9478, 5.9008)},
    {coords = vector3(1007.0074, -3131.1282, 5.9008)},
    {coords = vector3(1011.2383, -3131.3933, 5.9008)},
    {coords = vector3(1024.0684, -3130.6460, 5.9008)},
    {coords = vector3(1032.3889, -3131.2397, 5.9008)}

}

Config.RequiredItem = "weapon_crowbar" -- Name der Brechstange im Inventar

Config.Rewards = {
    items = { 
        {name = "money", amount = {500, 1000}}, 
        {name = "scrapmetal", amount = {1, 3}}, 
        {name = "gazbottle", amount = {1, 2}},    
        {name = "armour", amount = {1, 2}},
        {name = "garbage", amount = {1, 2}}, 
        {name = "weapon_pistol", amount = {1}}, 
        {name = "diamond", amount = {1, 2}},  
    }
}

Config.OpenChance = 75 -- Erfolgswahrscheinlichkeit in Prozent
Config.Cooldown = 1800 -- Cooldown in Sekunden pro Container
Config.OpenDuration = 90000 -- Dauer der Öffnung (Millisekunden)

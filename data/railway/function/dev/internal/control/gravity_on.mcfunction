scoreboard players set #gravity rw.dev 0
execute as @e[type=minecraft:minecart,tag=railway.dev.rider] run data merge entity @s {NoGravity:0b}
execute as @e[type=minecraft:chest_minecart,tag=railway.dev.cargo] run data merge entity @s {NoGravity:0b}
tellraw @s {"text": "[Railway test] Vanilla gravity enabled for comparison.", "color": "aqua"}

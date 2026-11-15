scoreboard players set #gravity rw.dev 1
execute as @e[type=minecraft:minecart,tag=railway.dev.rider] run data merge entity @s {NoGravity:1b}
execute as @e[type=minecraft:chest_minecart,tag=railway.dev.cargo] run data merge entity @s {NoGravity:1b}
tellraw @s {"text": "[Railway test] Vanilla gravity disabled (default).", "color": "aqua"}

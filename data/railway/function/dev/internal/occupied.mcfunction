scoreboard players set #occupied rw.dev 0
execute as @e[type=minecraft:minecart,tag=railway.dev.rider] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.dev 1
execute as @e[type=minecraft:chest_minecart,tag=railway.dev.cargo] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.dev 1

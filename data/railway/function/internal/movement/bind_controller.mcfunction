teleport @s @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1]
scoreboard players set @s rw.phase 0
scoreboard players set @s rw.speed 3
scoreboard players set @s rw.run 0
scoreboard players set @s rw.count 20
scoreboard players operation @s rw.epoch = #epoch rw.sys
tag @s add railway.active

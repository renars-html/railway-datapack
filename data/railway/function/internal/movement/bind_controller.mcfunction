teleport @s @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1]
scoreboard players set @s rw.phase 0
scoreboard players set @s rw.speed 3
scoreboard players set @s rw.run 0
scoreboard players operation @s rw.count = #expected rw.sys
scoreboard players operation @s rw.epoch = #epoch rw.sys
tag @s add railway.active
scoreboard players set @s rw.pos 0
scoreboard players set @s rw.vel 0
scoreboard players set @s rw.accel 50
scoreboard players set @s rw.brake 100
scoreboard players set @s rw.emerg 0

teleport @s @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1]
scoreboard players set @s rw.pos 0
scoreboard players set @s rw.phase 0
scoreboard players set @s rw.vel 0
scoreboard players set @s rw.run 0
scoreboard players set @s rw.override 0
scoreboard players set @s rw.station 0
scoreboard players set @s rw.remain 0
scoreboard players operation @s rw.cruise *= #old_factor rw.sys
scoreboard players operation @s rw.cruise /= #speed_factor rw.sys

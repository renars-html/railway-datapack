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
scoreboard players set @s rw.geom 0
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get @s rw.train
function railway:internal/geometry/forget_link with storage railway:scratch ctx

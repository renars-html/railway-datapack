scoreboard players set @s rw.run 0
scoreboard players set @s rw.vel 0
scoreboard players set @s rw.override 0
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get @s rw.train
function railway:internal/movement/reload_pause with storage railway:scratch ctx

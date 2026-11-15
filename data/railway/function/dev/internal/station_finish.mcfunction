scoreboard players set #station_job rw.sys 0
execute store result storage railway:scratch mark.id int 1 run scoreboard players get #mark_id rw.sys
execute store result storage railway:scratch mark.sample int 1 run scoreboard players get #best_index rw.sys
execute store result storage railway:scratch mark.profile int 1 run scoreboard players get #profile rw.sys
execute in minecraft:overworld at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] run function railway:dev/internal/save_station with storage railway:scratch mark

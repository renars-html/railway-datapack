$execute unless data storage railway:state trains.t$(id).route run return 0
scoreboard players set #inspect_speed rw.sys 0
scoreboard players set #inspect_phase rw.sys 0
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] run scoreboard players operation #inspect_speed rw.sys = @s rw.speed
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] run scoreboard players operation #inspect_phase rw.sys = @s rw.phase
execute store result storage railway:api result.speed_step int 1 run scoreboard players get #inspect_speed rw.sys
execute store result storage railway:api result.phase int 1 run scoreboard players get #inspect_phase rw.sys
tellraw @s [{"text":"[Railway] Movement speed step="},{"score":{"name":"#inspect_speed","objective":"rw.sys"}},{"text":"/8; progress sample="},{"score":{"name":"#inspect_phase","objective":"rw.sys"}},{"text":"/318 (0 speed means controller not loaded)."}]
return 1

$execute unless data storage railway:state trains.t$(id).route run return 0
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/movement/ensure_motion
scoreboard players set #inspect_speed rw.sys 0
scoreboard players set #inspect_phase rw.sys 0
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] run scoreboard players operation #inspect_speed rw.sys = @s rw.speed
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] run scoreboard players operation #inspect_phase rw.sys = @s rw.phase
execute store result storage railway:api result.speed_step int 1 run scoreboard players get #inspect_speed rw.sys
execute store result storage railway:api result.phase int 1 run scoreboard players get #inspect_phase rw.sys
tellraw @s [{"text":"[Railway] Target speed step="},{"score":{"name":"#inspect_speed","objective":"rw.sys"}},{"text":"/8; progress sample="},{"score":{"name":"#inspect_phase","objective":"rw.sys"}},{"text":"/318 (0 speed means controller not loaded)."}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.actual_blocks_per_second double 0.002494141775 run scoreboard players get @s rw.vel
tellraw @s [{"text":"[Railway] actual_blocks_per_second: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.actual_blocks_per_second","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.acceleration double 0.0498828355 run scoreboard players get @s rw.accel
tellraw @s [{"text":"[Railway] acceleration: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.acceleration","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.deceleration double 0.0498828355 run scoreboard players get @s rw.brake
tellraw @s [{"text":"[Railway] deceleration: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.deceleration","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.emergency int 1 run scoreboard players get @s rw.emerg
tellraw @s [{"text":"[Railway] emergency: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.emergency","interpret":false}]
return 1

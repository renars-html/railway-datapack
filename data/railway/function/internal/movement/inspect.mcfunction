$execute unless data storage railway:state trains.t$(id).route run return 0
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/geometry/ensure_controller
scoreboard players set #inspect_phase rw.sys 0
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] run scoreboard players operation #inspect_phase rw.sys = @s rw.phase
execute store result storage railway:api result.phase int 1 run scoreboard players get #inspect_phase rw.sys
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] run function railway:internal/geometry/report_controller
tellraw @s [{"text":"[Railway] actual_blocks_per_second: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.actual_blocks_per_second","interpret":false}]
tellraw @s [{"text":"[Railway] acceleration: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.acceleration","interpret":false}]
tellraw @s [{"text":"[Railway] deceleration: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.deceleration","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.emergency int 1 run scoreboard players get @s rw.emerg
tellraw @s [{"text":"[Railway] emergency: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.emergency","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.signal_blocked int 1 run scoreboard players get @s rw.signal
tellraw @s [{"text":"[Railway] Target blocks/s: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.target_blocks_per_second","interpret":false},{"text":"; station distance: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.station_remaining","interpret":false},{"text":"; signal blocked: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.signal_blocked","interpret":false}]
tellraw @s [{"text":"[Railway] Progress sample: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.phase","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.override int 1 run scoreboard players get @s rw.override
tellraw @s [{"text":"[Railway] Manual override: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.override","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.service_route int 1 run scoreboard players get @s rw.route
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.next_stop_index int 1 run scoreboard players get @s rw.stopidx
tellraw @s [{"text":"[Railway] Service route: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.service_route","interpret":false},{"text":"; next stop index: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.next_stop_index","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.geometry_path int 1 run scoreboard players get @s rw.geom
tellraw @s [{"text":"[Railway] Compiled geometry path: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.geometry_path","interpret":false}]
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.recovering int 1 run scoreboard players get @s rw.recover
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.resume_pending int 1 run scoreboard players get @s rw.resume
$execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] store result storage railway:api result.dwell_ticks int 1 run scoreboard players get @s rw.wait
tellraw @s [{"text":"[Railway] Recovery: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.recovering","interpret":false},{"text":"; pending run intent: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.resume_pending","interpret":false},{"text":"; dwell ticks left: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.dwell_ticks","interpret":false}]
return 1

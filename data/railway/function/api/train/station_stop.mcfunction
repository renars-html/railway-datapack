data modify storage railway:api result set value {ok:0b,error:"Use a saved station ID and dwell:1..12000."}
$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Invalid or unknown train ID. Use a positive integer ID printed by train creation.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0

$data modify storage railway:scratch station_request set value {station:$(station),dwell:$(dwell)}
scoreboard players set #station_id rw.sys 0
scoreboard players set #dwell rw.sys 0
execute store result score #station_id rw.sys run data get storage railway:scratch station_request.station
execute store result score #dwell rw.sys run data get storage railway:scratch station_request.dwell
execute unless score #station_id rw.sys matches 1..64 run return 0
execute unless score #dwell rw.sys matches 1..12000 run return 0
execute store result storage railway:scratch chosen.station int 1 run scoreboard players get #station_id rw.sys
execute store result storage railway:scratch chosen.dwell int 1 run scoreboard players get #dwell rw.sys
execute store result score #saved rw.sys run function railway:internal/movement/load_station with storage railway:scratch chosen
execute unless score #saved rw.sys matches 1 run return 0
return run function railway:internal/movement/plan_station with storage railway:scratch ctx

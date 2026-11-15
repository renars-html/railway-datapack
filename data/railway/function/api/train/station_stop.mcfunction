data modify storage railway:api result set value {ok:0b,error:"Use integer sample:0..317 and dwell:1..12000 (ticks)."}
$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Invalid or unknown train ID. Use a positive integer ID printed by train creation.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0

$data modify storage railway:scratch station_request set value {sample:$(sample),dwell:$(dwell)}
scoreboard players set #sample rw.sys -1
scoreboard players set #dwell rw.sys 0
execute store result score #sample rw.sys run data get storage railway:scratch station_request.sample
execute store result score #dwell rw.sys run data get storage railway:scratch station_request.dwell
execute unless score #sample rw.sys matches 0..317 run return 0
execute unless score #dwell rw.sys matches 1..12000 run return 0
execute store result storage railway:scratch station_canonical.sample int 1 run scoreboard players get #sample rw.sys
execute store result storage railway:scratch station_canonical.dwell int 1 run scoreboard players get #dwell rw.sys
execute store result score #valid rw.sys run function railway:internal/movement/check_station with storage railway:scratch station_canonical
execute unless score #valid rw.sys matches 1 run return 0
return run function railway:internal/movement/plan_station with storage railway:scratch ctx

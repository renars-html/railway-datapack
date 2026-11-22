data modify storage railway:api result set value {ok:0b,error:"Use a stopped, unoccupied bound train with no service route and a ready closed geometry path."}
$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Invalid or unknown train ID. Use a positive integer ID printed by train creation.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0

$data modify storage railway:scratch requested_path set value $(path)
scoreboard players set #geo_path rw.sys 0
execute store result score #geo_path rw.sys run data get storage railway:scratch requested_path
execute unless score #geo_path rw.sys matches 1..2147483646 run return 0
execute store result storage railway:scratch ctx.path int 1 run scoreboard players get #geo_path rw.sys
return run function railway:internal/geometry/assign with storage railway:scratch ctx

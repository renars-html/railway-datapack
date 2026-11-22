data modify storage railway:api result set value {ok:0b,error:"Use a stopped bound train and a ready route on the current geometry."}
$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Invalid or unknown train ID. Use a positive integer ID printed by train creation.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0

$data modify storage railway:scratch route_input set value $(route)
scoreboard players set #assign_route rw.sys 0
execute store result score #assign_route rw.sys run data get storage railway:scratch route_input
execute unless score #assign_route rw.sys matches 1..2147483646 run return 0
execute store result storage railway:scratch ctx.route int 1 run scoreboard players get #assign_route rw.sys
return run function railway:internal/routes/assign with storage railway:scratch ctx

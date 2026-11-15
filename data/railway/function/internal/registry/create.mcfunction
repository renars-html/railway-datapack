tag @s add railway.controller
scoreboard players operation @s rw.train = #selected rw.sys
$data modify storage railway:state trains.t$(id) set value {id:$(id),dimension:"minecraft:overworld",state:"unassigned",carts:[]}
$data modify storage railway:state trains.t$(id).owner set from storage railway:scratch owner
$data modify storage railway:state trains.t$(id).controller set from entity @s UUID
data modify storage railway:api result set value {ok:1b}
execute store result storage railway:api result.train int 1 run scoreboard players get #selected rw.sys

data modify storage railway:api result set value {ok:1b}
$data modify storage railway:api result.record set from storage railway:state trains.t$(id)
scoreboard players set #loaded rw.sys 0
execute in minecraft:overworld run function railway:internal/registry/count with storage railway:scratch ctx
execute store result storage railway:api result.loaded_carts int 1 run scoreboard players get #loaded rw.sys
data get storage railway:api result
return 1

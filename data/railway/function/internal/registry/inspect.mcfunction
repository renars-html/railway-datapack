data modify storage railway:api result set value {ok:1b}
$data modify storage railway:api result.record set from storage railway:state trains.t$(id)
scoreboard players set #loaded rw.sys 0
execute in minecraft:overworld run function railway:internal/registry/count with storage railway:scratch ctx
execute store result storage railway:api result.loaded_carts int 1 run scoreboard players get #loaded rw.sys
$execute store result score #registered rw.sys run data get storage railway:state trains.t$(id).carts
# Explicit chat output: command feedback inside functions can be suppressed.
tellraw @s [{"text":"[Railway] Train "},{"score":{"name":"#selected","objective":"rw.sys"}},{"text":": registered carts="},{"score":{"name":"#registered","objective":"rw.sys"}},{"text":", loaded carts="},{"score":{"name":"#loaded","objective":"rw.sys"}}]
tellraw @s [{"text":"[Railway] State: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.record.state","interpret":false}]
tellraw @s [{"text":"[Railway] Dimension: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.record.dimension","interpret":false}]
tellraw @s [{"text":"[Railway] Owner UUID: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.record.owner","interpret":false}]
tellraw @s [{"text":"[Railway] Controller UUID: "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.record.controller","interpret":false}]
tellraw @s [{"text":"[Railway] Ordered carts (UUID/index): "},{"type":"nbt","source":"storage","storage":"railway:api","nbt":"result.record.carts","interpret":false}]
function railway:internal/movement/inspect with storage railway:scratch ctx
return 1

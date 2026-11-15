# Operator test binding: uses the existing loop and registered carts, without spawning replacements.
data modify storage railway:api result set value {ok:0b,error:"Long-train binding refused."}
execute unless entity @s[type=minecraft:player,gamemode=creative] run return 0
execute unless dimension minecraft:overworld run return 0
$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Invalid or unknown train ID. Use a positive integer ID printed by train creation.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0

return run function railway:internal/movement/bind with storage railway:scratch ctx

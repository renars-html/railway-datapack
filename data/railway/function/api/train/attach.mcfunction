# Trusted operator API: execute AS the exact cart, pass {train:<integer>}.
data modify storage railway:api result set value {ok:0b,error:"Invalid train/cart, already registered, fixture cart, or train full (64)."}
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[type=minecraft:minecart] unless entity @s[type=minecraft:chest_minecart] run return 0
execute if entity @s[tag=railway.dev.cart] run return 0
execute if entity @s[tag=railway.cart] run return 0
execute if entity @s[scores={rw.train=1..}] run return 0

$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run return 0

return run function railway:internal/registry/attach with storage railway:scratch ctx

$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/recovery/cancel
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/movement/force_start
$data modify storage railway:state trains.t$(id).state set value "override"
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Emergency override: immediate maximum speed. Signals and station plans are bypassed. Normal start/stop restores normal operation.","color":"red"}
return 1

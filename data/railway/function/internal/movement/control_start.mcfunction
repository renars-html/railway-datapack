$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.override 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/movement/ensure_motion
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] unless score @s rw.epoch = #epoch rw.sys run function railway:internal/movement/reload_pause with storage railway:scratch ctx

execute in minecraft:overworld store result score #valid rw.sys run function railway:internal/movement/validate with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Start refused: missing member or invalid membership.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run scoreboard players operation @s rw.epoch = #epoch rw.sys
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.emerg 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.auto 1
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.run 1
$data modify storage railway:state trains.t$(id).state set value "running"
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Train started.","color":"aqua"}
return 1

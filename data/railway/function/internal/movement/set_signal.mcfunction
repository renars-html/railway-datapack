$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0
execute store result score #blocked rw.sys run data get storage railway:scratch signal.blocked
$scoreboard players operation @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.signal = #blocked rw.sys
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Signal stop reason updated. Start cannot override a blocked signal.","color":"aqua"}
return 1

$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0

$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.run 0
$data modify storage railway:state trains.t$(id).state set value "stopped"
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Train holding position.","color":"aqua"}
return 1

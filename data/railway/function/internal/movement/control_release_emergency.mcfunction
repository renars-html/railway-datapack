$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0

$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.emerg=1}] run return 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.emerg 0
$data modify storage railway:state trains.t$(id).state set value "stopped"
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Emergency released. Train remains stopped; use start.","color":"aqua"}
return 1

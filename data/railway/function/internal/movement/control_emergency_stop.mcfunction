$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0

$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.run 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.vel 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.emerg 1
$data modify storage railway:state trains.t$(id).state set value "emergency"
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Emergency stop. Use start to resume when safe; other stop reasons still apply.","color":"red"}
return 1

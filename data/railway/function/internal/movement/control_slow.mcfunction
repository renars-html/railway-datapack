$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0

$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] if score @s rw.speed matches 2.. run scoreboard players remove @s rw.speed 1
$scoreboard players operation #speed rw.dev = @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)},limit=1] rw.speed
function railway:dev/internal/speed_report
data modify storage railway:api result set value {ok:1b}
return 1

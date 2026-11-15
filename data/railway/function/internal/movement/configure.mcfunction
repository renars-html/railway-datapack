$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0

$scoreboard players operation @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.accel = #accel rw.sys
$scoreboard players operation @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.brake = #brake rw.sys
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Acceleration/deceleration configured in blocks/s² (rounded to ~0.05 increments). Inspect for effective settings.","color":"aqua"}
return 1

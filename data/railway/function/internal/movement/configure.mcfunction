$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0

$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.station=1..}] run tellraw @s {"text":"[Railway] Finish the station stop before changing motion settings.","color":"red"}
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.station=1..}] run return 0
$scoreboard players operation @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.accel = #accel rw.sys
$scoreboard players operation @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.brake = #brake rw.sys
$scoreboard players operation @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.cruise = #cruise rw.sys
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Speed, acceleration and deceleration configured: blocks/s; rates rounded to 0.5 and clamped to 2..5 blocks/s². Inspect for effective settings.","color":"aqua"}
return 1

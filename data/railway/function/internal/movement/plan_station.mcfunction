$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.geom=1..}] run tellraw @s {"text":"[Railway] Clear_path before using loop service/station snapshots. Branch station integration is the next layer.","color":"red"}
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.geom=1..}] run return 0
$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.route=1..}] run tellraw @s {"text":"[Railway] Stop and clear_route before manual station/profile changes; create another immutable service route for a different profile.","color":"red"}
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.route=1..}] run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/movement/ensure_motion
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.station=1..}] run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] store result score #armed rw.sys run function railway:internal/movement/arm_station
execute unless score #armed rw.sys matches 1 run tellraw @s {"text":"[Railway] Station too close for the configured braking rate. Stop first or request earlier.","color":"red"}
execute unless score #armed rw.sys matches 1 run return 0
tellraw @s {"text":"[Railway] Station stop armed; start if currently held.","color":"aqua"}
return 1

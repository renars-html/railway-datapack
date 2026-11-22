$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.route=1..}] run tellraw @s {"text":"[Railway] Stop and clear_route before manual station/profile changes; create another immutable service route for a different profile.","color":"red"}
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.route=1..}] run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/geometry/ensure_controller
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.station=1..}] run return 0
scoreboard players set #arm_geometry_ok rw.sys 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] if score @s rw.geom = #station_geometry rw.sys run scoreboard players set #arm_geometry_ok rw.sys 1
execute unless score #arm_geometry_ok rw.sys matches 1 run tellraw @s {"text":"[Railway] Station belongs to another geometry; use path_station_here for this path.","color":"red"}
execute unless score #arm_geometry_ok rw.sys matches 1 run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] store result score #armed rw.sys run function railway:internal/movement/arm_on_controller
execute unless score #armed rw.sys matches 1 run tellraw @s {"text":"[Railway] Station could not be armed; check geometry readiness.","color":"red"}
execute unless score #armed rw.sys matches 1 run return 0
tellraw @s {"text":"[Railway] Station stop armed; start if currently held.","color":"aqua"}
return 1

$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.route=1..}] run tellraw @s {"text":"[Railway] Clear_route before clearing its geometry path.","color":"red"}
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.route=1..}] run return 0
$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.vel=0,rw.run=0}] run return 0
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.geom=0}] run data modify storage railway:api result set value {ok:1b}
$execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.geom=0}] run return 1
scoreboard players set #occupied rw.sys 0
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.sys 1
execute unless score #occupied rw.sys matches 0 run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/geometry/clear_controller
$data remove storage railway:state trains.t$(id).geometry_path
data modify storage railway:api result set value {ok:1b}
return 1

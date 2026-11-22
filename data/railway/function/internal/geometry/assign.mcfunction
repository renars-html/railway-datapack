$execute unless data storage railway:scratch {requested_path:$(path)} run return 0
$execute unless data storage railway:geometry paths.p$(path){state:"ready"} run return 0
$execute store result score #geo_profile rw.sys run data get storage railway:geometry paths.p$(path).metadata.profile
execute unless score #geo_profile rw.sys = #base_profile rw.sys run return 0
$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.vel=0,rw.run=0,rw.route=0}] run return 0
scoreboard players set #occupied rw.sys 0
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.sys 1
execute unless score #occupied rw.sys matches 0 run return 0
execute store result score #valid rw.sys run function railway:internal/movement/validate with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run return 0
$execute store result score #geo_count rw.sys run data get storage railway:geometry paths.p$(path).metadata.count
scoreboard players operation #geo_footprint rw.sys = #expected rw.sys
scoreboard players operation #geo_footprint rw.sys *= #offset rw.dev
execute if score #geo_footprint rw.sys > #geo_count rw.sys run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/geometry/assign_controller with storage railway:scratch ctx
$data modify storage railway:state trains.t$(id).geometry_path set value $(path)
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Shared geometry assigned and held. Switches set for this circuit; use start.","color":"aqua"}
return 1

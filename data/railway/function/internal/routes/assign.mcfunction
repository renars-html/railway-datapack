$execute unless data storage railway:routes routes.r$(route){state:"ready"} run return 0
$execute store result score #route_profile rw.sys run data get storage railway:routes routes.r$(route).profile
execute unless score #route_profile rw.sys = #profile rw.sys run return 0
$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.vel=0,rw.run=0}] run return 0
execute store result score #valid rw.sys run function railway:internal/movement/validate with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run return 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run function railway:internal/routes/assign_controller with storage railway:scratch ctx
$data modify storage railway:state trains.t$(id).service_route set value $(route)
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Shared route assigned. Use start for automatic ordered station service.","color":"aqua"}
return 1

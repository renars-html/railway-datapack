$execute unless data storage railway:state trains.t$(id).controller run return 0
$data modify storage railway:scratch recovery_controller set from storage railway:state trains.t$(id).controller
execute store success score #recovery_changed rw.sys run data modify storage railway:scratch recovery_controller set from entity @s UUID
execute unless score #recovery_changed rw.sys matches 0 run return 0
scoreboard players set #recovery_count rw.sys 0
$execute as @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run scoreboard players add #recovery_count rw.sys 1
execute unless score #recovery_count rw.sys matches 1 run return 0
execute if data storage railway:loading lease unless data storage railway:loading lease{complete:1b} run return 0
execute if score @s rw.route matches 1.. run return run function railway:internal/recovery/service_ready
return 1

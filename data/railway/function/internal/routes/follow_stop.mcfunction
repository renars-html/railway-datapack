$execute unless data storage railway:routes routes.r$(route){state:"ready"} run return run function railway:internal/routes/runtime_fault
$execute store result score #route_profile rw.sys run data get storage railway:routes routes.r$(route).profile
execute unless score #route_profile rw.sys = #profile rw.sys run return run function railway:internal/routes/runtime_fault
execute unless score @s rw.station matches 0 run return 1
$execute store result score #sample rw.sys run data get storage railway:routes routes.r$(route).stops[$(index)].sample
$execute store result score #dwell rw.sys run data get storage railway:routes routes.r$(route).dwell
function railway:internal/movement/arm_station
return 1

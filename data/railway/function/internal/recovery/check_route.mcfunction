$execute unless data storage railway:routes routes.r$(route){state:"ready"} run return 0
$execute store result score #recovery_profile rw.sys run data get storage railway:routes routes.r$(route).profile
execute unless score #recovery_profile rw.sys = #base_profile rw.sys run return 0
scoreboard players set #recovery_geometry rw.sys 0
$execute if data storage railway:routes routes.r$(route).geometry store result score #recovery_geometry rw.sys run data get storage railway:routes routes.r$(route).geometry
execute unless score #recovery_geometry rw.sys = @s rw.geom run return 0
return run function railway:internal/recovery/cache_ready with entity @s data.railway

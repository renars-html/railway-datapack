function railway:internal/recovery/cancel
teleport @s @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1]
$scoreboard players set @s rw.geom $(path)
scoreboard players set @s rw.pos 0
scoreboard players set @s rw.phase 0
scoreboard players set @s rw.vel 0
scoreboard players set @s rw.station 0
scoreboard players set @s rw.remain 0
scoreboard players set @s rw.override 0
scoreboard players set @s rw.auto 0
$data modify entity @s data.path_geometry set from storage railway:geometry paths.p$(path).metadata
execute store result score #switch_mode rw.sys run data get entity @s data.path_geometry.switch_mode
function railway:internal/geometry/set_switches
function railway:internal/geometry/read_selected_factor
scoreboard players set @s rw.cruise 7500000
scoreboard players operation @s rw.cruise /= #selected_factor rw.sys

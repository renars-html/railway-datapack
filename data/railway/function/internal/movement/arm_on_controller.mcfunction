execute unless score @s rw.geom = #station_geometry rw.sys run return 0
scoreboard players set #armed rw.sys 0
function railway:internal/geometry/restore_base
function railway:internal/geometry/prepare_controller
execute if score #geo_valid rw.sys matches 1 store result score #armed rw.sys run function railway:internal/movement/arm_station
function railway:internal/geometry/restore_base
return run scoreboard players get #armed rw.sys

scoreboard players set #profile rw.sys 0
execute if data storage railway:dev route_revision store result score #profile rw.sys run data get storage railway:dev route_revision
execute unless data storage railway:dev {route_profile:1} run function railway:dev/internal/path_small_load
execute if data storage railway:dev {route_profile:1} run function railway:dev/internal/path_large_load
function railway:internal/geometry/save_base
execute unless score #mark_path rw.sys matches 0.. run scoreboard players set #mark_path rw.sys 0
execute unless score #mark_length rw.sys matches 1..8192 run scoreboard players operation #mark_length rw.sys = #base_length rw.sys

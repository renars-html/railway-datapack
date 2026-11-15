scoreboard players set #profile rw.sys 0
execute if data storage railway:dev route_revision store result score #profile rw.sys run data get storage railway:dev route_revision
execute unless data storage railway:dev {route_profile:1} run function railway:dev/internal/path_small_load
execute if data storage railway:dev {route_profile:1} run function railway:dev/internal/path_large_load

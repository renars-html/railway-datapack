execute if score #mark_path rw.sys matches 0 run function railway:dev/internal/mark_base_point with storage railway:scratch scan
execute if score #mark_path rw.sys matches 1.. run function railway:dev/internal/mark_path_point with storage railway:scratch scan
execute store result score #dx rw.sys run data get storage railway:scratch point.x 100
execute store result score #dz rw.sys run data get storage railway:scratch point.z 100
scoreboard players operation #dx rw.sys -= #mark_x rw.sys
scoreboard players operation #dz rw.sys -= #mark_z rw.sys
scoreboard players operation #dx rw.sys *= #dx rw.sys
scoreboard players operation #dz rw.sys *= #dz rw.sys
scoreboard players operation #dx rw.sys += #dz rw.sys
execute if score #dx rw.sys < #best_distance rw.sys run scoreboard players operation #best_index rw.sys = #scan rw.sys
execute if score #dx rw.sys < #best_distance rw.sys run scoreboard players operation #best_distance rw.sys = #dx rw.sys

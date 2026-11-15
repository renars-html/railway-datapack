$data modify storage railway:scratch point set from storage railway:dev_path frames[$(index)]
execute store result score #dx rw.sys run data get storage railway:scratch point.x 100
execute store result score #dz rw.sys run data get storage railway:scratch point.z 100
scoreboard players operation #dx rw.sys -= #mark_x rw.sys
scoreboard players operation #dz rw.sys -= #mark_z rw.sys
scoreboard players operation #dx rw.sys *= #dx rw.sys
scoreboard players operation #dz rw.sys *= #dz rw.sys
scoreboard players operation #dx rw.sys += #dz rw.sys
execute if score #dx rw.sys < #best_distance rw.sys run scoreboard players operation #best_index rw.sys = #scan rw.sys
execute if score #dx rw.sys < #best_distance rw.sys run scoreboard players operation #best_distance rw.sys = #dx rw.sys

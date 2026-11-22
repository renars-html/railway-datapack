$execute store result score #from rw.sys run data get storage railway:routes jobs.j$(route).draft.stops[$(index)].sample
$execute store result score #to rw.sys run data get storage railway:routes jobs.j$(route).draft.stops[$(next)].sample
scoreboard players operation #from rw.sys *= #thousand rw.sys
scoreboard players operation #to rw.sys *= #thousand rw.sys
scoreboard players operation #to rw.sys -= #from rw.sys
scoreboard players operation #to rw.sys %= #fine_length rw.sys
execute if score #to rw.sys matches ..0 run scoreboard players operation #to rw.sys += #fine_length rw.sys
$execute store result storage railway:routes jobs.j$(route).draft.stops[$(index)].distance_to_next int 1 run scoreboard players get #to rw.sys
scoreboard players operation #from rw.sys -= #cruise_distance rw.sys
scoreboard players operation #from rw.sys %= #fine_length rw.sys
execute if score #from rw.sys matches ..-1 run scoreboard players operation #from rw.sys += #fine_length rw.sys
$execute store result storage railway:routes jobs.j$(route).draft.stops[$(index)].center_braking_point int 1 run scoreboard players get #from rw.sys

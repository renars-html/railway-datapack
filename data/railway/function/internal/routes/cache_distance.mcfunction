scoreboard players operation #cache_distance rw.sys = #cache_v rw.sys
execute if score #cache_v rw.sys matches 0 run return 0
scoreboard players operation #k rw.sys = #cache_v rw.sys
scoreboard players remove #k rw.sys 1
scoreboard players operation #k rw.sys /= #cache_brake rw.sys
scoreboard players operation #tmp rw.sys = #k rw.sys
scoreboard players operation #tmp rw.sys *= #cache_v rw.sys
scoreboard players operation #cache_distance rw.sys += #tmp rw.sys
scoreboard players operation #tmp rw.sys = #k rw.sys
scoreboard players add #tmp rw.sys 1
scoreboard players operation #tmp rw.sys *= #k rw.sys
scoreboard players operation #tmp rw.sys /= #two rw.sys
scoreboard players operation #tmp rw.sys *= #cache_brake rw.sys
scoreboard players operation #cache_distance rw.sys -= #tmp rw.sys

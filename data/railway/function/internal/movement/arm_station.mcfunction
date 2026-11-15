scoreboard players operation #distance rw.sys = #sample rw.sys
scoreboard players operation #distance rw.sys *= #thousand rw.sys
scoreboard players operation #center_offset rw.sys = @s rw.count
scoreboard players remove #center_offset rw.sys 1
scoreboard players operation #center_offset rw.sys *= #offset rw.dev
scoreboard players operation #center_offset rw.sys *= #thousand rw.sys
scoreboard players operation #center_offset rw.sys /= #two rw.sys
scoreboard players operation #distance rw.sys += #center_offset rw.sys
scoreboard players operation #distance rw.sys -= @s rw.pos
scoreboard players operation #distance rw.sys %= #fine_length rw.sys
execute if score #distance rw.sys matches ..0 run scoreboard players operation #distance rw.sys += #fine_length rw.sys
scoreboard players operation #candidate rw.sys = @s rw.vel
function railway:internal/movement/braking_distance
execute if score #stopping rw.sys > #distance rw.sys run function railway:internal/movement/skip_close_station
scoreboard players operation @s rw.remain = #distance rw.sys
scoreboard players operation @s rw.dwell = #dwell rw.sys
scoreboard players set @s rw.station 1
data modify storage railway:api result set value {ok:1b}
return 1

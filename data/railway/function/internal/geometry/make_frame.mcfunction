data modify storage railway:geometry_work frame set value {}
data modify storage railway:geometry_work frame.yaw set from storage railway:geometry_work segment.yaw
scoreboard players operation #geo_local rw.sys = #geo_distance rw.sys
scoreboard players operation #geo_local rw.sys -= #geo_seg_start rw.sys
$scoreboard players set #geo_a rw.sys $(ax)
$scoreboard players set #geo_d rw.sys $(ux)
scoreboard players operation #geo_d rw.sys *= #geo_local rw.sys
scoreboard players operation #geo_d rw.sys /= #thousand rw.sys
scoreboard players operation #geo_a rw.sys += #geo_d rw.sys
execute store result storage railway:geometry_work frame.ax int 1 run scoreboard players get #geo_a rw.sys
execute store result storage railway:geometry_work frame.x double 0.0001 run scoreboard players get #geo_a rw.sys
$scoreboard players set #geo_a rw.sys $(ay)
$scoreboard players set #geo_d rw.sys $(uy)
scoreboard players operation #geo_d rw.sys *= #geo_local rw.sys
scoreboard players operation #geo_d rw.sys /= #thousand rw.sys
scoreboard players operation #geo_a rw.sys += #geo_d rw.sys
execute store result storage railway:geometry_work frame.ay int 1 run scoreboard players get #geo_a rw.sys
execute store result storage railway:geometry_work frame.y double 0.0001 run scoreboard players get #geo_a rw.sys
$scoreboard players set #geo_a rw.sys $(az)
$scoreboard players set #geo_d rw.sys $(uz)
scoreboard players operation #geo_d rw.sys *= #geo_local rw.sys
scoreboard players operation #geo_d rw.sys /= #thousand rw.sys
scoreboard players operation #geo_a rw.sys += #geo_d rw.sys
execute store result storage railway:geometry_work frame.az int 1 run scoreboard players get #geo_a rw.sys
execute store result storage railway:geometry_work frame.z double 0.0001 run scoreboard players get #geo_a rw.sys

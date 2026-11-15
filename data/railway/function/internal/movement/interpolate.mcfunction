$data modify storage railway:motion a set from storage railway:dev_path frames[$(frame)]
$data modify storage railway:motion b set from storage railway:dev_path frames[$(next)]
data modify storage railway:motion target set from storage railway:motion a
execute store result score #a rw.sys run data get storage railway:motion a.x 10000
execute store result score #b rw.sys run data get storage railway:motion b.x 10000
scoreboard players operation #b rw.sys -= #a rw.sys
scoreboard players operation #b rw.sys *= #fraction rw.sys
scoreboard players operation #b rw.sys /= #thousand rw.sys
scoreboard players operation #b rw.sys += #a rw.sys
execute store result storage railway:motion target.x double 0.0001 run scoreboard players get #b rw.sys
execute store result score #a rw.sys run data get storage railway:motion a.y 10000
execute store result score #b rw.sys run data get storage railway:motion b.y 10000
scoreboard players operation #b rw.sys -= #a rw.sys
scoreboard players operation #b rw.sys *= #fraction rw.sys
scoreboard players operation #b rw.sys /= #thousand rw.sys
scoreboard players operation #b rw.sys += #a rw.sys
execute store result storage railway:motion target.y double 0.0001 run scoreboard players get #b rw.sys
execute store result score #a rw.sys run data get storage railway:motion a.z 10000
execute store result score #b rw.sys run data get storage railway:motion b.z 10000
scoreboard players operation #b rw.sys -= #a rw.sys
scoreboard players operation #b rw.sys *= #fraction rw.sys
scoreboard players operation #b rw.sys /= #thousand rw.sys
scoreboard players operation #b rw.sys += #a rw.sys
execute store result storage railway:motion target.z double 0.0001 run scoreboard players get #b rw.sys
function railway:dev/internal/apply with storage railway:motion target

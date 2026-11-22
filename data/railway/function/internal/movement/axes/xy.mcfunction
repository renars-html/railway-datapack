# Compiled slope kernel: xy
execute store result score #a rw.sys run data get storage railway:motion target.ax
execute store result score #b rw.sys run data get storage railway:motion target.dx
scoreboard players operation #b rw.sys *= #fraction rw.sys
scoreboard players operation #b rw.sys /= #thousand rw.sys
scoreboard players operation #b rw.sys += #a rw.sys
execute store result storage railway:motion target.x double 0.0001 run scoreboard players get #b rw.sys
execute store result score #a rw.sys run data get storage railway:motion target.ay
execute store result score #b rw.sys run data get storage railway:motion target.dy
scoreboard players operation #b rw.sys *= #fraction rw.sys
scoreboard players operation #b rw.sys /= #thousand rw.sys
scoreboard players operation #b rw.sys += #a rw.sys
execute store result storage railway:motion target.y double 0.0001 run scoreboard players get #b rw.sys

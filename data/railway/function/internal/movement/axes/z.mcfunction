# Compiled slope kernel: z
execute store result score #a rw.sys run data get storage railway:motion target.az
execute store result score #b rw.sys run data get storage railway:motion target.dz
scoreboard players operation #b rw.sys *= #fraction rw.sys
scoreboard players operation #b rw.sys /= #thousand rw.sys
scoreboard players operation #b rw.sys += #a rw.sys
execute store result storage railway:motion target.z double 0.0001 run scoreboard players get #b rw.sys

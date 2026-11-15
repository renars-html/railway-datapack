execute if score #spawn_index rw.sys >= #total rw.sys run return 1
scoreboard players operation #grid_x rw.sys = #spawn_index rw.sys
scoreboard players operation #grid_x rw.sys %= #eight rw.sys
scoreboard players operation #grid_x rw.sys *= #two rw.sys
scoreboard players operation #grid_z rw.sys = #spawn_index rw.sys
scoreboard players operation #grid_z rw.sys /= #eight rw.sys
scoreboard players operation #grid_z rw.sys *= #two rw.sys
scoreboard players add #grid_z rw.sys 2
execute store result storage railway:scratch spawn.x int 1 run scoreboard players get #grid_x rw.sys
execute store result storage railway:scratch spawn.z int 1 run scoreboard players get #grid_z rw.sys
scoreboard players operation #kind_normal rw.sys = #normal rw.sys
execute if score #kind_normal rw.sys matches 1.. run function railway:internal/composition/normal with storage railway:scratch spawn
execute if score #kind_normal rw.sys matches 0 run function railway:internal/composition/chest with storage railway:scratch spawn
execute unless score #spawn_bad rw.sys matches 0 run return 0
scoreboard players add #spawn_index rw.sys 1
return run function railway:internal/composition/next

execute if score #chunk_z rw.sys > #max_z rw.sys run return 1
scoreboard players operation #block_x rw.sys = #chunk_x rw.sys
scoreboard players operation #block_z rw.sys = #chunk_z rw.sys
scoreboard players operation #block_x rw.sys *= #sixteen rw.sys
scoreboard players operation #block_z rw.sys *= #sixteen rw.sys
execute store result storage railway:scratch chunk.x int 1 run scoreboard players get #block_x rw.sys
execute store result storage railway:scratch chunk.z int 1 run scoreboard players get #block_z rw.sys
function railway:internal/loading/add with storage railway:scratch chunk
scoreboard players add #chunk_x rw.sys 1
execute if score #chunk_x rw.sys > #max_x rw.sys run function railway:internal/loading/next_row
return run function railway:internal/loading/add_next

execute if score #release_index rw.sys >= #lease_count rw.sys run return 1
execute store result storage railway:scratch release.index int 1 run scoreboard players get #release_index rw.sys
function railway:internal/loading/read_ticket with storage railway:scratch release
scoreboard players add #release_index rw.sys 1
return run function railway:internal/loading/remove_next

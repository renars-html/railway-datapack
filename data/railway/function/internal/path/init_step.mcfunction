function railway:internal/path/read_cursor with storage railway:graph active_job
$execute store result score #pf_length rw.sys run data get storage railway:graph graphs.g$(graph).node_ids
execute if score #pf_cursor rw.sys >= #pf_length rw.sys run return run function railway:internal/path/init_done with storage railway:graph active_job
function railway:internal/path/node_at with storage railway:path_work ctx
function railway:internal/path/init_node with storage railway:path_work ctx
scoreboard players add #pf_cursor rw.sys 1
$execute store result storage railway:graph jobs.j$(path).cursor int 1 run scoreboard players get #pf_cursor rw.sys
scoreboard players remove #pf_budget rw.sys 1
execute if score #pf_budget rw.sys matches 1.. run function railway:internal/path/init_step with storage railway:graph active_job

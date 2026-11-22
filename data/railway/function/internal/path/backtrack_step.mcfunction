function railway:internal/path/read_cursor with storage railway:graph active_job
execute if score #pf_cursor rw.sys matches 64.. run return run function railway:internal/path/fail with storage railway:graph active_job
$data modify storage railway:path_work ctx.node set from storage railway:graph jobs.j$(path).back_node
function railway:internal/path/backtrack_node with storage railway:path_work ctx
execute if score #pf_finished rw.sys matches 1 run return run function railway:internal/path/leg_done with storage railway:graph active_job
scoreboard players add #pf_cursor rw.sys 1
$execute store result storage railway:graph jobs.j$(path).cursor int 1 run scoreboard players get #pf_cursor rw.sys
scoreboard players remove #pf_budget rw.sys 1
execute if score #pf_budget rw.sys matches 1.. run function railway:internal/path/backtrack_step with storage railway:graph active_job

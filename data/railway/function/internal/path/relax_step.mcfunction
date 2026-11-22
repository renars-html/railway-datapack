function railway:internal/path/read_cursor with storage railway:graph active_job
$data modify storage railway:path_work ctx.node set from storage railway:graph jobs.j$(path).best
function railway:internal/path/outgoing_count with storage railway:path_work ctx
execute if score #pf_cursor rw.sys >= #pf_length rw.sys run return run function railway:internal/path/relax_done with storage railway:graph active_job
function railway:internal/path/read_edge with storage railway:path_work ctx
function railway:internal/path/relax_edge with storage railway:path_work ctx
scoreboard players add #pf_cursor rw.sys 1
$execute store result storage railway:graph jobs.j$(path).cursor int 1 run scoreboard players get #pf_cursor rw.sys
scoreboard players remove #pf_budget rw.sys 1
execute if score #pf_budget rw.sys matches 1.. run function railway:internal/path/relax_step with storage railway:graph active_job
